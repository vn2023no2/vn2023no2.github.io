---
sidebar_position: 11
---

# CloudWatch Exporter

## 1. Overview
Có 2 cách cài đặt CloudWatch Exporter
- YACE: thường cài đặt trên EC2 - có automatic discovery.
- CloudWatch Exporter: thường cài đặt trên EKS - có official helm chart.

Ngoài ra với ECS, thì có một repo để chuyên export các metric của ECS (https://github.com/prometheus-community/ecs_exporter).

## 2. YACE - Yet Another CloudWatch Exporter

YACE là một Prometheus exporter viết bằng Go, thu thập metrics từ AWS CloudWatch với khả năng **auto-discovery theo tags**, scrape song song và cấu hình linh hoạt.

`References:` [yet-another-cloudwatch-exporter](https://github.com/prometheus-community/yet-another-cloudwatch-exporter)

---

### Yêu cầu

- EC2 instance (Amazon Linux 2 / Ubuntu)
- IAM Role có quyền đọc CloudWatch

---

### 1. Cấp quyền IAM

Tạo và gắn policy sau vào EC2 instance role (nếu EC2 sử dụng role, thì các service chạy trên EC2 mặc định sử dụng role này):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "tag:GetResources",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
        "apigateway:GET",
        "aps:ListWorkspaces",
        "autoscaling:DescribeAutoScalingGroups",
        "dms:DescribeReplicationInstances",
        "dms:DescribeReplicationTasks",
        "ec2:DescribeTransitGatewayAttachments",
        "ec2:DescribeSpotFleetRequests",
        "shield:ListProtections",
        "storagegateway:ListGateways",
        "storagegateway:ListTagsForResource",
        "iam:ListAccountAliases"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```
Hoặc có thể gán policy này vào role và đưa role này vào cấu hình của YACE. 
Nhưng cần đảm bảo role của EC2 (nếu EC2 sử dụng role) có quyền assume role này (sts:AssumeRole) và role này có Trust Policy cho phép EC2 role assume.     
---

### 2. Tải YACE binary

```bash
YACE_VERSION=0.63.0

mkdir -p /opt/yace && cd /opt/yace

wget https://github.com/prometheus-community/yet-another-cloudwatch-exporter/releases/download/v${YACE_VERSION}/yet-another-cloudwatch-exporter-${YACE_VERSION}.linux-amd64.tar.gz \
  -O yace.tar.gz

tar -xzf yace.tar.gz
sudo chmod +x yace
sudo mv yace /usr/local/bin/yace

yace --version
```

---

### 3. Tạo file cấu hình

```bash
mkdir -p /etc/yace

cat > /etc/yace/config.yml << 'EOF'
apiVersion: v1alpha1
discovery:
  exportedTagsOnMetrics:
    AWS/EC2:
      - Name
    AWS/RDS:
      - Name
  jobs:
    - type: AWS/EC2
      regions:
        - ap-southeast-1
      searchTags:
        - key: Environment
          value: production
      metrics:
        - name: CPUUtilization
          statistics: [Average]
          period: 60
          length: 300

    - type: AWS/RDS
      regions:
        - ap-southeast-1
      metrics:
        - name: DatabaseConnections
          statistics: [Average]
          period: 60
          length: 300
        - name: FreeStorageSpace
          statistics: [Average]
          period: 60
          length: 300
EOF
```

Hoặc nếu sử dụng assume role
```bash
cat > /etc/yace/config.yml << 'EOF'
apiVersion: v1alpha1
discovery:
  exportedTagsOnMetrics:
    AWS/EC2:
      - Name
    AWS/RDS:
      - Name
  jobs:
    - type: AWS/EC2
      regions:
        - ap-southeast-1
      roles:
        - roleArn: "arn:aws:iam::1111111111111:role/prometheus" # newspaper
        - roleArn: "arn:aws:iam::2222222222222:role/prometheus" # radio
        - roleArn: "arn:aws:iam::3333333333333:role/prometheus" # television
      searchTags:
        - key: Environment
          value: production
      metrics:
        - name: CPUUtilization
          statistics: [Average]
          period: 60
          length: 300

    - type: AWS/RDS
      regions:
        - ap-southeast-1
      roles:
        - roleArn: "arn:aws:iam::1111111111111:role/prometheus" # newspaper
        - roleArn: "arn:aws:iam::2222222222222:role/prometheus" # radio
        - roleArn: "arn:aws:iam::3333333333333:role/prometheus" # television
      metrics:
        - name: DatabaseConnections
          statistics: [Average]
          period: 60
          length: 300
        - name: FreeStorageSpace
          statistics: [Average]
          period: 60
          length: 300
EOF
```

---

### 4. Tạo systemd service

```bash
cat > /etc/systemd/system/yace.service << 'EOF'
[Unit]
Description=YACE - Yet Another CloudWatch Exporter
After=network.target

[Service]
ExecStart=/usr/local/bin/yace --config.file=/etc/yace/config.yml --listen-address=:5000
Restart=always
User=nobody

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now yace
sudo systemctl status yace
```

---

### 5. Kiểm tra

```bash
curl http://localhost:5000/metrics
```

---

### 6. Cấu hình Prometheus scrape

Thêm vào `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: yace
    static_configs:
      - targets: ['<ec2-private-ip>:5000']
```

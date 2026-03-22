---
sidebar_position: 12
---

# AWS command

## Cài đặt AWS CLI

```bash
# macOS
brew install awscli

# Windows
winget install Amazon.AWSCLI

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
```

Kiểm tra phiên bản:

```bash
aws --version
```

## Cấu hình

```bash
aws configure
# AWS Access Key ID: <access_key>
# AWS Secret Access Key: <secret_key>
# Default region name: ap-southeast-1
# Default output format: json
```

Cấu hình nhiều profile:

```bash
aws configure --profile <profile_name>
aws s3 ls --profile <profile_name>
```

List tất cả profiles:

```bash
aws configure list-profiles
```

Đổi profile đang dùng:

```bash
# Linux/macOS
export AWS_PROFILE=<profile_name>

# Windows CMD
set AWS_PROFILE=<profile_name>

# Windows PowerShell
$env:AWS_PROFILE="<profile_name>"
```

Kiểm tra profile hiện tại:
```
aws configure list
```
or
```bash
aws sts get-caller-identity
```

## S3

```bash
# Liệt kê bucket
aws s3 ls

# Liệt kê nội dung bucket
aws s3 ls s3://<bucket-name>/

# Upload file
aws s3 cp <file> s3://<bucket-name>/

# Download file
aws s3 cp s3://<bucket-name>/<file> ./

# Sync thư mục
aws s3 sync ./ s3://<bucket-name>/

# Xóa file
aws s3 rm s3://<bucket-name>/<file>
```

## EC2

```bash
# Liệt kê instances
aws ec2 describe-instances

# Start / Stop instance
aws ec2 start-instances --instance-ids <instance-id>
aws ec2 stop-instances --instance-ids <instance-id>

# Liệt kê key pairs
aws ec2 describe-key-pairs
```

## IAM

```bash
# Liệt kê users
aws iam list-users

# Liệt kê roles
aws iam list-roles

# Xem thông tin user hiện tại
aws sts get-caller-identity
```

## CloudFormation

```bash
# Deploy stack
aws cloudformation deploy \
  --template-file template.yaml \
  --stack-name <stack-name>

# Liệt kê stacks
aws cloudformation list-stacks

# Xóa stack
aws cloudformation delete-stack --stack-name <stack-name>
```

## Lambda

```bash
# Liệt kê functions
aws lambda list-functions

# Invoke function
aws lambda invoke \
  --function-name <function-name> \
  --payload '{"key": "value"}' \
  response.json

# Update code
aws lambda update-function-code \
  --function-name <function-name> \
  --zip-file fileb://function.zip
```

## Logs (CloudWatch)

```bash
# Liệt kê log groups
aws logs describe-log-groups

# Xem log events
aws logs get-log-events \
  --log-group-name <group-name> \
  --log-stream-name <stream-name>

# Tail logs
aws logs tail <log-group-name> --follow
```
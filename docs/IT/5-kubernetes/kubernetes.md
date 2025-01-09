---
sidebar_position: 1
---

# Các chiến lược deploy trong Kubernetes

Có hai strategy cơ bản thường được sử dụng - đây là các strategy được hỗ trợ khi config qua YAML file trong K8S:

- Recreating - Shutdown old version and create a new version. 
- Rolling - Những version mới sẽ được tạo và thay thế version cũ một cách từ từ, từng cái một (đây là default strategy).

Các chiến lược sau đây được coi là "Chiến lược triển khai nâng cao" vì lưu lượng truy cập có thể được kiểm soát theo nhiều cách khác nhau:

- Blue/Green - Version mới sẽ tồn tại cùng với version cũ.
- Canary - Deploy version mới cho 1 lượng nhỏ end-user, nếu không có vấn đề thì update toàn bộ.
- A/B testing - Deploy version mới cho 1 lượng nhỏ end-user dựa vào điều kiện như (HTTP header, cookie, …)
- ...

# HPA
- HPA sclale theo giá trị sử dụng trung bình của pod để duy trì mức sử dụng resource trung bình theo target.    

```
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: demo
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: demo
  minReplicas: 3
  maxReplicas: 9
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```


# Service Discovery
Service Discovery là một thuật ngữ chỉ cách các ứng dụng tự động phát hiện địa chỉ của nhau thông qua Service.    
Service Discovery trong Kubernetes    
Ta sẽ có hai cách sau để các ứng dụng trong Pod phát hiện được service:   
- Phát hiện thông qua biến môi trường (ENV)
- Phát hiện thông qua DNS Lookup.

`Reference:`   
https://spacelift.io/blog/kubernetes-deployment-strategies         
https://blog.cloud-ace.vn/cac-chien-luoc-trien-khai-kubernetes/       


# Các metrics của cụm K8S đến từ đâu
## kube-state-metrics
Kube-state-metrics tạo ra các metric về trạng thái kubernetes object bao gồm cronjob, configmap, pods và node từ Kubernetes API. Công cụ này cho chúng ta nắm bắt tổng thể hệ thống kubernetes về trạng thái, ví dụ: số lượng mong muốn pod replicas cho 1 deployment hoặc tổng số lượng CPU còn sẵn trên 1 node.         
Đây là một resource được triển khai trên k8s, expose ở `http://service-name:8080/metrics`   
Một số metrics
```
kube_pod_status_phase
kube_pod_info
kube_pod_container_status_restarts_total
```
## cAdvisor
cAdvisor được embedded trong kubelet, expose ở :10250/metrics/cadvisor, là agent phân tích hiệu suất và sử dụng tài nguyên của container, nó được tích hợp trong kubelet. cAdvisor auto-discover tất cả container trong docker host và thống kê về memory, network, filesystem, CPU.
Một số metrics
```
container_cpu_usage_seconds_total
```
...

`Reference:`      
https://lazyadmin.vn/cac-cong-cu-giam-sat-he-thong-kubernetes/            





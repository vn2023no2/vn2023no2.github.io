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




# Service Discovery


`Reference:`   
https://spacelift.io/blog/kubernetes-deployment-strategies         
https://blog.cloud-ace.vn/cac-chien-luoc-trien-khai-kubernetes/               





---
sidebar_position: 3
---

Authentication ==> Service Account (authentication qua token, đây là cách authentication duy nhất được quản lý bởi K8S). Ngoài ra bạn có thể dùng các `external service` để xác thực với Cluster.      
Authorization  ==> RBAC (Role Based Access Control)        

```
2 loại client ==> humans (user) ==> kubectl      
                                ==> HTTP Request với token    

              ==> Pod           ==> Service Account      
```                          

# Authentication
Chúng ta cần phân biệt 2 loại user được định nghĩa trong k8s `service account` và `normal user`
- normal user: đại diện cho user của người dùng, xác thực với K8S Cluster bằng dịch vụ bên ngoài (có thể xác thực bằng private key, username và password, OAuth service, ...)
- service account: thường dùng cho process chạy trong pod. Dùng resource `service account` của k8s để authentication - đây là dịch vụ authentication được cung cấp bởi K8s và xác thực bằng token.

Lưu ý: Có thể mọi người không đồng ý sử dụng Service Account cho `normal user`, nhưng chưa thấy bất kỳ tài liệu nào của K8S viết rằng không nên sử dụng cho `normal user`. Vì vậy, tôi nghĩ chúng ta có thể sử dụng `Service Account` để tạo user cho việc sử dụng `kubectl` hoặc `HTTP Request`.

## Service Account
- Service Account là một resource của k8s
- Service Account được sử dụng cho pod sẽ được mount vào pod ở path `/var/run/secrets/kubernetes.io/serviceaccount` 


# Role Based Access Control

RBAC có 4 loại resources ==> Roles: định nghĩa verb nào có thể được thực hiện lên trên namespace resource.
                         ==> ClusterRoles: định nghĩa verb nào có thể được thực hiện lên trên cluster resource.
                         ==> RoleBindings: gán Roles tới một SA.
                         ==> ClusterRoleBindings: gán ClusterRoles tới SA.


`References:`    
https://spacelift.io/blog/kubernetes-rbac       
https://www.linkedin.com/pulse/create-user-kubernetes-kubectl-service-account-vikash-kumar-singh       
https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/      
https://kubernetes.io/docs/reference/access-authn-authz/authentication/      
https://www.strongdm.com/blog/kubernetes-authentication    





























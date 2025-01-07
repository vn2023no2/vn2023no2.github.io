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

Cả `normal user` và `service account` đều phải thuộc một hoặc nhiều group. Có 4 loại group mặc định là 
- system:unauthenticated - được gán cho user không authenticated thành công.
- system:authenticated - được gán cho user authenticated thành công.
- system:serviceaccounts - group cho toàn bộ ServiceAccounts.   
- system:serviceaccounts:<namespace> - group cho toàn bộ ServiceAccounts trong một namespace.   


## Service Account
- Service Account là một resource của k8s.
- Service Account được sử dụng cho pod sẽ được mount vào pod ở path `/var/run/secrets/kubernetes.io/serviceaccount`. Mặc định mỗi namespace đều có 1 service acocunt là `default` và khi pod được tạo thì sẽ sử dụng service account này.
- 


# Role Based Access Control
Nếu như service account và các `external service` chỉ dùng để authentication thì Role Based Access Control sẽ giúp chúng ta việc Authorization cho các `normal user` hoặc `pod`.

## Action
Các action có thể thực hiện với RBAC thì như sau
| Action    | Verb   |
| --------- | ------ |
| HEAD, GET | get    |
| POST      | create |
| PUT       | update |
| PATCH     | patch  |
| DELETE    | delete |  

## Các resource để định nghĩa RBAC

RBAC có 4 loại resources ==> Roles: định nghĩa verb nào có thể được thực hiện lên trên namespace resource, sẽ thuộc namespace.     
                         ==> ClusterRoles: định nghĩa verb nào có thể được thực hiện lên trên cluster resource, không thuộc bất kỳ một namespace nào.    
                         ==> RoleBindings: gán Roles tới một Service Account hoặc user.   
                         ==> ClusterRoleBindings: gán ClusterRoles tới một Service Account hoặc user.     

# Ví dụ



`References:`    
https://spacelift.io/blog/kubernetes-rbac       
https://www.linkedin.com/pulse/create-user-kubernetes-kubectl-service-account-vikash-kumar-singh       
https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/      
https://kubernetes.io/docs/reference/access-authn-authz/authentication/      
https://www.strongdm.com/blog/kubernetes-authentication    





























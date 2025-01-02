---
sidebar_position: 3
---

Authentication ==> Service Account     
Authorization  ==> RBAC (Role Based Access Control)     

```
2 loại client ==> humans (user) ==> kubectl      
                                ==> HTTP Request với token    

              ==> Pod           ==> Service Account      
```                          

# Service Account
- Service Account là một resource của k8s
- Service Account sẽ được mount vào pod ở path `/var/run/secrets/kubernetes.io/serviceaccount` 


# Role Based Access Control

RBAC có 4 loại resources ==> Roles: định nghĩa verb nào có thể được thực hiện lên trên namespace resource.
                         ==> ClusterRoles: định nghĩa verb nào có thể được thực hiện lên trên cluster resource.
                         ==> RoleBindings: gán Roles tới một SA.
                         ==> ClusterRoleBindings: gán ClusterRoles tới SA.


`References:`    
https://spacelift.io/blog/kubernetes-rbac    



























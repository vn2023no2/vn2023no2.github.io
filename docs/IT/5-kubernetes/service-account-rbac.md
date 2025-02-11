---
sidebar_position: 3
---

Authentication (xác thực) ==> Sử dụng Service Account (authentication qua token, đây là cách authentication duy nhất được quản lý bởi K8S) hoặc có thể dùng các `external service` để xác thực với K8S Cluster.      
Authorization (phân quyền)  ==> Sử dụng RBAC (Role Based Access Control).        


# Authentication
```
2 loại user   ==> normal user                  ==> kubectl      
                  (humans user)                ==> HTTP Request với token    

              ==> service account user         ==> Service Account
                  (dùng cho Pod)      
```                          

Chúng ta cần phân biệt 2 loại user được định nghĩa trong k8s `service account user` và `normal user`:
- normal user: đại diện cho user của người dùng, xác thực với K8S Cluster bằng dịch vụ bên ngoài (có thể xác thực bằng private key, username và password, OAuth service, ...). Người dùng thường tương tác K8S Cluster bằng việc sử dụng `kubectl` hoặc `HTTP Request`.      
- service account user: thường dùng cho process chạy trong pod. Dùng resource `service account` của k8s để authentication - đây là dịch vụ authentication được cung cấp bởi K8S và xác thực bằng token.

Lưu ý: Có thể mọi người không đồng ý sử dụng `Service Account resource` cho `normal user`, nhưng chưa thấy bất kỳ tài liệu nào của K8S viết rằng không nên sử dụng cho `normal user`. Vì vậy, tôi nghĩ chúng ta có thể sử dụng `Service Account resource` để tạo user cho việc sử dụng `kubectl` hoặc `HTTP Request`.

Cả `normal user` và `service account user` đều phải thuộc một hoặc nhiều group. Có 4 loại group mặc định là 
- system:unauthenticated - được gán cho user không authenticated thành công.
- system:authenticated - được gán cho user authenticated thành công.
- system:serviceaccounts - group cho toàn bộ ServiceAccounts.   
- system:serviceaccounts:\<namespace\>  - group cho toàn bộ ServiceAccounts trong một namespace.   


## Service Account
- Service Account là một resource của k8s.
- Service Account này là một namespace resouce, nghĩa là chỉ có scope bên trong một namespace, ta không thể dùng ServiceAccount của namespace này cho một namespace khác được.   
- Service Account được sử dụng cho pod sẽ được mount vào pod ở path `/var/run/secrets/kubernetes.io/serviceaccount`. Mặc định mỗi namespace đều có 1 service acocunt là `default` và khi pod được tạo thì sẽ sử dụng service account này.


# Authorization (Role Based Access Control)
Nếu như service account và các `external service` chỉ dùng để authentication thì Role Based Access Control trong K8S sẽ giúp chúng ta việc Authorization cho các `normal user` hoặc `service account user`.

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
### Ví dụ về việc sử dụng ServiceAccount, Role, RoleBinding để tạo user trong K8S    
**Đảm bảo rằng RBAC đã được enabled**    
```
$ kubectl api-versions | grep rbac
rbac.authorization.k8s.io/v1
```

**Tạo một Service Account resource**    
```
# ServiceAccount
apiVersion: v1
kind: ServiceAccount
metadata:
  name: demo-user-sa
  namespace: default
```

Apply vào K8S
```
kubectl apply -f demo-user-sa.yaml
```


**Tạo role**     
Cấu hình role bên dưới cho phép thực hiện các hành động `get, list, create, update` đối với pods.
Chi tiết:
- apiGroup: [""] - điều này nghĩa là role áp dụng cho các tài nguyên [core API](https://miro.medium.com/v2/resize:fit:1400/1*IqxBLalz8WP4ZJBM8uyx9g.png) của Kubernetes như: pod, service, deployment, ...
- resources: [pods] - chỉ định cụ thể loại resource mà role này áp dụng là pod, nếu không chỉ định resources thì Role sẽ áp dụng cho tất cả resouces trong core API.
- verbs: [get, list, create, update] - đơn này là chỉ định các loại action mà role này có thể sử dụng.
```
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: demo-role
  namespace: default
rules:
  - apiGroups:
      - ""
    resources:
      - pods
    verbs:
      - get
      - list
      - create
      - update
```
Apply vào K8S
```
kubectl apply -f demo-role.yaml
```


**Tạo RoleBinding để gán Role cho ServiceAccount**     
Role đã được tạo nhưng chưa được gán cho ServiceAccount. Vì vậy, phải tạo RoleBinding để gán Role cho ServiceAcocunt.   
Trong phần định nghĩa của RoleBinding, chúng ta quan tâm 2 thông tin:
- `roleRef` - Xác định `Role` sẽ được gán.
- `subjects` - Danh sách một hoặc nhiều `user` hoặc `ServiceAccount` để chỉ định `Role`.
Cấu hình bên dưới gán Role `demo-role` cho ServiceAccount `demo-user-sa`.
```
# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: demo-role-binding
  namespace: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: demo-role
subjects:
  - namespace: default
    kind: ServiceAccount
    name: demo-user

```
Apply vào K8S
```
kubectl apply -f demo-role-binding.yaml
```

**Tiếp theo, chúng ta sẽ tiến hành lấy token của ServiceAccount vừa tạo để cấu hình context cho kubectl**      
Đầu tiên, lấy token của ServiceAccount đã tạo
```
$ TOKEN=$(kubectl create token demo-user-sa)
```

Tiếp theo, thêm ServiceAccount là thông tin xác thực của của context
```
$ kubectl config set-credentials demo-user --token=$TOKEN
User "demo-user" set.
```

Tiến hành tạo `context`
```
$ kubectl config set-context demo-user-context --cluster=default --user=demo-user
Context "demo-user-context" created.
```

Trước khi chuyển sang `context` mới, hãy kiểm tra `context` đang sử dụng
```
$ kubectl config current-context
default
```

Chuyển từ `context` hiện tạo sang `context` vừa tạo
```
$ kubectl config use-context demo-user-context
Switched to context "demo-user-context".
```

OK, bây giờ bạn có thể sử dụng `context` mới để list Pod trong namespace `default`
```
$ kubectl get pods
```

Chúng ta sẽ thử list một resource mà chưa được phân quyền    
```
$ kubectl get pods
Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:demo-user-sa" cannot list resource "pods" in API group "" in the namespace "default"
```
Chúng ta sẽ nhận được lỗi như trên.

`References:`    
https://spacelift.io/blog/kubernetes-rbac       
https://www.linkedin.com/pulse/create-user-kubernetes-kubectl-service-account-vikash-kumar-singh       
https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/      
https://kubernetes.io/docs/reference/access-authn-authz/authentication/      
https://www.strongdm.com/blog/kubernetes-authentication    





























---
sidebar_position: 4
---

# 1. Stiky session?
Sticky sessions, còn được gọi là session affinity, là một khái niệm quan trọng trong loadbalancer , đảm bảo các yêu cầu của người dùng trong một phiên luôn được chuyển hướng đến cùng một máy chủ. Kỹ thuật này rất quan trọng trong các tình huống mà dữ liệu phiên được lưu trữ cục bộ trên từng máy chủ.   

# 2. Enabled sticky session trong kubernetes   
Trong kubernetes có 2 cách để có thể cấu hình được sticky session.
## 2.1 Enabled ở service  
Cấu hình ở tầng service chỉ hoạt động ở layer 4 (TCP/UDP) nên chỉ có thể định tuyến dựa trên IP của Client và thường phù hợp cho các dịch vụ truy cập trực tiếp vào kubernetes qua service được cấu hình type là `ClusterIP` hoặc `LoadBalancer` vì cần đảm bảo IP mà service nhận được là IP của Client.
Cần đảm bảo các property nào có trong cấu hình của service.
```
# The following adds session affinity
sessionAffinity: ClientIP
sessionAffinityConfig:
clientIP:
    timeoutSeconds: 600 
```

Ví dụ:
```
kind: Service
apiVersion: v1
metadata:
  name: myservice
spec:
  selector:
    app: myapp
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 80
  # The following adds session affinity
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 600 
```

## 2.2 Enabled ở ingress  
Không giống như `Service`, `Ingress` hoạt động ở layer 7 (HTTP) vì thế các bạn có thể định tuyến traffic dự trên HTTP session, paths, headers, ...
Để cấu hình Sticky Session ở ingress, cần đảm bảo các annotations sau có trong ingress   
```
nginx.ingress.kubernetes.io/affinity: "cookie" 
nginx.ingress.kubernetes.io/session-cookie-name: "route" 
nginx.ingress.kubernetes.io/session-cookie-max-age: "172800" 
```

`nginx.ingress.kubernetes.io/affinity: "cookie"` - loại affinity, để là `cookie` để bật sticky session.    
`nginx.ingress.kubernetes.io/session-cookie-name: "route"` - tên của cookie (mặc định là `INGRESSCOOKIE`).     
`nginx.ingress.kubernetes.io/session-cookie-max-age: "172800"` - thời gian cookie expired (second).     

Một số các annotations khác để cấu hình stick session cho ingress bạn có thể xem ở [đây](https://kubernetes.github.io/ingress-nginx/examples/affinity/cookie/)

Mặc dù cấu hình sticky session đem lại nhiều lợi ích nhưng nó cũng có thể gây ra tình trạng một Pod sử dụng nhiều resource hơn các pod còn lại khi các request từ client bị kẹt session ở pod này. Tưởng tượng khi bạn khởi động lại các pod và pod đầu tiên running sẽ nhận một lượng lớn request từ Client và sau đó các request từ Client này sẽ chỉ vào Pod đầu tiên dẫn đến Pod này sử dụng nhiều resource hơn các pod còn lại.

Vì thế đây cũng là một vấn đề các bạn cần cân nhắc khi sử dụng stick session.

`References:`      
https://docs.mirantis.com/mke/3.8/ops/deploy-apps-k8s/nginx-ingress/configure-sticky-session.html     
https://pauldally.medium.com/session-affinity-and-kubernetes-proceed-with-caution-8e66fd5deb05     
https://kubernetes.github.io/ingress-nginx/examples/affinity/cookie/    
https://dev.to/danielepolencic/sticky-sessions-and-canary-releases-in-kubernetes-5a92    


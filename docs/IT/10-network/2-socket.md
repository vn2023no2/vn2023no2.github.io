---
sidebar_position: 2
---

Bài viết này chỉ đơn giản giúp các bạn hiểu rõ về socket và các khái niệm liên quan.    

# Socket là gì?

Socket dịch nôm na là ổ cắm mạng.
**Về mặt physical**
Các bạn có thể hiểu các ổ cắm mạng trên các máy tính là các socket.    

**Về mặt logical**
Socket là một khái niệm quan trọng trong CNTT, là cách cho phép các ứng dụng giao tiếp với nhau. Nó là điểm cuối (end-point) trong liên kết truyền thông hai chiều (two-way communication) biểu diễn kết nối giữa Client – Server.    

Tưởng tượng rằng giữa các ứng dụng hay process chạy trên mạng hay máy tính cần có một liên kết để chúng có thể nói chuyện với nhau. Điểm cuối của liên kết này gọi là socket.    

Trong ngữ cảnh thông thường khi nói đến socket thì chúng sẽ hiểu là đang nói đến "network socket" và khi đó socket được đại diện bởi IP và port.  
Ngoài ra, có một số loại socket không cần sử dụng IP và port như `unix socket` (sử dụng địa chỉ file trên hệ thống để giao tiếp trong cùng một máy tính với nhau): tiêu biểu cho loại này có thể kể đến các ứng dụng như Docker sử dụng file `/var/run/docker.sock`, MySQL sử dụng file `/var/run/mysql/mysql.sock`, ...

Cấu trúc và thuộc tính của socket được định nghĩa bởi Socket API lập trình lên nó.    

Trong ngữ cảnh hẹp hơn là lập trình mạng, khi nói đến socket, cũng có thể hiểu là đang nói đến socket API - nó là một `giao diện lập trình ứng dụng (API)` cung cấp các hàm, cấu trúc dữ liệu ... cho phép các lập trình viên lập trình các ứng dụng tạo, kết nối và quản lý các kết nối mạng trong mạng máy tính.      

Các nội dung bên dưới sẽ đề cập đến khái niệm socket trong ngữ cảnh thông thường tức "network socket".   
# Một số đặc điểm của socket   
- Socket hoạt động ở tầng 4 trong mô hình OSI

# Các loại socket   
Có 2 loại socket chính là:
- socket stream (được sử dụng với TCP). 
- socket datagram (được sử dụng với UDP).
Ngoài ra còn có một số loại socket khác như: WebSocket, Unix Socket.



`References:`
https://www.digitalocean.com/community/tutorials/understanding-sockets    

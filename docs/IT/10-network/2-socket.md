---
sidebar_position: 2
---

Bài viết này chỉ đơn giản giúp các bạn hiểu rõ về socket và các khái niệm liên quan.    
"bốc phét về socket"

# 1. Socket là gì?

Socket dịch nôm na là ổ cắm.
**Về mặt physical**
Các bạn có thể hiểu các ổ cắm trên bất kỳ thiết bị nào (thường là các thiết bị điện) để nối các thiết bị khác vào là các socket.    
Socket CPU (là nơi để cắm CPU vào mainboard)

**Về mặt logical (IT)**
Socket là một khái niệm quan trọng trong CNTT, là cách cho phép các ứng dụng giao tiếp với nhau. Nó là điểm cuối (end-point) trong liên kết truyền thông hai chiều (two-way communication) biểu diễn kết nối giữa Client – Server.    

Tưởng tượng rằng giữa các ứng dụng hay process chạy trên mạng hay máy tính cần có một liên kết để chúng có thể nói chuyện với nhau. Điểm cuối của liên kết này gọi là socket.    

Trong ngữ cảnh thông thường khi nói đến socket thì chúng sẽ hiểu là đang nói đến "network socket" (gồm stream socket và datagram socket) và khi đó socket được đại diện bởi IP, port và protocol.  
```
Socket = IP + Port + Protocol
```
Ngoài ra, có một số loại socket không cần sử dụng IP và port như `unix socket` (sử dụng địa chỉ file trên hệ thống để giao tiếp trong cùng một máy tính với nhau): tiêu biểu cho loại này có thể kể đến các ứng dụng như Docker sử dụng file `/var/run/docker.sock`, MySQL sử dụng file `/var/run/mysql/mysql.sock`, ...

Cấu trúc và thuộc tính của socket được định nghĩa bởi Socket API lập trình lên nó.    

Trong ngữ cảnh hẹp hơn là lập trình mạng, khi nói đến socket, cũng có thể hiểu là đang nói đến socket API - nó là một `giao diện lập trình ứng dụng (API)` cung cấp các hàm, cấu trúc dữ liệu ... cho phép các lập trình viên lập trình các ứng dụng tạo, kết nối và quản lý các kết nối mạng trong mạng máy tính.      

# Một số đặc điểm của socket   
- Socket thường hoạt động ở tầng 4 trong mô hình OSI (network socket).  
- Có nhiều loại socket và cũng có nhiều cách phân loại socket như: phân loại theo hướng kết nối, phân loại theo OS, ...

# 2. Các loại socket   
Có 2 loại socket chính là:
- stream socket - được sử dụng với TCP protocol.   
- datagram socket - được sử dụng với UDP protocol.          

Ngoài ra còn có một số loại socket khác như: 
- WebSocket - Là một giao thức truyền tin dựa trên kết nối TCP, được thiết kế để tạo ra kết nối hai chiều và tương tác giữa `web browser` và `server`. Chúng cung cấp khả năng giao tiếp hiệu quả và thời gian thực hơn so với các phương thức truyền thống như HTTP. Không như socket thông thường, WebSocket hoạt động ở Layer 7 trong mô hình OSI.    
- Unix Socket - Sử dụng địa chỉ file trên hệ thống để giao tiếp trong cùng một máy tính với nhau thay vì network.       
- ...

# 3. Thực hành  
Các nội dung bên dưới sẽ đề cập đến khái niệm socket trong ngữ cảnh thông thường tức "network socket".   
Đảm bảo rằng có bạn có một môi trường Linux và đã cài đặt sẵn các lệnh `netstat`, `nc`, `socat` để có thể thực hành các nội dung bên dưới.       
Nếu chưa cài đặt thì các bạn có thể chạy lệnh bên dưới để tiến hành cài đặt (Đối với Ubuntu)
```
sudo apt install net-tools netcat socat
```
## Tạo Stream Socket
Tạo một TCP socket listen ở cổng 8181
```
$ socat TCP4-LISTEN:8181,fork /dev/null&
[1] 31835
```
Trong đó:
- `fork` - option này đảm bảo rằng tiến trình vừa được tạo ra bởi lệnh socat sẽ tiếp tục LISTEN sau khi xử lý kết nối. 
- `/dev/null` - option này đảm bảo linux sẽ xóa mọi output được in ra bởi lệnh socat.
- `&` - yêu cầu linux chạy lệnh socat trên ở background.

Các bạn có thể kiểm tra Socket đã được tạo với lệnh netstat
```
$ netstat -tulpn | grep 8181
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
. . .
tcp        0      0 0.0.0.0:8181            0.0.0.0:*               LISTEN      31835/socat
. . .
```
Sử dụng netcat để test connection tới TCP socket đã tạo
```
$ nc -vz 127.0.0.1 8181
Connection to 127.0.0.1 8181 port [tcp/*] succeeded!
```
## Tạo Datagram Socket
Tạo một UDP socket listen ở cổng 8181
```
$ socat UDP4-LISTEN:8181,fork /dev/null&
[1] 31936
```
Ở đây, vì mỗi network socket được phân biệt với nhau bằng IP, port và giao thức nên chúng ta có thể tiếp tục sử dụng port 8181 cho giao thức UDP mà không bị xung đột.        
Các bạn có thể kiểm tra Socket đã được tạo với lệnh netstat
```
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
. . .
udp        0      0 0.0.0.0:8181            0.0.0.0:*                           4049/socat
. . .
```
Sử dụng netcat để test connection tới TCP socket đã tạo
```
$ nc -vz -u 127.0.0.1 8181
Connection to 127.0.0.1 8181 port [udp/*] succeeded!
```
`-u` - option này để yêu cầu netcat sử dụng `UDP` thay vì `TCP`.
Để dọn dẹp các socket vừa tạo, các bạn có thể sử dụng lệnh `kill -15 <PID>`. Ở đây mình sẽ xóa 2 socket vừa tạo 
```
kill -15 31835 31936
```
Các bạn nhớ thay bằng `<PID>` của tiến trình socket các bạn đã tạo nhé!!!       
`References:`      
https://www.digitalocean.com/community/tutorials/understanding-sockets    

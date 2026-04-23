---
sidebar_position: 1
---

# Network
- The **TCP protocol** is connection-oriented and stateful. It establishes a connection between two devices (usually a client and a server) and maintains a continuous communication channel until the connection is terminated.    
- TCP stateful theo nghĩa giao thức:
  - TCP duy trì state của connection:
    - 3-way handshake (SYN, SYN-ACK, ACK)
    - Sequence number, acknowledgment number
    - Connection states: SYN_SENT, ESTABLISHED, FIN_WAIT...   

**→ Đây là stateful ở tầng giao thức (Layer 4)**

- **Security Group** trên AWS là một stateful service theo nghĩa firewall.
  - Security Group dùng connection tracking để:
  - Nhớ connection nào đã được allow
  - Tự động cho phép response traffic      

**→ Đây là stateful ở tầng firewall**

Điều này cho phép bạn chỉ cần mở một `Outbound` rule một địa chỉ cụ thể ra bên ngoài và tất cả lưu lượng trả về sẽ được phép đi vào (thông qua một kênh đã được tạo) mà không cần mở `Inbound` rule.         

Khi cần chủ động gọi ra ngoài hoặc cho phép gọi vào thì bạn cần mở một `Outbound` hoặc `Inbound` khác.      

**NACL (Network Access Control List)**
Định nghĩa:   
- Là stateless firewall hoạt động ở subnet level
- Kiểm soát traffic vào/ra subnet
- Mỗi subnet associate với 1 NACL
- 1 NACL có thể apply cho nhiều subnet

NACL là stateless nên cần mở kết nối cả 2 chiều:   
```
NACL - phải define cả 2 chiều:
Inbound:  Allow TCP 80 from 0.0.0.0/0
Outbound: Allow TCP 1024-65535 to 0.0.0.0/0  ← bắt buộc phải có
```

# Subnet

x.x.x.255 - đây là địa chỉ broadcat
x.x.x.252 - thường đây là địa chỉ trang quản trị trong dải subnet
`Reference:`   

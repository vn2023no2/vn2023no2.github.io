---
sidebar_position: 7
---

# X.509 
X.509 is a standard format for public key certificates, digital documents that securely associate cryptographic key pairs with identities such as websites, individuals, or organizations.   

Common applications of X.509 certificates include:

- SSL/TLS and HTTPS for authenticated and encrypted web browsing
- Signed and encrypted email via the S/MIME protocol
- Code signing
- Document signing
- Client authentication
- Government-issued electronic ID    

# TLS/SSL
Use cases:
- Bảo mật communication giữa client - server
- email
- VoIP 
Protocols:
- HTTP   
- SMTP 
- FTP
- LDAP 




Mô hình OSI cho thấy SSL/TLS được dùng như một giao thức phiên (session protocol), tức là một giao thức tầng cấp trên (upper layer protocol) dành cho TCP hoặc UDP, song lại là một giao thức tầng cấp dưới (lower layer protocol) đối với rất nhiều các giao thức khác (HTTP, SFTP,...).       
SSL/TLS hoạt động trên communication channel đã được thiết lập, nghĩa là kết nối TCP phải được thiết lập (và do đó quá trình handshake TCP phải hoàn tất thành công) trước khi quá trình handshake TLS có thể bắt đầu.     


| 7 | Tầng ứng dụng         | HTTP, SMTP, SNMP, FTP, Telnet, ECHO, SIP, SSH, NFS, RTSP, XMPP, Whois, ENRP                        |
| - | --------------------- | -------------------------------------------------------------------------------------------------- |
| 6 | Tầng trình diễn       | XDR, ASN.1, SMB, AFP, NCP                                                                          |
| 5 | Tầng phiên            | ASAP, TLS, SSH, ISO 8327 / CCITT X.225, RPC, NetBIOS, ASP                                          |
| 4 | Tầng giao vận         | TCP, UDP, RTP, SCTP, SPX, ATP, IL                                                                  |
| 3 | Tầng mạng             | IP, ICMP, IGMP, IPX, BGP, OSPF, RIP, IGRP, EIGRP, ARP, RARP, X.25                                  |
| 2 | Tầng liên kết dữ liệu | Ethernet, Token ring, HDLC, Frame relay, ISDN, ATM, 802.11 WiFi, FDDI, PPP                         |
| 1 | Tầng vật lý           | 10BASE-T, 100BASE-T, 1000BASE-T, SONET/SDH, T-carrier/E-carrier, các tầng vật lý khác thuộc 802.11 |

**Có thể sử dụng TLS/SSL trực tiếp cho TCP protocol không?**        
Có vẻ không?         
- quá trình handshake TCP chỉ xác nhận việc truyền dữ liệu.         
- quá trình handshake TLS/SSL xảy ra sau khi quá trình handshake TCP thành công để bảo mật việc truyền dữ liệu.            
TLS/SSL hoạt động ở tầng 5, trên tầng của TCP (tầng 4). Vì vậy, thông thường, để sử dụng TLS/SSL cho TCP protocol chúng ta sẽ kết hợp thêm một giao thức ở tầng 7 (Application Layer).        
Có vẻ khi người ta nói TLS, SSL cho TCP protocol nghĩa là TCP protocol + upper protocol.        

`References:`      
https://community.spiceworks.com/t/difference-between-tcp-3-way-handshake-vs-ssl-handshake/788988    

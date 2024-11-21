---
sidebar_position: 1
---

# Access log format

`$bytes_sent`   
the number of bytes sent to a client. - size request của server trả về cho client.

`$request_length`   
request length (including request line, header, and request body). - size request được gửi từ client

`$request_time`   
request processing time in seconds with a milliseconds resolution; time elapsed between the first bytes were read from the client and the log write after the last bytes were sent to the client. - thời gian xử lý request của server.




`Reference:`   
https://nginx.org/en/docs/http/ngx_http_log_module.html   



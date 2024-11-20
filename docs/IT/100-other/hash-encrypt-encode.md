---
sidebar_position: 3
---

# Hash, Encode, Encrypt

## Hash

![image](https://nhatbui.tech/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fb.a8f903ef.png&w=1920&q=75)

Hash(hàm băm) là một hàm toán học, có thể nhận đầu vào là một chuỗi dữ liệu bất kỳ và cho ra một chuỗi dữ liệu có độ dài cố định.

Quá trình giải mã dữ liệu không thể thực hiện được.

Ứng dụng phổ biến của Hash là lưu trữ mật khẩu trong database.

Ví dụ: bạn có chuỗi "Hello", sau khi hash với thuật toán MD5 thì kết quả trả về luôn là "5d41402abc4b2a76b9719d911017c592"

## Encrypt - Decrypt

![image](https://nhatbui.tech/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fa.c5982961.png&w=1920&q=75)

Encrypt là quá trình mã hóa dữ liệu.

Quá trình giải mã dữ liệu được gọi là decrypt.

Có 2 kiểu encrypt thường gặp là symmetric và asymmetric.

`symmetric`: sử dụng cùng 1 key cho việc encrypt và decrypt.
`asymmetric`: sử dụng public, private key cho việc encrypt và decrypt.

Ví dụ: sau khi encrypt chuỗi "Hello" với secret key là "🔑" với thuật toán DES-CBC thì kết quả trả về sẽ là "LyplKNRs+t7vI8VwVvs6Gg=="
và ta chỉ có thể dịch ngược chuỗi "LyplKNRs+t7vI8VwVvs6Gg==" -> "Hello" khi có key cùng giá trị với lúc encrypt ("🔑")

## Encode - Decode

![image](https://nhatbui.tech/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fc.127ec1fa.png&w=1920&q=75)

Nếu như hash hay encrypt là quá trình mã hoá dữ liệu thì Encode chỉ là quá trình chuyển dữ liệu từ dạng này sang dạng kia

Ví dụ: sau khi encode 1 url "https://www.google.com/" thì kết quả trả về sẽ là "https%3A%2F%2Fwww.google.com%2F"

hoặc encode 1 chuỗi "Hello" sang định dạng base64 thì kết quả trả về sẽ là "aGVsbG8="

không giống như hash hay encrypt, dữ liệu sau khi encode vẫn có thể dịch ngược lại thành dữ liệu ban đầu (decode)

**Kết luận:**
- Hash: mã hoá dữ liệu, không thể giải mã
- Encrypt: mã hoá dữ liệu, có thể giải mã với key hoặc public, private key
- Encode: chuyển đổi dữ liệu từ dạng này sang dạng khác, có thể dịch ngược lại



`Reference:`   
https://nhatbui.tech/articles/encript-hash-encode   



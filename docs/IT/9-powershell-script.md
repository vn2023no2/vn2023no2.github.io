---
sidebar_position: 9
---

# Powershell Script
## What is Powershell Script
- Định dạng file: filename.ps1
- Thực thi: .\filename.ps1
## Hello World
1. Content
```
function SayHello {
    Write-Host "Hello, World!"
}

# Gọi hàm SayHello
SayHello
```
2. Lưu file với tên hello-world.ps1
3. Thực thi
```
.\filename.ps1
```
Nếu gặp lỗi liên quan tới quyền thực thi như bên dưới
```
cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
```
thì chạy lệnh sau
```
Set-ExecutionPolicy RemoteSigned
```
or
```
Set-ExecutionPolicy unrestricted
```
khi thực hiện xong, nếu muốn giới hạn lại quyền thì
```
Set-ExecutionPolicy Restricted
```
---
sidebar_position: 3
---

# IAM (AWS Identity and Access Management)

https://000002.awsstudygroup.com/vi/4-switch-roles/    

## IAM User
Đại diện cho người dùng hoặc ứng dụng truy cập AWS.
Có hai loại IAM User chính:
- Root user: Tài khoản quản trị cao nhất, được tạo khi đăng ký AWS Account.
- IAM user: Tài khoản thông thường với quyền hạn được cấp phát.

## IAM Group
Tập hợp các IAM Users để quản lý quyền tập trung.
Đặc điểm:    
- Chứa nhiều IAM User.
- Được gán các IAM Policy để phân quyền.
- Tự động áp dụng quyền cho tất cả thành viên.

## IAM Policy
Định nghĩa các quyền truy cập cụ thể. 
IAM Policy có thể được gán cho:
- IAM Groups (Nhóm người dùng)
- IAM Users (Người dùng)
- IAM Roles (Vai trò)

**Cấu trúc và Phạm vi**
IAM Policy bao gồm các thành phần chính:

- Effect: Cho phép (Allow) hoặc từ chối (Deny) quyền.
- Action: Các hành động được phép thực hiện.
- Resource: Tài nguyên AWS được áp dụng.
- Condition: Điều kiện bổ sung (nếu có).

## IAM Role
Cung cấp quyền tạm thời cho users hoặc services.




### Role
Có 2 policy: Permission Policy + Trust Policy
#### Permission Policy
- Role này được dùng làm gì?
- Config qua Resource
- Có 2 loại:
  - **Inline policy**: gán cứng vào role
  - **Managed policy**: có thể tái sử dụng

#### Trust Policy
- Ai được sử dụng role này?
- Config qua Principal

**Role và Assume Role:** Role là cái bạn tạo ra, Assume Role là hành động sử dụng role đó.

## Best practice
https://000002.awsstudygroup.com/images/10/0006.png?featherlight=false&width=60pc
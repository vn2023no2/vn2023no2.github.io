---
sidebar_position: 1
---

# Terraform

## Variable trong terraform
Variable trong terraform có 2 kiểu chính
string, number, boolean
list, map, set


## Cấu trúc một project trong terraform
Basic Structure:
```
project/
├── main.tf                 # Main configuration
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── versions.tf             # Provider versions
├── terraform.tfvars        # Variable values
└── README.md               # Documentation
```

Large/Production Project:
```
project/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   └── prod/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   ├── compute/
│   ├── database/
│   └── security/
├── shared/
│   ├── data.tf
│   ├── locals.tf
│   └── versions.tf
└── scripts/
    ├── deploy.sh
    └── destroy.sh
```

Giải thích:   
- `main.tf` - đây là file quan trọng nhất, có thể chỉ sử dụng file này để provisioning các resource mà không cần các file khác.
- `variables.tf` - đây là file định nghĩa các variables (kiểu dữ liệu, description).
- `terraform.tfvars` - đây là file gán giá trị cho các variables.
- các file *.tf - ....

Thực ra terraform chỉ sử dụng 2 loại file 
- file `*.tfvars`: khai báo giá trị cho các biến đầu vào.
- file `*.tf`:
    - nếu có nhiều file `*.tf` thì terraform tiến hành merge các file đó lại với nhau.
    - nội dung trong các file `*.tf` không được trùng nhau.
    - không cần phải đặt tên file là `main.tf` chỉ cần có file `*.tf` và khai báo đúng là okay.
    - việc đặt tên các file `*.tfvar` và `*.tf` chỉ mang tính chất clear.

## Tips & Tricks
- Sử dụng biến `TF_CLI_ARGS_plan` để giới hạn resource được áp dụng 
Ví dụ:
```
-target module._opensearch.aws_opensearch_domain.aws_opensearch
```

`Reference:`   
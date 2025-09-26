---
sidebar_position: 2
---

# Lý thyết AWS

## VPC Peering và Transit Gateway
Mục đích: kết nối giữa các VPC.

`VPC Peering` là kết nối một - một, khi các VPC cần kết nối với nhau càng lớn thì số lượng VPC Peering càng nhiều.      
Ví dụ với 4 VPC cần kết nối với nhau thì sẽ cần Peering Connection = 3 + 2 + 1 = 6.   

`Transit Gateway` là kết nối tập trung các VPC chỉ cần một transit gateway connection để kết nối với nhau.    
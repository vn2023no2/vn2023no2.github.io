---
sidebar_position: 3
---

# CORS là gì?
CORS (Cross-Origin Resource Sharing) là một cơ chế để tích hợp ứng dụng. CORS tạo ra một phương thức cho phép các ứng dụng web máy khách được tải trong một miền để tương tác với tài nguyên trong miền khác. 

Hiểu đơn giản khi bạn truy cập vào một trang web thì trang web đó chỉ sử dụng được resource cùng `1 nguồn` nhưng khi trang web đó có gọi API tới một trang web khác nguồn (ví dụ như lấy font, image, video, ...) thì mặc định sẽ bị chặn bởi browser. CORS sinh ra để cho phép việc sử dụng resource của một trang web khác.

## Như thế nào là cùng 1 nguồn
Cùng 1 nguồn được quy định bởi 3 đặc điểm:
- Cùng giao thức (http hoặc https)
- Cùng 1 domain
- Cùng 1 port
Nếu trang web có gọi API tới 1 URL khác 1 trong 3 ý trên thì sẽ được coi là khác nguồn


# Đặc điểm của CORS
- CORS hoạt động ở browser của người dùng (đây là policy của browser) nên nếu chúng ta gọi API ở nơi khác không phải từ browser (postman, mobile, terminal, ...) thì vẫn được.




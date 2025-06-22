---
sidebar_position: 2
---

# Issue
## Memory Leaks
### What?
Một trong những lợi ích cốt lõi của Java là quản lý bộ nhớ tự động với sự trợ giúp của Garbage Collector (hay gọi tắt là GC). GC ngầm đảm nhiệm việc phân bổ và giải phóng bộ nhớ, do đó có khả năng xử lý phần lớn các vấn đề rò rỉ bộ nhớ.   

Theo lý thuyết mà các Java-er thường quảng cáo là "bạn chỉ cần viết code tạo các đối tượng - object và Java sẽ triển khai Garbage Collector của nó để phân bổ và phóng bộ nhớ giúp bạn". Nhưng thực tế thì không hoàn hảo đến vậy.   

Memory leaks chỉ việc ứng dụng Jave trong quá trình chạy không được giải phóng bộ nhớ khi các object không còn được sử dụng nữa, nó làm cho bộ nhớ trống giảm dần.   


`Reference:`   
https://viblo.asia/p/how-to-avoid-memory-leaks-in-java-aWj53X1eK6m    
https://www.baeldung.com/java-memory-leaks      


## Full GC Java


---
sidebar_position: 1
---

# Linux
Trong file text của Windows, việc xuống dòng được thể hiện bằng cặp kí tự \r\n còn trong Linux/Unix thì chỉ là \n.
Giải pháp đưa ra ở đây là sử dụng lệnh tr, cụ thể như sau:
```
tr -d '\r' < win.cpp > unix.cpp
```
Lệnh này sẽ nhận dòng nhập chuẩn sau đó xoá các kí tự \r rồi ghi ra dòng xuất chuẩn. Dòng nhập và dòng xuất ở đây được định hướng lại để đến từ một file và ghi ra một file.



## more, less và most

`more` - là cũ nhất.
`less` - cung cấp các cải tiến và bổ sung so với lệnh `more`. 
`most` - là sự cải tiến dựa trên 2 lệnh `more` và `less`.

So sánh ngắn gọn:

`more`: điều hướng về phía trước và điều hướng ngược lại hạn chế.   
`less`: cả điều hướng tiến và lùi và cũng có tùy chọn tìm kiếm. Bạn có thể đến đầu và cuối tệp ngay lập tức. Thêm vào đó, bạn có thể chuyển sang trình soạn thảo (như mở tệp trong vi hoặc vim). Nó nhanh hơn đáng kể so với trình soạn thảo khi tệp lớn.   
`most`: có tất cả các tính năng của `more` và `less` nhưng bạn cũng có thể mở nhiều tệp, đóng 1 tệp cùng lúc khi bạn mở nhiều tệp, cho phép khóa và cuộn các cửa sổ đang mở và cho phép tách các cửa sổ đang mở.    
Cả 3 đều sử dụng phím tắt `h` để cho phép bạn xem các phím tắt cho lệnh.     

### Các phím trong lệnh less

`-N` - bật / tắt hiển thị line number (less -N hoặc dùng luôn khi xem mà không cần thoát).      
`f` - foward tới trang sau.     
`b` - back lại trang trước.     
`G` - đi đến cuối.     
`g` - đi lên đầu.      
`ESC` + `u` - Undo (toggle) highlighting.      

`n` - di chuyển tới vị trí khớp tiếp theo khi search.      
`N` - di chuyển tới vị trí khớp trước đó.       



## head và tail
`head` - để xem những dòng đầu
`tail` - để xem những dòng cuối

## Linux command
- Xem nội dung mà không cần giải nén
  - Đối với file *.gz
    ```
    zcat filename.gz
    ```
  - Đối với file *.tar.gz
    ```
    tar -tf filename.tar.gz
    vim filename.tar.gz
    ```

- Xem các file đã bị xoá nhưng vẫn bị hold bởi tiến trình dẫn đến không thể giải phóng disk
    ```
    lsof -a +L1
    ```
`Solution:` https://access.redhat.com/solutions/2316   
    
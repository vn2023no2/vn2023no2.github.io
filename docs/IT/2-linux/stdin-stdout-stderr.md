---
sidebar_position: 2
---

# Stdin, Stdout, Stderr

Trên hầu hết các hệ điều hành nói chung và Linux/Unix nói riêng thì có 3 dòng xuất nhập chuẩn (I/O) là STDIN, STDOUT và STDERR mà chức năng tương ứng là dòng nhập chuẩn, dòng xuất chuẩn và dòng xuất lỗi chuẩn. Chúng được gọi là các open file và hệ thống gán cho mỗi file này một con số gọi là file descriptor. Ba con số tương ứng với 3 dòng xuất nhập chuẩn ở trên là 0, 1 và 2. Cụ thể:

```
standard input - stdin - 0<
standard output - stdout - 1>
standard error - stderr - 2>
```

## Stdin
Ngoài   
```
$ cat /etc/passwd
```
thì ta có thể sử dụng:
```
$ cat < /etc/passwd
```
hoặc
```
$ cat 0< /etc/passwd
```

Tại sao lại có thể bỏ số 0 mà chức năng vẫn tương tự? Đó là vì mỗi khi khởi tạo một process thì hệ thống đã gắn một dòng nhập chuẩn cho process đó mà ở đây là STDIN hay 0.

## Stdout
STDOUT là các dòng xuất chuẩn nói chung và nó thường là xuất ra `màn hình`, ra cửa sổ `console` hoặc `terminal`.      
```
$ ls -al > dir.txt
```
hoặc
```
$ ls -al 1> dir.txt
```

Lí do vì sao có thể bỏ số 1 đi tương tự như với STDIN, tức là khi khởi tạo một process thì hệ thống đã gắn một dòng xuất chuẩn cho process đó mà ở đây là STDOUT hay 1.

## Stderr
STDERR là dòng xuất lỗi chuẩn nói chung và nó cũng thường xuất trực tiếp ra `màn hình`, `console` hay `terminal`.     
Cú pháp tương tự như STDOUT, tức là sử dụng ">" để xuất ra file và ">>" để nối vào một file đã có (chưa có thì hệ thống sẽ tự tạo ra).      
Tuy nhiên điểm khác biệt là bạn `phải chỉ rõ số 2`, tức là "2>" hoặc "2>>". Lí do là vì chỉ có 1 dòng xuất chuẩn và 1 dòng nhập chuẩn cho mỗi process mà thông thường hệ thống chỉ định là STDOUT và STDIN.           

Vậy trong trường hợp của lệnh curl trong phần 2.2 ở trên, nếu ta muốn ghi cả 2 loại output đó ra file thì ta làm như sau:
```
$ curl https://quoc9x.com > quoc9x.html 2> quoc9x.log
```
Thế nào? Không có cái gì xuất ra màn hình hết đúng không? Vì nội dung trang web đã được lưu vào file osg.html còn các dòng lưu trạng thái download đã được ghi vào file osg.log.

Nhưng thế thì tốn dung lượng đĩa và có nguy cơ gây hỏng đĩa vì phải ghi file mà. Con người quả thật quá tham lam :lol: . Vậy thì phải sáng tạo ra cái gì đó như kiểu cái thùng không đáy hay gọi mĩ miều hơn thì nó là "lỗ đen" hay "black hole", tức là một nơi mà cho cái gì vào cũng mất hút luôn. Linux/Unix có cái đó cho bạn, đó là /dev/null.

```
Stdout và Stderr hiểu đơn giản đều là xuất nội dung ra màn hình, console hoặc terminal nhưng stderr sẽ xuất ra các lỗi hoặc exception phát sinh trong quá trình thực thi.
```
Ví dụ:
Lệnh sau sẽ download mã html của website và ghi vào file quoc9x.html nhưng vẫn sẽ có các thông tin trạng thái download hiện thị ra màn hình. Lý do là và các thông tin về trạng thái download đó là stderr.

```
curl https://quoc9x.com > quoc9x.html
```

Nếu muốn khắc phục điều này thì ta làm như sau để ghi cả 2 loại output `stdout` và `stderr` ra file

```
curl https://quoc9x.com > quoc9x.html 2> quoc9x.log
```


## /dev/null
Trong các hệ điều hành kiểu Unix, /dev/null hay thiết bị null là một tệp tin đặc biệt, nó bỏ qua mọi dữ liệu ghi lên nó (nhưng có báo cáo về việc ghi dữ liệu thành công) và không cung cấp bất kì dữ liệu gì khi đọc từ nó (trả về EOF). Trong biệt ngữ của các lập trình viên Unix, nó đuợc gọi là "bit bucket" hoặc "black hole".     

Vậy thì đó chính là cái ta cần rồi. Như vậy câu lệnh curl ở trên có thể cho nó thực hiện câm lặng bằng cách:
```
$ curl https://quoc9x.com > /dev/null  2> /dev/null
```
Không có cái gì xuất ra màn hình cả, cũng không có cái gì được ghi lại cả. Nhưng... lại nhưng, con người vẫn tham lắm, làm thế nào để cái lệnh trên ngắn gọn hơn, trông technical hơn, nói chung là để ai không biết thì sẽ không hiểu gì (đôi khi đó là cái thú của dân kĩ thuật). Ta sẽ dùng "2>&1" ở đây, tức là:
```
$ curl https://quoc9x.com > /dev/null  2>&1
```
Câu lệnh trên tức là dòng xuất chuẩn (1) sẽ bị đưa vào /dev/null và dòng lỗi chuẩn (2) sẽ được đưa vào dòng xuất chuẩn (1) mà ở đây là /dev/null.
`&1` - nghĩa là đưa thông tin vào dòng xuất chuẩn (1), ở đây là /dev/null (nếu dòng xuất chuẩn (1) là file thì sẽ ghi vào file). 

Đặc biệt lưu ý là với cú pháp sử dụng dấu `&` thì dấu `&` và dấu `>` phải đi liền nhau, không có khoảng cách.

Ngoài các file descriptor 0, 1, 2 ở trên thì còn có từ 3 -> 9 nữa. Tuy nhiên bài viết này chỉ dành cho mức độ newbie nên không để cập sâu, chi tiết các bạn có thể tự tìm hiểu thêm trên Internet hoặc trong các sách về lập trình shell.


`Reference:`   
https://centos-vn.blogspot.com/2013/12/stdinstdoutstderr.html     





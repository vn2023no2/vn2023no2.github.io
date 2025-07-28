---
sidebar_position: 3
---

# Install multi-version Java
## C1:
- Download version java tại `https://www.azul.com/downloads/?package=jdk#zulu` (nếu muốn chọn version cũ là click vào `Include older versions`)

- Giải nén file vừa download vào thư mục
Ex:
```
uzip jdk8 -d /usr/local/java/
```
- Tạo symlink để có thể sử dụng các file binary
Ex:
```
/usr/bin/java -> /etc/alternatives/java
/etc/alternatives/java -> /usr/local/java/jdk8/bin/java
```

- Nếu muốn dùng multi-version java thì có thể download nhiều version và tạo nhiều symlink
Ex:
```
/usr/bin/java17 -> /etc/alternatives/java17
/etc/alternatives/java17 -> /usr/local/java/jdk8/bin/java
```

## C2:
Cài đặt các version Java như bình thường và chuyển đổi qua lại các version bằng các sử dụng lệnh bên dưới:
```
update-alternatives --config java
```

`Reference:`   

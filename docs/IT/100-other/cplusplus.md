---
sidebar_position: 6
---

# C++

## Cài đặt môi trường lập trình C++ trên Linux (Ubuntu)
```
sudo apt update
sudo apt install gcc g++ clang gdb
```

### Run từ terminal
#### Complie
```
g++ file_name.cpp -o file_name.out
```
#### Run
```
./file_name.out
```

#### Debug
```
gdb ./file_name.out
```


## Cài đặt môi trường lập trình C++ trên Windows
### 1. Cài đặt Complier

Link download: https://www.mingw-w64.org/downloads/#mingw-w64-builds
Chọn MinGW-W64-builds [https://www.mingw-w64.org/downloads/#mingw-w64-builds:~:text=on%20MacPorts.-,MinGW%2DW64%2Dbuilds,-Installation%3A%20GitHub] => GitHub => Release => Chọn và download x86_64-15.2.0-release-posix-seh-ucrt-rt_v13-rev1.7z => Giải nén => Thêm ENV vào Windows


### 2. Cài đặt một IDE (VSCode, ...) và các extension phù hợp





Link references:
https://github.com/lephamcong/Install_MinGW-w64_VSCode    
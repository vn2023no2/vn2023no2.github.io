---
sidebar_position: 12
---

# Git

## Command git hay sử dụng
### Huỷ commit cuối
Huỷ commit cuối và đưa các thay đổi vào vùng `staging`
```
git reset --soft HEAD~1
```
Huỷ hoàn toàn commit cuối (các thay đổi cũng sẽ bị huỷ)
```
git reset --hard HEAD~1
```
### Huỷ git add
```
git reset
```
### Huỷ git add cho 1 file
```
git reset -- filename
```
### Xóa commit
- Sử dụng git rebase
```
git rebase -i HEAD~3
```
- Lệnh này sẽ show 3 commit gần nhất trong 1 trình soạn thảo, xóa commit cần xóa => lưu lại và thoát. 
```
git push --force
```  
### git reset --hard HEAD~1


## git pull và git fetch
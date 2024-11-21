---
sidebar_position: 1
---

# Function

`increase` function - tính toán tốc độ thay đổi của metric.
`rate` function - tính toán tốc độ thay đổi `theo giây` của metric.

Bảng số liệu mẫu
```
Time Count increase  rate(count[1m])
15s  4381  0          0
30s  4381  0          0
45s  4381  0          0
1m   4381  0          0

15s  4381  0          0
30s  4402  21         0.700023
45s  4402  0          0.700023
2m   4423  21         0.7

15s  4423  0          0.7
30s  4440  17         0.56666666
45s  4440  0          0.56666666
3m   4456  16         0.53333333
```

increase[30s] = count at 2m - count at 1.5m = 4423 - 4402 = 21
rate[1m]      = (count at 2m - count at 1m) / 60 = (4423 - 4381) / 60 = 0.7




`Reference:`   




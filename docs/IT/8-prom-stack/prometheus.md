---
sidebar_position: 1
---

# Operators


`on (instance, job) group_left (version, commit)` - this is Prometheus equivalent of a left join from SQL. It uses the instance and job labels, which are automatically added by Prometheus, to group join time series. It’s then going to add the version and commit labels from the time series on the right to the series on the left.


`References:`     
https://prometheus.io/docs/prometheus/latest/querying/operators/     
https://autometrics.dev/blog/inside-some-complex-prometheus-queries    

# Functions

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
```
increase[30s] = count at 2m - count at 1.5m = 4423 - 4402 = 21   
rate[1m]      = (count at 2m - count at 1m) / 60 = (4423 - 4381) / 60 = 0.7
```

```
Hàm `increase` và `rate` sẽ trả về kết quả `Empty query result` nếu trong khoảng thời gian [t] metric [c] không bao phủ ít nhất 2 samples. Vì vậy hãy xem xét tăng khoảng thời gian lên để có thể tính toán được.   
```

`Reference:`   
https://prometheus.io/docs/prometheus/latest/querying/functions/     
https://stackoverflow.com/a/71662506/14312225       

# Metric types (4 loại)

## Counter
- Không dùng cho các metric có thể giảm theo thời gian.      

## Gauge    
- Dùng cho các metric có thể tăng hoặc giảm theo thời gian.    

## Histogram

## Summary

`Reference:`    
https://prometheus.io/docs/concepts/metric_types/    





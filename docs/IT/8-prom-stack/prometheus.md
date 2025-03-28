---
sidebar_position: 1
---

# Operators

## on - group_left
`on (instance, job) group_left (version, commit)` - this is Prometheus equivalent of a left join from SQL. It uses the instance and job labels, which are automatically added by Prometheus, to group join time series. It’s then going to add the version and commit labels from the time series on the right to the series on the left.    
( 
- chỉ đơn giản là thêm label `version, commit` vào danh sách label của metric bên trái với những metric có instance và label khớp với nhau, khá giống với left join trong SQL, nhưng những kết quả không khớp sẽ bị loại bỏ thay vì được show như SQL.
Kết quả:
- metric bên trái được giữ nguyên value nhưng bỏ tên metric.     

)     
**Chi tiết hơn thì đọc dưới đây:**      
Điều này cung cấp cho chúng ta các liên kết một - một bên trong với PromQL, nhưng không phải các liên kết trái. Chúng ta cũng chỉ có các label khớp trong kết quả. Trước đây chúng ta đã xem xét cách thực hiện một số điều này:
```
a * on(foo, bar) group_left(baz) b
```
tương đương với
```
SELECT a.value * b.value, a.*, b.baz
FROM a JOIN b ON (a.foo == b.foo AND a.bar == b.bar)
```
Nghĩa là chúng ta giữ tất cả các label ở phía bên trái, và thêm `baz` label ở phía bên phải của toán tử. Đây cũng là phép so khớp nhiều - một, do đó có thể có nhiều mẫu ở phía bên trái có cùng label `foo` và `bar` sẽ tương ứng với một giá trị ở bên phải.

## label_replace
```
label_replace(metric{...}, "label-name-new", "$1", "label-name-current", "regex")
```
### Đổi tên label
```
label_replace(metric{...}, "label-name-new", "$1", "label-name-current", "(.+)")
```
### Đổi giá trị của label (tách IP)
```
label_replace(metric{...}, "label-name-new", "$1", "label-name-current", "(.*):(.*)")
```

Ex:
```
process_cpu_seconds_total{cluster_num="1", instance="1.1.1.1:9113", job="vmagent"}

==> label_replace(process_cpu_seconds_total, "pod_ip", "$1", "instance", "(.*):(.*)") ==>

process_cpu_seconds_total{cluster_num="1", instance="1.1.1.1:9113", job="vmagent", pod_ip="1.1.1.1"}
```

`References:`     
https://prometheus.io/docs/prometheus/latest/querying/operators/     
https://autometrics.dev/blog/inside-some-complex-prometheus-queries    
https://www.robustperception.io/left-joins-in-promql/      

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

# Service Discovery
Service discovery is a fundamental concept in Prometheus architecture. It allows Prometheus to automatically discover and monitor targets (systems or services) without requiring manual configuration for each individual target.

Kubernetes is the perfect example for dynamic targets. Here, you cannot use the static targets method, because targets (pods) in a Kubernetes cluster is ephemeral in nature and could be short lived.


```
scrape_configs:
    - job_name: 'kubernetes-apiservers'
    kubernetes_sd_configs:
    - role: endpoints
    scheme: https
    tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
    relabel_configs:
    - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
        action: keep
        regex: default;kubernetes;https
```

`Reference:`   
https://medium.com/@tech_18484/understand-prometheus-architecture-1ab83afd53b8    
https://devopscube.com/prometheus-architecture/   
https://devalpharm.medium.com/deploying-prometheus-and-grafana-on-kubernetes-using-manifest-files-3761792d12a4     

# Metric types (4 loại)

## Counter
- Không dùng cho các metric có thể giảm theo thời gian.      

## Gauge    
- Dùng cho các metric có thể tăng hoặc giảm theo thời gian.    

## Histogram

## Summary

`Reference:`    
https://prometheus.io/docs/concepts/metric_types/    





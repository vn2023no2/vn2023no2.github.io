---
sidebar_position: 3
---

# Prometheus Metrics

## Kubernetes
`container_memory_usage_bytes` - metric này bao gồm toàn bộ memory mà container sử dụng bao gồm cả anonymous và cache memory.
`container_memory_working_set_bytes` - metric này đo lường bộ nhớ thực sự đang được sử dụng và đã được commit bởi container. Đây là số liệu tốt hơn để monitor memory cho container và là metric thực sự gây ra OOM killer.    

`container_network_transmit_bytes_total` and `container_network_receive_bytes_total`: Measure the amount of network traffic transmitted and received by the container, respectively. When the network becomes saturated, the container may experience latency or dropped requests.  
How to check network is saturated (and see if the TX-ERR or RX-ERR are climbing. If they are, then you're probably hitting saturation.)
```
netstat -i 
```

`Refer:`     
https://faun.pub/how-much-is-too-much-the-linux-oomkiller-and-used-memory-d32186f29c9d       
https://onairotich.medium.com/understand-container-metrics-and-why-they-matter-9e88434ca62a     



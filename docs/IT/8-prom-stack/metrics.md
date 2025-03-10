---
sidebar_position: 3
---

# Prometheus Metrics

## Kubernetes
`container_memory_usage_bytes` - metric này bao gồm toàn bộ memory mà container sử dụng bao gồm cả anonymous và cache memory.
`container_memory_working_set_bytes` - metric này đo lường bộ nhớ thực sự đang được sử dụng và đã được commit bởi container. Đây là số liệu tốt hơn để monitor memory cho container và là metric thực sự gây ra OOM killer.    

`Refer:`     
https://faun.pub/how-much-is-too-much-the-linux-oomkiller-and-used-memory-d32186f29c9d       



---
sidebar_position: 6
---

# Problem with healthcheck
Do kubelet trả gói tin healthcheck nhầm socket

Bắt các gói tin đến và đi kubelet `<=>` pod

```
tcpdump -i enp1s9 dst 192.168.6.1 and src 192.168.6.2 and src port 80
```

`References:`     
https://serverfault.com/questions/23385/huge-amount-of-time-wait-connections-says-netstat     

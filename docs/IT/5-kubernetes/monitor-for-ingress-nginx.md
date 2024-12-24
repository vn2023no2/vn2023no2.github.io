---
sidebar_position: 2
---

# Metrics
To configure for exporting metrics. This requires 3 configurations to the controller. These configurations are :
```
controller.metrics.enabled=true # for service
controller.podAnnotations."prometheus.io/scrape"="true" # in annotation of deployment
controller.podAnnotations."prometheus.io/port"="10254"  # in annotation of deployment
```

metric path: /metrics     
metric port: 10254     

And then configure prometheus to scrape metrics.     

# Logs



`Reference:`   
https://kubernetes.github.io/ingress-nginx/user-guide/monitoring/      
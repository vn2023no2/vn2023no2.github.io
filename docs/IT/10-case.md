---
sidebar_position: 10
---

# Case
## BurstBalance
??? BurstBalance of gp2
BurstBalance is out of ==> RDS storage IOPS decrease ==> DB latency slow ==> connection is not released ==> connection pool max ==> new connection pending ==> Services fall into `Unavailable` status ==> The requests response with 503 status.      
Solution: migrate from gp2 to gp3 storage to improve IOPS.   
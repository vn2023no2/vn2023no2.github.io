---
sidebar_position: 3
---

# Heap dump, Thread dump và Core dump trong Java

| Dump Type   | Use Case                                       | Contains                                 | Command                                  | Format File |
| ----------- | ---------------------------------------------- | ---------------------------------------- | ---------------------------------------- | ----------- |
| Heap Dump   | Diagnose memory issues like `OutOfMemoryError` | Snapshot of objects in the Java heap     | jmap -dump:live,format=b,file=/tmp/dump.hprof `PID_of_Java` | Binary file (read by `jhat` for linux terminal or `Memory Analyzer`, `jvisualvm`) |
| Thread Dump | Troubleshoot performance issues, thread deadlocks, and infinite loops | Snapshot of all thread states in the JVM | jstack `PID_of_Java` > /tmp/threaddump.txt | Text file |
| Core Dump (aka crash dump)   | Debug crashes caused by native libraries                              | Process state when JVM crashes           | | |



`Reference:`   
https://www.baeldung.com/java-heap-thread-core-dumps      





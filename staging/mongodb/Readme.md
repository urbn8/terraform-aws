### Manual setup(No need)

Curently everything automattion setup. But if you get someting error then login to node-1 and init mongodb replication with following command below:


```
 rs.initiate()
 rs.add("mongodb-2.staging.urbn8.io")
 rs.add("mongodb-3.staging.urbn8.io")
 rs.conf()
 rs.status()

```

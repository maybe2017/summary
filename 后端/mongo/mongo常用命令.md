#### 基本查询
db.resourceInfo.find({"attr.voiceTime":"{`$gte: new Date(2022,02,01)}","thirdParams":{"$`exists"\:true}, "thirdParams.dataRecordId":{\$eq\:null}}).count();

### 查询时间范围内 管家违规次数大于0次的数据
db.conversationInfo.find({
    "startTime": {
        "$gt": "2024-10-15 00:00:00",
        "$lt": "2024-10-16 00:00:00"
    },
		"mircoDelayReplayCount": {"$gt": 0}
}).count();

### 按时间字符串查询

```
db.conversationInfo.count({"$and":[{"startTime":{"$gt":"2023-04-01 00:00:00"}},{"startTime":{"$lt":"2023-04-17 00:00:00"}}]});

db.conversationInfo.find({"microManagerId":"13666701435", "customerId":"wm-900BgAAC20n3g8wL7v0GEoa8X-GVw"});
db.conversationInfo.find({"microManagerId":"15757222645", "customerId":"wm-900BgAAkxdY2L__2w7Wesw7DNrhmw"});
```



#### 按字段分组
db.resourceInfo.aggregate({"`$match":{"info":{"$`exists"\:true}}},{"`$group":{"_id":"$`info.audioFormat","count":{"\$sum":1}}});

本地引入jar包 maven命令
mvn install\:install-file -Dfile=/Users/mayu/Documents/workspace/codes/car/main\_verison/elara-parent/ojdbc6-11.2.0.4.jar -DgroupId=com.oracle.database.jdbc -DartifactId=ojdbc6 -Dversion=11.2.0.4 -Dpackaging=jar


#### 去重统计数量
db.conversationInfo.distinct("customerId",{"microManagerEmotion":"1"}).count();

使用这种方法查询时,查询的结果集大于16M 时会查询失败:

```
Error: distinct failed: { "ok" : 0, "errmsg" : "distinct too big, 16mb cap", "code" : 17217 } :
DBCollection.prototype.distinct@src/mongo/shell/collection.js:1758:1
```

##### 解决办法
使用聚合函数,多次分组统计结果,最终将聚合的结果数返回给用户

```
db.student.aggregate([
    {$match:{"age" : 18}},
    {$project:{"name":true}},
    {$group:{_id:"$name"}},
    {$count:"total_count"}
])
 
或者
 
db.student.aggregate([
    {$match:{"age" : 18}},
    {$project:{"name":true}},
    {$group:{_id:"$name",total_count:{$sum:1}}}
])

或者

db.conversationInfo.aggregate([
    {"$match":{"microManagerEmotion":"3"}},
    {"$project":{"customerId":true}},
    {$group:{_id:"$customerId"}},
    {$group:{_id:null,count:{$sum:1}}}
])
————————————————
$group的_id 为 null 其实就是将所有数据归为一组
```
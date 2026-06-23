
### 1. 把字体文件打进基础镜像中

### 2. 字典状态问题
字典：	dict_item_status
控制是否使用 字典启用与禁用？

那么与现在mapper里面的查询逻辑是冲突的，mapper默认查询所有启动的字典项

select * from sys_dict_item s where s.status = 0，查询结果只有两个，所以线上先不管。
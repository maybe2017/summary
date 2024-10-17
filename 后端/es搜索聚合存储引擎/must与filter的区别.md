
## https://blog.csdn.net/thqtzq/article/details/106102546

//定义一个BoolQueryBuilder对象
BoolQueryBuilder qb = QueryBuilders.boolQuery();

//1，返回的文档必须满足must子句的条件,并且参与计算分值
qb.must(QueryBuilder queryBuilder);
 
//2，返回的文档必须不满足定义的条件
qb.mustNot(QueryBuilder queryBuilder)

//3，返回的文档可能满足should子句的条件；在一个bool查询中，如果没有must或者filter，有一个或者多个should子句，那么只要满足一个就可以返回
qb.should(QueryBuilder queryBuilder));

//4，返回的文档必须满足filter子句的条件，但是不会像must一样，参与计算分值
qb.filter(QueryBuilder queryBuilder));

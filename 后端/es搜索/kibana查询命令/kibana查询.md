GET /gdsw_call/_search
{
  "query": {
    "bool": {
      "filter": [
        
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  }
}

GET /quality_analysis_info_test201_sckt/_search
{"size":5000,"query":{"bool":{"must":[{"term":{"record.qualityStatus.keyword":{"value":"3","boost":1.0}}},{"exists":{"field":"completedFtp","boost":1.0}}],"adjust_pure_negative":true,"boost":1.0}},"_source":{"includes":["id","taskId","record"],"excludes":[]}}


#1.查询所有的数据 app_file_upload_record
GET /quality_analysis_info_test201_sckt/_search
{
  "query": {
    "match_all":{}
  }
}
GET /quality_analysis_info_test201_sckt/_search
{
  "size": 1000,
  "query": {
    "bool": {
      "filter": [
        {
          "term": {
            "taskId": {
              "value": "1703227827000YoI6NBpei6",
              "boost": 1
            }
          }
        }
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  }
}

GET /quality_analysis_info_test201_sckt/_search
{
  "query": {
    "bool": {
      "filter": [
        {
					"terms": {
						"record.seqNo.keyword": [
							"1703227827000YoI6NBpei6"
						],
						"boost": 1.0
					}
				}
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  }
}

GET /quality_resource_info_test201_sckt/_search
{
  "query": {
    "bool": {
      "filter": [
        {
					"terms": {
						"taskId.keyword": [
							"42023100613514205589637981"
						],
						"boost": 1.0
					}
				}
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  }
}

GET /quality_analysis_info_test_henan/_search
{
    "query": {
        "bool": {
            "must": [
                {
                    "terms": {
                        "record.seqNo.keyword": [
                            "06fe65e089a54fa182077ba3892a4ef5",
                            "33007529f1e14ab0a3e0251445fce8bf",
                            "ce4c596fe4a04e0694c8db7a4d19fb55",
                            "8634326f5fb8474f943d80d30ceb7ea9"
                        ],
                        "boost": 1.0
                    }
                }
            ],
            "adjust_pure_negative": true,
            "boost": 1.0
        }
    }
}


GET /app_work_order/_search
{
    "query": {
        "bool": {
            "filter": [
                {
                    "term": {
                        "userId": {
                            "value": 34
                        }
                    }
                }
            ]
        }
    }
}

GET /app_work_order/_search
{
  "from": 0,
  "size": 10,
  "query": {
    "bool": {
       "filter": [
        {
					"terms": {
						"orderNo.keyword": [
							"7feb825f21a744c79644c8179d5ee4d1"
						],
						"boost": 1.0
					}
				}
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  },
  "sort": [
    {
      "workTime": {
        "order": "desc"
      }
    }
  ]
}

## 造假数据
PUT /app_client_device_log/_doc/1
{
  "id": 1,
  "number": "yuma5",
  "name": "马瑜",
  "deptName": "四川省-成都市-天府新区",
  "deptId": "cd75a7c5-aebc-4bbf-a94e-4efcfef7745f",
  "telephone": "18328589030",
  "clientType": "APP",
  "clientVersion": "1",
  "phoneType": "huawei-mate60",
  "sysVersion": "HarmonyOS4.0",
  "logTime": "2023-09-20",
  "fileName": "不能用的假数据.txt",
  "fileUrl": "www.baidu.com",
  "createTime": "2023-09-20 16:23:25",
  "updateTime": "2023-09-20 16:23:25"
}


# 查看ES集群中的index信息(index相当于数据库)
GET _cat/indices

# 查看ES集群中的index详细信息
GET _cat/indices?v

## 删除
DELETE /app_work_order_log
PUT app_file_upload_record
# type必须要指明某一个index下的type类型
GET /app_file_upload_record/_mapping
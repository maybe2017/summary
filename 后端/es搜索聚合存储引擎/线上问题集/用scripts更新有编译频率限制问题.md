### ES版本
7.5.1
### 异常信息
    ```
    20240813 20:20:05.887 [pool-3-thread-2] c.i.o.c.t.HandleAudioFileTask-63-INFO : 音频文件上传至sftp成功，任务id:3388952122984384, cdrBindId:3388952038364948
    20240813 20:20:05.887 [pool-3-thread-2] o.c.r.QualityAnalysisInfoRepository-146-INFO : 更新脚本语句: ctx._source.completedFtp = '1', 更新条件:{"taskId.keyword":"3388952122984384"}
    20240813 20:20:05.892 [pool-3-thread-2] o.c.r.QualityAnalysisInfoRepository-154-ERROR: 更新实体对象异常:Elasticsearch exception [type=general_script_exception, reason=Failed to compile inline script [ctx._source.completedFtp = '1'] using lang [painless]]
    org.elasticsearch.ElasticsearchStatusException: Elasticsearch exception [type=general_script_exception, reason=Failed to compile inline script [ctx._source.completedFtp = '1'] using lang [painless]]
            at org.elasticsearch.rest.BytesRestResponse.errorFromXContent(BytesRestResponse.java:177)
            at org.elasticsearch.client.RestHighLevelClient.parseEntity(RestHighLevelClient.java:1793)
            at org.elasticsearch.client.RestHighLevelClient.parseResponseException(RestHighLevelClient.java:1770)
            at org.elasticsearch.client.RestHighLevelClient.internalPerformRequest(RestHighLevelClient.java:1527)
            at org.elasticsearch.client.RestHighLevelClient.performRequest(RestHighLevelClient.java:1484)
            at org.elasticsearch.client.RestHighLevelClient.performRequestAndParseEntity(RestHighLevelClient.java:1454)
            at org.elasticsearch.client.RestHighLevelClient.updateByQuery(RestHighLevelClient.java:563)
            at com.iflytek.operate.callback.respository.QualityAnalysisInfoRepository.updateModelByKeyWordFieldParam(QualityAnalysisInfoRepository.java:152)
            at com.iflytek.operate.callback.respository.QualityAnalysisInfoRepository.updateCompletedFtpById(QualityAnalysisInfoRepository.java:117)
            Suppressed: org.elasticsearch.client.ResponseException: method [POST], host [http://10.30.184.98:9260], URI [/quality_analysis_info/_update_by_query?requests_per_second=-1&ignore_unavailable=false&expand_wildcards=open&allow_no_indices=true&ignore_throttled=true&refresh=true&timeout=1m], status line [HTTP/1.1 500 Internal Server Error]
    {"error":{"root_cause":[{"type":"circuit_breaking_exception","reason":"[script] Too many dynamic script compilations within, max: [75/5m]; please use indexed, or scripts with parameters instead; this limit can be changed by the [script.max_compilations_rate] setting","bytes_wanted":0,"bytes_limit":0,"durability":"TRANSIENT"}],"type":"general_script_exception","reason":"Failed to compile inline script [ctx._source.completedFtp = '1'] using lang [painless]","caused_by":{"type":"circuit_breaking_exception","reason":"[script] Too many dynamic script compilations within, max: [75/5m]; please use indexed, or scripts with parameters instead; this limit can be changed by the [script.max_compilations_rate] setting","bytes_wanted":0,"bytes_limit":0,"durability":"TRANSIENT"}},"status":500}
                    at org.elasticsearch.client.RestClient.convertResponse(RestClient.java:283)
                    at org.elasticsearch.client.RestClient.performRequest(RestClient.java:261)
                    at org.elasticsearch.client.RestClient.performRequest(RestClient.java:235)
                    at org.elasticsearch.client.RestHighLevelClient.internalPerformRequest(RestHighLevelClient.java:1514)
                    ... 23 common frames omitted
    Caused by: org.elasticsearch.ElasticsearchException: Elasticsearch exception [type=circuit_breaking_exception, reason=[script] Too many dynamic script compilations within, max: [75/5m]; please use indexed, or scripts with parameters instead; this limit can be changed by the [script.max_compilations_rate] setting]
            at org.elasticsearch.ElasticsearchException.innerFromXContent(ElasticsearchException.java:496)
            at org.elasticsearch.ElasticsearchException.fromXContent(ElasticsearchException.java:407)
            at org.elasticsearch.ElasticsearchException.innerFromXContent(ElasticsearchException.java:437)
            at org.elasticsearch.ElasticsearchException.failureFromXContent(ElasticsearchException.java:603)
            at org.elasticsearch.rest.BytesRestResponse.errorFromXContent(BytesRestResponse.java:169)
            ... 26 common frames omitted
    20240813 20:20:05.892 [pool-3-thread-2] c.i.o.c.t.HandleAudioFileTask-68-ERROR: 音频sbc文件处理失败! 任务id:3388952122984384, cdrBindId:3388952038364948, 更新实体对象异常
    java.lang.RuntimeException: 更新实体对象异常
            at com.iflytek.operate.callback.respository.QualityAnalysisInfoRepository.updateModelByKeyWordFieldParam(QualityAnalysisInfoRepository.java:155)
            at com.iflytek.operate.callback.respository.QualityAnalysisInfoRepository.updateCompletedFtpById(QualityAnalysisInfoRepository.java:117)
    ```


### 原因及解决办法
1. 原因是在短时间内进行了过多的动态脚本编译，超过了允许的最大值（75次/5分钟）
2. 调整script.max_compilations_rate设置以增加允许的最大编译次数。注意，可能会影响系统性能！
    ```
    curl -u elastic -H "Content-Type:application/json" -XPUT '10.30.184.98:9260/_cluster/settings' -d'{"transient" : {"script.max_compilations_rate" : "1000/1m"}}'
    ```
3. 修改代码中的对象更新方式
    ```
    public void updateCompletedFtpById(String id, String completedFtpFlag) {
        UpdateRequest updateRequest = new UpdateRequest(indexName, id);
        Map<String, Object> kvs = new HashMap<>();
        kvs.put(Constants.COMPLETED_FTP_FIELD, completedFtpFlag);
        updateRequest.doc(kvs);
        updateRequest.setRefreshPolicy(WriteRequest.RefreshPolicy.IMMEDIATE);
        try {
            restHighLevelClient.update(updateRequest, RequestOptions.DEFAULT);
        } catch (Exception e) {
            log.error("更新实体对象异常:{}", e.getMessage(), e);
            throw new RuntimeException("更新实体对象异常");
        }
    }
    ```   
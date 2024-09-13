
### request cannot be executed;I/O reactor status: STOPPED
1. 现象：客户在使用JAVA 客户端操作ES集群的时候，出现 "Request cannot be executed; I/O reactor status: STOPPED
    ```
    Caused by: java.lang.IllegalStateException: Request cannot be executed; I/O reactor status: STOPPED
        at org.apache.http.util.Asserts.check(Asserts.java:46)
        at org.apache.http.impl.nio.client.CloseableHttpAsyncClientBase.ensureRunning(CloseableHttpAsyncClientBase.java:90)
        at org.apache.http.impl.nio.client.InternalHttpAsyncClient.execute(InternalHttpAsyncClient.java:123)
        at org.elasticsearch.client.RestClient.performRequest(RestClient.java:279)
    ```
2. 背景：SpringBoot 的程序通过 RestHighLevelClient 访问ES-server 获取数据。
    ```
    1. spring-boot-starter-data-elasticsearch
    2. elasticsearch-rest-high-level-client 7.5
    ```

### 排查方向
1. 客户端文件句柄耗尽
2. 是否显示调用了client.close()
3. 并发连接es的客户端太多
4. 客户端连接es后长时间没有数据读写又没有及时close然后下次有数据读写又复用同一个连接
5. es负载太高

### 可能原因
1. 可能是ES Rest Client的Bug，在社区里有几个非常高频的ISSUE，目前最新版本尚未解决。
    ```
    // 原因
    client内部的调用链为 `IOReactor->performRequestAsync` 的 `Listener -> onFailure`，当短暂抖动触发onFailure中抛出异常时，最终导致整个IOReactor不可用，后续请求都受影响，需要重启才能恢复。

    // 解决方案：
    1. 发生错误时，重建client进行查询重试；
    2. 直接使用各类常用http库给es发送请求。
    3. 重启观察看下，暂时建议在代码中判断类似出错后，重新建立client
    ```
2. 因为OOM导致程序宕机，进而引发连接终止。  
    ```
    1. 程序接口中将一块很大的数据存进JAVA集合中引发了oom，oom异常导致程序宕机，处于假死状态，进而导致 ES-CLIENT 和 ES-SERVER 端的 http 连接异常终止，然后org.apache.http.impl.nio.client.CloseableHttpAsyncClientBase.ensureRunning 方法报异常。

    2. SpringDataElasticsearch 和ES-SERVER 是长链接，只要报了OOM，当前和 ES-SERVER 的连接线程都将报异常，也就是说，虽然OOM只报了一次，但是可能有多个线程都在 Asserts.check 方法中报异常
    ```  
3. https://zhuanlan.zhihu.com/p/384269417   
4. https://support.huaweicloud.com/intl/en-us/trouble-css/css_10_0019.html 

### 解决方案
1. 手动指定带`异常处理的IOReactor`！默认的ioReactor实现类DefaultConnectingIOReactor中exceptionHandler为null，当处理IO时间过程中出现RuntimeException，会直接上抛，最终导致client不可用。
    ```
    public RestHighLevelClient build() throws IOException {
        RestClientBuilder builder = RestClient.builder(new HttpHost(host, port, "http"))
                .setRequestConfigCallback(
                        config -> config.setConnectTimeout(connectTimeout)
                                .setConnectionRequestTimeout(connectionRequestTimeout)
                                .setSocketTimeout(socketTimeout))
                .setHttpClientConfigCallback(
                        httpClientBuilder -> {
                            final CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
                            if (ESHighLevelClient.this.certification) {
                                credentialsProvider.setCredentials(AuthScope.ANY,
                                        new UsernamePasswordCredentials(username, password));
                                httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider);
                            }
                            httpClientBuilder.setKeepAliveStrategy(CustomConnectionKeepAliveStrategy.INSTANCE);

                            try {
                                DefaultConnectingIOReactor ioReactor = new DefaultConnectingIOReactor();
                                ioReactor.setExceptionHandler(new IOReactorExceptionHandler() {
                                    @Override
                                    public boolean handle(IOException e) {
                                        return true; 
                                    }

                                    @Override
                                    public boolean handle(RuntimeException e) {
                                        return true; 
                                    }
                                });
                                httpClientBuilder.setConnectionManager(new PoolingNHttpClientConnectionManager(ioReactor));
                            } catch (IOReactorException e) {
                                throw new RuntimeException(e);
                            }
                            return httpClientBuilder;
                        }
                );
        return new RestHighLevelClient(builder);
    }

    ```
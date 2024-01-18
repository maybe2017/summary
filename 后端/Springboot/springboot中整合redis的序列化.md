### GenericJackson2JsonRedisSerializer
#### Generic单词意思：一般的; 通用的；类的，属性的;
1. 是spring data redis自带的。所以我们不需要单独引入。我们知道spring中使用redis主要是通过RedisTemplate，所以我们需要先配置RedisTemplate.
2. 因为GenericJackson2JsonRedisSerializer内部解析JSON使用的是jackson，而jackson对新的日期时间类型支持不友好，所以需要单独配置。

3. 不同于使用Java默认的对象序列化，使用GenericJackson2JsonRedisSerializer会将对象格式化为类似json形式，并且在json中会包含类的一些信息，`@class`是GenericJackson2JsonRedisSerializer自己添加进去的，为了方便反序列化。
    ```
        {
            "@class": "com.xxx.bo.DeviceIpBo",
            "deviceIp": "192.168.1.101",
            "devicePort": 8080
        }
    
    ```
4. 如何配置
    ```
    private static GenericJackson2JsonRedisSerializer createJsonRedisSerializer(){
    	// 创建objectMapper，需要额外的json配置
        ObjectMapper objectMapper = JsonSerializerConfig.createObjectMapper();
        // 因为默认的new GenericJackson2JsonRedisSerializer()中存在此逻辑，为了保持一致，这里这么写，避免不必要的错误，不同版本的spring-data-redis可能会有所区别，自己查看下new GenericJackson2JsonRedisSerializer()内的逻辑处理一下即可。

        objectMapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL, JsonTypeInfo.As.PROPERTY);
        GenericJackson2JsonRedisSerializer.registerNullValueSerializer(objectMapper, null);

        return new GenericJackson2JsonRedisSerializer(objectMapper);
    }
    
    
    ```    

5. 坑1: 假如value的序列化方式设置为String序列化器。但是set值的时候放对象了。这个时候就直接报错了，并不会自动调用toString()方法，此处一定要注意。
6. 需要特别是初始化RestTemplate的时候，value的序列化方式禁止使用有类型偏向的StringRedisSerializer。若有需要，直接使用StringRedisTemplate操作即可
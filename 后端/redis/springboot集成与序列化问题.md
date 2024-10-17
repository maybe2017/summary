
### 主从哨兵集群模式 - springboot的集成
1. 注意点: 仅主节点能读写，从节点不能写，也不会转发写请求。所以配置文件中特别注意，host要写主节点的值。
2. 


### 序列化配置
1. https://www.jianshu.com/p/c5fcd2a1ab49/

    ```
        @Bean(value = "objRedisTemplate")
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        ObjectMapper mapper = new ObjectMapper();
        // 忽略序列化时存在不认识的字段
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        // 存储到redis里的数据将有类型（在不同组件间进行序列化时，必须保证类型的全限定名必须一致）
//        mapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance, ObjectMapper. DefaultTyping.NON_FINAL, JsonTypeInfo.As.WRAPPER_ARRAY);
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        // 序列化、反序列化(仍然存在类型错误问题)
        GenericJackson2JsonRedisSerializer serializer = new GenericJackson2JsonRedisSerializer(mapper);

        template.setValueSerializer(serializer);
        //使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());

        template.afterPropertiesSet();
        return template;
    }
    ```

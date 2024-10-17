
## @Slf4j 
1. 这玩意是一套门面接口，调用者只依赖于 `slf4j-api`。
2. 基于SLF4J日志实现方案，比如apache的log4j，log4j2，logback
    ```
    // log4j2版本实现？
    log4j-api.jar(相当于slf4j-api？): Log4j-api是向外提供的接口层，log4j-core是具体实现层
    log4j桥接slf4j接口: slf4j-log4j12-x.x.x.jar, log4j-slf4j-impl-x.x.x.jar()
    

    // logback的版本实现
    logback相关jar: logback-classic-x.x.x.jar，logback-core-x.x.x.jar

    ```
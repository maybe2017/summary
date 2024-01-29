### 背景
开发中会碰到一些耗时较长或者不需要立即得到执行结果的逻辑，需要使用异步方法，这时我们可以用到@Async。

### 注意点
1. 直接使用 @Async 会有风险，当没有指定线程池时，默认使用Spring自带的 `SimpleAsyncTaskExecutor` 线程池，其会不断的创建线程，当并发大的时候会严重影响性能。
2. 所以必须指定 `自定义的线程池` 使用, 配置由自定义的TaskExecutor替代内置的任务执行器。

### 注意事项[可能导致@Async失效]
1. 注解@Async的方法不是public方法；
2. 注解@Async的返回值只能为void或Future；
3. 注解@Async方法使用static修饰也会失效；
4. 启动类没加@EnableAsync注解；
5. 调用方和@Async不能在一个类中；
6. 在Async方法上标注@Transactional是没用的，但在Async方法调用的方法上标注@Transcational是有效的；
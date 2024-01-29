### 一、类加载器
1. 先理解根、扩展、系统、自定义加载器，委托查找自下而上，加载自上而下。
2. 父子关系并不代表继承关系，App继承自Ext，Ext继承自Url，但Ext的parent却是Boot。
3. 类加载器、及类实例本身，两者加起来定位一个对象，维持其唯一性。
4. 下层加载器能使用本身、及所有祖先层级加载器加载的类实例；反方向则不行。即Ext加载的类信息中，不能有应该有Ext下层级加载的类。
5. 线程中的 `contextClassLoader` 默认为 `App系统加载器`，意味着默认情况下，多线程之间，就能共享`App及其所有父层级加载器`已加载的类实例。
    ```
    // 共享或隔离效果
    1. 线程间共享： 修改 contextClassLoader 为自定义 CusClassLoader 取代默认的App，那么这个线程就可以利用 CusClassLoader 加载额外的class。
    2. 线程间隔离： 修改默认的 contextClassLoader 为不同的 classLoader。
    3. 服务间隔离： 不同服务的所有对象都由 一个新的classLoader实例进行加载，互不影响，比如Tomcat。
    ```

### 二、JDK的SPI
1. 服务提供者加载器：ServiceLoader，位于 `java.util` 包；ClassLoader位于 `java.lang` 包。
2. 实现类的配置路径：META-INF/services/
3. 示例：java.sql.Driver接口, com.mysql.jdbc.Driver 为实现类
4. 核心：Class<?> forName(String name, boolean initialize, ClassLoader loader)
5. 当调用DriverManager.getConnection(jdbcUrl, username, password)时，DriverManager会使用ServiceLoader来查找所有已注册的java.sql.Driver实现。然后会尝试每一个驱动程序，直到找到一个可以处理给定jdbcUrl的驱动程序。

### 三、Tomcat的SPI
1. 服务提供者加载器：WebappServiceLoader
2. 实现类的配置路径：META-INF/services/javax.servlet.ServletContainerInitializer，启动阶段调用其onStartup
3. 容器启动阶段依据SPI机制获取到所有`ServletContainerInitializer`的实现类，然后执行其`onStartup`方法。(参考类：ContextConfig监听器)
    ```
    1. 在web容器启动时为提供给第三方组件机会做一些初始化的工作，例如注册servlet或者filtes等，servlet规范中通过ServletContainerInitializer实现此功能。
    2. servlet容器除了会回调SCI之外, 还有回调诸如listener#beforeContextInitialized；filter#init方法等
    ```
### 四、Springboot的SPI[热插拔的实现基石]
1. 服务提供者加载器：SpringFactoriesLoader
2. 实现类的配置路径：META-INF/spring.factories；内部都是key-value的形式[接口=实现类1,实现类2]
3. 它主要暴露了两个方法：loadFactories[拿到全类名后会立马实例化]、和loadFactoryNames[只拿全类名]
4. 优点：更加灵活、与IoC集成、条件匹配[@ConditionalOnProperty、@ConditionalOnMissingBean等]进行部分加载。
    ```
    1. @EnableAutoConfiguration 有集成了 @Import 注解，这个注解对于springboot非常重要！
    ```

### 五、Spring的SPI
1. Spring核心提供了很多接口和抽象类，如BeanPostProcessor, PropertySource, ApplicationContextInitializer等，这些都可以看作是Spring的SPI。
2. 开发者可以实现这些接口来扩展Spring的功能。这些接口允许开发者在Spring容器的生命周期的不同阶段介入，实现自己的逻辑。
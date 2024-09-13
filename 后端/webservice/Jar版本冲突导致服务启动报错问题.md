### jar包版本冲突导致的启动报错(com.sun.xml.bind)
1. 本地能启动，测试环境就不能启动
2. 百度原因：https://blog.csdn.net/u012294515/article/details/96512018

### 解决方法
1. 在 IDEA 的 Terminal 首先用 mvn dependency:tree > tree.txt，查看依赖包的树。
2. 查看 tree.txt 文件，一般生成在项目根目录下，没有的话刷新看看。
3. 查询关键字com.sun.xml.bind，发现在 org.jboss.resteasy:resteasy-jaxb-provider:jar 下存在，只需要把这个jar包中的com.sun.xml.bind排除即可


### pom配置
    ```
    <dependency>
        <groupId>org.apache.camel</groupId>
        <artifactId>camel-ftp</artifactId>
        <version>${camel_ftp_version}</version>
        <exclusions>
            <exclusion>
                <artifactId>jaxb-impl</artifactId>
                <groupId>com.sun.xml.bind</groupId>
            </exclusion>
        </exclusions>
    </dependency>
    <!-- webService -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web-services</artifactId>
        <exclusions>
            <exclusion>
                <groupId>com.sun.xml.bind</groupId>
                <artifactId>jaxb-impl</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
    <dependency>
        <groupId>org.apache.cxf</groupId>
        <artifactId>cxf-rt-frontend-jaxws</artifactId>
        <version>3.1.6</version>
    </dependency>
    <dependency>
        <groupId>org.apache.cxf</groupId>
        <artifactId>cxf-rt-transports-http</artifactId>
        <version>3.1.6</version>
    </dependency>
    ```
### 启动发布webservice服务的时候报错
    ```
    Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [javax.xml.ws.Endpoint]: Factory method 'endpoint' threw exception; nested exception is java.lang.NoSuchFieldError: REFLECTION
        at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:185)
        at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:651)
        ... 19 more
    Caused by: java.lang.NoSuchFieldError: REFLECTION
        at com.sun.xml.bind.v2.model.impl.RuntimeModelBuilder.<init>(RuntimeModelBuilder.java:93)
        at com.sun.xml.bind.v2.runtime.JAXBContextImpl.getTypeInfoSet(JAXBContextImpl.java:455)
        at com.sun.xml.bind.v2.runtime.JAXBContextImpl.<init>(JAXBContextImpl.java:303)
        at com.sun.xml.bind.v2.runtime.JAXBContextImpl.<init>(JAXBContextImpl.java:142)
        at com.sun.xml.bind.v2.runtime.JAXBContextImpl$JAXBContextBuilder.build(JAXBContextImpl.java:1174)
        at com.sun.xml.bind.v2.ContextFactory.createContext(ContextFactory.java:162)

    ```    
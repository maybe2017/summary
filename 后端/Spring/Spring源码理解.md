## 一些重点概念的理解

### 接口、抽象类
1. 接口：自上向下，不需要考虑下层的具体实现，
2. 抽象类：自下向上，需要从下层的实现，抽取共同的特征


### 常用设计模式
1. 模板方法模式：父类定义、并使用了 `未实现的方法`，子类可以重写实现。如 `AbstractApplicationContext` 中的 `onRefresh` 方法，
SpringBoot就在此方法中进行了内嵌Tomcat。


### Spring中的对象分类
1. 容器或容器使用的对象[BeanFactory、ApplicationContext、Environment..]。
2. 自定义对象，如何设置属性为容器对象呢？-> 实现 `Aware` 接口用以标记，实现了什么`xxxAware` 接口，spring就会帮注入`xxx` 对象。


### BeanFactory 与 FactoryBean的区别
1. BeanFactory 是泛指Bean对象的`一套标准的`创建流程，即Spring提供的一套流水线，灵活程度有局限。
2. FactoryBean 首先是一个接口，标记了该接口的类，可以通过实现接口[isSingleton，getObjectType，getObject]，来完成 `私人定制` 较复杂对象的创建。
   ```
   1. FactoryBean跟普通Bean不同，根据该Bean的ID从BeanFactory中获取返回的对象，不是指定FactoryBean本身类的一个实例，而是该FactoryBean的getObject方法所返回的对象。
   2. getObject创建出来的对象是否属于单例由isSingleton中的返回决定
   3. 如果要获取FactoryBean对象，请在id前面加一个&引用符号来获取(解引用)
   4. 实现FactoryBean接口的Bean由spring管理，在一级缓存中；但是getObject()返回的对象，虽然也是spring管理，但是不是在一级缓存中，而是另一个`factoryBeanObjectCache` 缓存中。
   5. getObject()返回的对象是否放入`factoryBeanObjectCache`缓存，取决于isSingleton()方法；不是单例对象的话，每次都会创建一个新对象。
   ```
3. FactoryBean的实现通常被定义为BeanFactory中的SPI实例

### ObjectFactory
1. 接口只有一个 `getObject` 方法，称为函数式接口，Lambda表达式可作为其接口实现。getObject()的返回的对象可 `完全由调用方或者子类实现`
2. 当使用Lambda表达式实现该接口做某方法参数，再在该方法内去调用`getObject()`，类似一种 `回调机制`，有滞后调用的特性。
3. getObject返回的对象实例可部分或完全自主(实现容器和外部实例的关联关系)，`不受容器管理`。而FactoryBean返回的对象完全属于私人定制，容器会提供信息，但是不会参与流程。
4. https://blog.csdn.net/qq_41907991/article/details/105123387


### PostProcesser 增强器

#### BeanFactoryPostProcesser[针对的是访问spring容器的`BeanFactory`根接口]
1. 借助它可以访问spring容器中的任意对象[对象可能还不完整]，如BeanDefinition，为对外提供扩展性，专设计了 `BeanFactoryPostProcesser` 接口作为扩展点，
借助它可以修改 `BeanFactory` 中BeanDefinition对象，如属性值 `${xxx}` 的替换，从而完善 `BeanDefinition对象` 各属性的赋值。

2. 子类 `BeanDefinitionRegistryPostProcesser`,


#### BeanPostProcesser[针对的是已完成初始化的Bean对象]
1. AOP是IOC整体流程中的一个扩展点
2. AOP动态代理










## 流程

### 一、解析注册
1. Bean定义的格式，可以是XML、YAML或注解等等，为屏蔽解析层的差异，用 `BeanDefinitionReader` 这套接口去实现了对不同格式的解析。
2. 解析的结果，是转成BeanDefinition对象，然后存进 `BeanFactory` 中的 `beanDefinitionMap`属性中，`AbstractBeanFactory` 通过getBean向IOC容器获取被管理的Bean。
3. 借助扩展点 `BeanFactoryPostProcesser` 可以修改 `BeanFactory` 中BeanDefinition对象，从而完善 `BeanDefinition` 对象中各属性的赋值。


### 二、创建Bean对象
1. 实例化：基于反射(获取Class对象 -> 获取构造器 -> 创建对象[createBeanInstance])
2. 初始化：`自定义属性` 的赋值[populateBean] -> `容器对象属性` 的赋值[invokeAwareMethods] (xxxAware接口标记，spring通过set注入)
3. 对象增强：扩展点 `BeanPostProcesser`
  ```
  1. BeanPostProcesser 前置处理 -> 
  2. 是否实现了 `InitializingBean`[调用初始化方法`afterPropertiesSet`] ->
  3. 是否配置了 `init-method` ->
  4. BeanPostProcesser 后置处理
  
  ```



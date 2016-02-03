title: spring in action学习
date: 2016-02-03 23:49:49
tags:
- spring
- java

----

# spring in action学习

## 什么是bean？

JavaBean是一个规范，针对java定义了软件的组件模型。

Spring虽然使用Bean或者JavaBean来表示应用组件，但是不意味着Spring组件必须遵循JavaBean规范。

一个Spring组件可以是任何形式的POJO。

**简单来说，Spring组件是某个POJO，而Spring中的JavaBean可以理解POJO，所有Spring中的Bean可以简单理解为组件**

## spring的4中关键策略

* 基于POJO的轻量级和最小侵入式编程
* 通过依赖注入和面向接口实现松耦合
* 基于切面和惯例进行声明式编程
* 通过切面和模板减少样板式代码

> 依赖注入（DI）的本质: 对象之间依赖有第三方完成，不需要手动去创建。
> （注：Spring通过XML或注解，并使用spring容器完成依赖注入）
> 
> 依赖注入让相互协作的软件保持松散耦合，而
> 
> AOP编程允许你把遍布应用各处的功能分离出来形成可重用的组件。

## spring容器

**在spring应用中，对象由spring容器创建、装配和管理，即通过spring容器完成DI**

spring容器：

* Bean工厂：`org.springframework.beans.factory.BeanFactory`
* 应用上下文（Application Context）：`org.springframework.context.ApplicationContext`

Bean工厂过于底层，所以应用上下文用的比较多。

Spring自带的**应用上下文（Application Context）**

* ClassPathXmlApplicationContext
* FileSystemXmlApplicationContext
* XmlWebApplicationContext

### Bean声明周期


## spring模块和portfolio

spring模块：

* 核心spring容器
* AOP模块：AOP, Aspects
* 数据访问和集成：JDBC, ORM, JMS
* Web和远程调用：Web, Servlet, Struts
* 测试

protfolio:

* Spring Web Flow
* Spring Web Service
* Spring Security
* ...









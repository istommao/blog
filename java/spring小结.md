#spring小结

*.jsp

实体类: com.org.app.model.User 用户的基本类，也可能含逻辑

服务:   com.org.app.service.UserManger  管理用户存储等逻辑，需要写数据库语句

演进: 扩展业务逻辑 ---》

展现jsp

com.org.app.model.User

com.org.app.service.UserManager


服务UserManger改成用Hibernate去访问数据库

Hibernate：hibernate.cfg.xml @Entity @Id @GeneratedValue sessionFactory getCurrentSession beginTransaction createQuery getTransaction.commit 


演进：扩展业务逻辑 ---》

*.jsp

com.org.app.dao.UserDao(接口)

com.org.app.dao.impl.UserDaoImpl（实现）

（业务逻辑部分）

com.org.app.service.UserManager（接口）

com.org.app.service.impl.UserManagerImpl(实现)

com.org.app.model.User

UserDaoImpl可以选择Hibernate或其他访问数据库

抽象出DAO。UserManger通过UserDao访问数据库，这个时候UserDao的好处，灵活替换数据库，这个时候就需要分为抽象层UserDao（接口）和实现层UserDaoImpl。同样的UserManager也分为抽象层UserManger（接口）和实现层UserManagerImpl。

演进：扩展展现层 ---》

com.org.app.action.UserAction

*.jsp

com.org.app.dao.UserDao(接口)

com.org.app.dao.impl.UserDaoImpl（实现）

（业务逻辑部分）

com.org.app.service.UserManager（接口）

com.org.app.service.impl.UserManagerImpl(实现)

com.org.app.model.User


jsp不直接操作业务逻辑层，中间加Controller。引入strus2_filter，进入Action，进一步组合后端业务逻辑层的结果，返回的结果可以找到对应的view。

struts2: web.xml filter filter-mapping struts.xml struts package action result extends ActionSupport domainModel 

演进：引入spring进行注入 ---》

com.org.app.action.UserAction

*.jsp

com.org.app.dao.UserDao(接口)

com.org.app.dao.impl.UserDaoImpl（实现）

（业务逻辑部分）

com.org.app.service.UserManager（接口）

com.org.app.service.impl.UserManagerImpl(实现)

com.org.app.model.User


spring完成UserManager、UserDao的注入

spring注入UserAction、User，加入Aop进行声明式事务管理

beans.xml jdbc.properties替代hibernate.cfg.xml 

业务逻辑注入（数据库）：（hibernate或dataSource）--增加bean的hibernateTemplate注入sessionFactory或dataSouce 在对应UserDaoImpl增加@Component("userDao")，相应的set方法加注解@Resource 

业务逻辑注入（服务）：UserManager用到UserDao，把UserDao注入，不再需要new了，在UserManagerImpl增加@Component("userManager")，对应的setUserDao方法增加注解@Resource Aop

注入struts2或手动取： UserAction不在需要new UserManager，

手动取：通过ClassPathXmlApplicationContext

整合struts2和spring：首先：struts2中加入spring-plugin，在web.xml加入listener（在web启动时完成spring的各种bean的创建），然后：，接着对UserAction进行注解和注入（struts-plugin.xml）。


spring知识点

* IOC XML Annotation
* IOC注入方式：构造方法、setter方法
* 简单属性
* 集合注入
* 自动装配：byName，byType
* 生命周期：
* @AutoWired @Component @Service @Controller @Repository @Scope  
* AOP 概念
* AOP 配置
* AOP用于整合hibernate的事务：xml Annotation
* hibernateTemplate

















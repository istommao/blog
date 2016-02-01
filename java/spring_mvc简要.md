title: spring mvc简要
date: 2016-02-01 22:31:30
tags:
- spring
- mvc

---

# spring mvc简要

## Dispatcher servlet

**web.xml**

	<servlet>
			<servlet-name>mvc-dispatcher</servlet-name>
			<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	        <load-on-startup>1</load-on-startup>
	</servlet>

	<servlet-mapping>
		<servlet-name>mvc-dispatcher</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
	

<servlet-name>mvc-dispatcher</servlet-name>指定了servlet的名字，默认情况下DispatcherServlet会加载基于这个名字的xml作为spring的上下文：mvc-dispatcher-servlet.xml	

**mvc-dispatcher-servlet.xml**

## 编写基本的控制器

### 配置注解驱动

spring自带多个处理器映射实现：

* BeanNameUrlHandlerMapping
* ControllerBeanNameHandlerMapping
* ControllerClassNameHandlerMapping
* DefaultAnnotationHandlerMapping
* SimpleUrlHandlerMapping





	
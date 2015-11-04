#Servlet学习

##j2ee标准目录结构

* WEB-INF
  * classes
  * web.xml
  * lib
  
##servlet
普通的java类，但是继承了HttpServlet


##servlet声明周期

* 只有一个对象
* 第一次请求的时候被初始化，只调用一次
* 初始化后先调用init方法，只调用一次
* 每个请求，调用service-》doGet/doPost，以多线程方式运行
	
	* 因此不要再servlet中设计成员变量
	
* 卸载前调用destroy   

##/
* 在form
* 在web.xml中url-patten指app的路径


##session和cookies

cookies

* 存在客户端
* 有两种类型的cookies：设置超时/没设置超时
* 父路径不能访问子路径的cookie

session

* 存在服务器
* 两种实现方式
* 同一个session的窗口共享一个session

##乱码

* 页面本身乱码
* GET方法乱码
* POST方法乱码

##ServletContext
Servlet和容器（tomcat）的一些环节

getServletContext


##Servlet连接数据库
JDBC驱动

##javabean
广义javabean=普通java类

狭义javabean=符合sun javabean标准的类

* 属性名驼峰表示，private，get和set方法
* 要有空的构造方法

##jsp

* java server pages
* 拥有servlet特性，本身就是一个servlet
* 直接在htmlneiqianjsp
* jsp有解析器先转换为servlet代码，然后编译为java类

语法

声明declaration：

* jsp内置out，request，response对象，可直接使用
* 基本 <% 程序代码区 %>
* <%! %> 声明为一个成员变量
* <% %> 变量声明为某个方法的局部变量，但是不能定义方法
* <%= %> 相当于out.println(...)
* \<!-- -->里的注释会被服务端执行，但是客户端不显示，而js代码为客户端运行

Directive：

* <%@page language=""|... %> 
* <%@include file="fileURL" %> 静态包含，两者jsp合并生成同一个java class，两者jsp之间不能传参数。调用同一个request对象。
* 

Action: 运行期间的包含

<%@include 和jsp:include的区别

* 前者在编译器就再file属性指定的程序，后者在客户端请求时期如果被执行到才会被动态编译载入
* 前者只生成一个class文件，后者产生两个class类
* 前者不能带参数，后者可以url地址或标签实现
* 前者同一个request对象，后者不同的request对象，并可以取得包含它的页面的参数和添加自己的参数
* 前者常用

jsp:forward

* sendRedirect：
	* 服务器返回重定向，客户端在向新的地方请求，同时转向后的代码接着执行
	* 可转向任意地址，不局限同一server的地址
	* 可以传参数，写到url上
* jsp:forward
	* 在服务端内部转向，故地址栏没变化
	* 两个页面是不同的对象，但是转到的页面可以取上一个页面的参数 
	* 转向后，后面代码不在执行 
	* 可通过参数<jsp:param，传到下一个页面
	
##jsp使用javabean

<jsp:useBean	id="x", class="xx"> </jsp:useBean>

相当于new一个javaBean对象。


##jsp转到servlet

<jsp:forward page="servlet的路径：x.jsp"

##servlet2jsp

sendRedirect()












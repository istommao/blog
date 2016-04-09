# Maven

下载安装maven后，mvn会将下载一些jar包保存到repo

mvn安装目录下的config的settings.xml可以设置本地仓库

	<localRepository>...</localRepository>
	
中央仓库

	mvnrepository.com	

命令

	mvn -v
	mvn compile  编译
	mvn package  打包
	mvn install  编译、测试、打包、上传
	
maven集成到ide就可以在ide中建maven项目，通过快捷键或菜单完成mvn命令

maven标准目录结构

	src
		main
			java
				com.ccc
				
	target: 由maven自动生成
	pom.xml
	
		<groupId>com.group</groupId>
		<artifactId>projectname</artifactId>
		<version>1.0.0</version>
		<package>jar</package>
		
		<dependencies>
			<dependency>
				<groupId>junit</groupId>
				<artifactId>junit</artifactId>
				<version>4.11</version>
				<scope>test</scope>
			</dependency>
			
			...<dependency>
		<dependencies>
		
		scope： 依赖范围--test,provided, compile, runtime, system
	
	
坐标

	坐标分为3级
		GroupId： 组织或公司
		Artifact： 项目或产品
		version： 不同版本
		
## 目录

* ${basedir} 存放 pom.xml和所有的子目录
* ${basedir}/src/main/java 项目的 java源代码
* ${basedir}/src/main/resources 项目的资源，比如说 property文件
* ${basedir}/src/test/java 项目的测试类，比如说 JUnit代码
* ${basedir}/src/test/resources 测试使用的资源
* 在默认情况下会产生 JAR 文件，另外 ，编译后 的 classes 会放在 ${basedir}/target/classes 下面， JAR 文件会放在 ${basedir}/target 下面		
		
			
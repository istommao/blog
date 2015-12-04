#Maven

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
		
			
#Maven

##目录

${basedir} 存放 pom.xml和所有的子目录

${basedir}/src/main/java 项目的 java源代码

${basedir}/src/main/resources 项目的资源，比如说 property文件

${basedir}/src/test/java 项目的测试类，比如说 JUnit代码

${basedir}/src/test/resources 测试使用的资源

在默认情况下会产生 JAR 文件，另外 ，编译后 的 classes 会放在 ${basedir}/target/classes 下面， JAR 文件会放在 ${basedir}/target 下面
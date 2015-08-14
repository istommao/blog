#python web scraping
====

##BeautifulSoup

###BeautifulSoup Object

	bsObj = BeautifulSoup(html, "html.parser")
	
将html文件转换为bsObj。	

###根据tag的属性
* findAll(tag, attributes, recursive, text, limit, keywords)
* find(tag, attributes, recursive, text, keywords)

	tag: 一个或多个标签名
		
		.findAll({"h1","h2","h3","h4","h5","h6"})
	
	attributes：是个python字典，可有多个，只要tag里包含其中的某个属性就会被查找到
	
		.findAll("span", {"class":"green", "class":"red"})

	recursive: bool值，是否查找和参数匹配的子tag
	
	text: 查找包含text的tag
	
	limit: 查找结果个数，find函数就是findAll，limit设为1的情况
	
	keywords: tag含有特定的属性

###根据导航树

	.chidren
	.next_siblings
	.parent
	.previous_sibling
	
**举例**

	bsObj.find("table",{"id":"giftList"}).children
	
	bsObj.find("table",{"id":"giftList"}).tr.next_siblings
	
	bsObj.find("img",{"src":"../img/gifts/img1.jpg"
                       }).parent.previous_sibling.get_text()	

###访问属性

	myTags.attrs['src']













#CSS

##CSS和HTML相结合的方式

1. 每个html标签中都有一个style样式属性。该属性的值就是css代码

		<div style="background-color:#0FF; color:#FF00">sss</div>

2. 使用style标签的方式，放在<head>标签内

		<style type="text/css">
			div{
				background-color:#000;
				color:#FFF
			}
		</style>
		
3. css文件

	div.css
	
		div{
				background-color:#000;
				color:#FFF
			}
	
	span.css
	
		span{
				background-color:#000;
				color:#FFF
			}		
			
	1.css
	
		@import url(div.css);
		@import url(span.css);
	
		
			
	在html文件的<head>导入即可
	
		<style type="text/css">
			@import url(1.css);
		</style>	
		
4. 使用link标签

		<link ref="stylesheet", href="1.css" type="text/css" />
		
##CSS代码格式

	选择器名称 {属性名:属性值; 属性名:属性值; ...}
					
##选择器

优先级: 标签选择器<类选择器<id选择器<style属性


1. html选择器，通过标签名
2. class选择器，使用标签的class属性

		div {
			background-color:#09F;
			color:#FFF
		}
		
		div.aa {
			background-color:#FF3;
			color:#FFF
		}
		
		<div class="aa">aa</div>
		
		所有
		
		.aa {
			background-color:#FF3;
			color:#FFF
		}
		
		<div class="aa">aa</div>
		<span class="aa">aa</span>
	
	预定样式可以实现动态加载
		
3. id选择器，使用标签的id属性。通常id在页面中是唯一。因为该属性还可以被js使用。id通常是为了标示页面中特定的区域使用的

		div#bb {
			background-color:#FF3;
			color:#FFF
		}
		
		#cc {
			background-color:#FF3;
			color:#FFF
		}
		
		<div id="bb">bb</div>

4. 扩展选择器

	关联选择器：选择器中的选择器
	
		span p{}
		
	组合选择器：对多种选择器进行相同样式定义
	
		.aa,div h{}
		
	伪元素选择器
	
		顺序一般为lvha
		a:link{...}
		a:hover{...}
		a:active{...}
		a:visited{...}	
		
		p:first-letter{...}
		p:first-line{...}
		
		input:focus{...}
		
##CSS盒子模型

边框：border

	上：border-top
	下: border-buttom
	左: border-left
	右: border-right
	
内边距：padding

	padding-top, padding-buttom, padding-left, padding-right
	
外边距：margin		
		
	margin-top, margin-buttom, margin-left, margin-right
	
	
##布局

漂浮

	#div_1{
		float:left
	}		
	
	对应clear设置漂浮对象
	
	
##定位

position：static|absolute|fixed|relative

	#div_1{
		position:absolute;
		top:50px;
		left:50px;
	}
	
##页面设计

1. 内容通过div封装起来
2. 给div添加id或class
3. 设置样式		


					

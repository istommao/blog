title: android入门
date: 2016-02-02 07:55:55
tags:
- android

----

# android入门

## 安装和配置


## 什么是Activity

* 当程序第一次运行时用户就会看这个Activity
* 当启动其他Activity，当前Activity
* Activity就是布满整个窗口或者悬浮于其他窗口上的交互界面。

### Activity生命周期

7个方法，3个阶段

* onCreate
* onStart
* onRestart
* onResume
* onPause
* onStop
* onDestroy

* 开始Activity： onCreate, onStart, onResume
* 重新开始： onStart,  onRestart, onResume
* 关闭： onPause, onStop, onDestroy


Activity具体生命周期：

* 整体生命周期： onCreate --> onDestroy
* 可视生命周期： onStart --> onStop
* 焦点生命周期： onResume --> onPause

## 布局

在一个应用程序中通常有多个Activity构成，在Manifest.xml指定主Activity。

### 视图创建

在Android中，任何可视化空间都是从**android.view.View**继承的。

* 使用XML方式来配置View的创建视图
* 使用java继承View来创建

#### 使用XML布局文件

* 在onCreate方法中使用setContentView来加载指定的xml布局文件

#### 长度方位

* px：屏幕实际像素
* dp：屏幕的物理像素
* sp：与刻度无关的像素

**技巧**：

* 表示长度和高度等属性是可以使用dp或sp，但是设置字体需要使用sp

#### 布局常用属性

* layout_margin

![layout_margin]()

* layout_padding

![layout_padding]()

* gravity: 用于设置View组件对齐的方式

![gravity]()

* layout_gravity： 用于设置Container组件的对齐方式

![layout_gravity]()

*e.g.*

	<LinearLayout ...>
		<Button android:id="@+id/button" 
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:layout_marginTop="30dp" 
		android:layout_marginLeft="40dp"
		android:layout_marginRight="60dp"
		android:layout_marginButtom="100dp"
		android:text="测试按钮1"
		></Button>
		
		<Button android:id="@+id/button2" 
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:paddingLeft="20sp" 
		android:text="测试按钮2"
		></Button>
		
		<Button android:id="@+id/button3" 
		android:layout_width="match_parent"
		android:layout_height="wrap_content"
		android:gravity="right"
		android:text="测试按钮3"
		></Button>
		
		<Button android:id="@+id/button3" 
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:layout_gravity="right"
		android:text="测试按钮3"
		></Button>
		
	</LinearLayout>

#### 线性布局

水平和垂直方向布局，可以通过

	android:orientation="vertical" 或者 "horizontal"

LinearLayout标签一个重要属性：gravity，用于控制布局中视图的位置

android:layout_width和android:layout_height属性

* wrap_content: 填满父控件的空白
* fill_parent: 表示大小刚好足够显示当前空间的内容
* match_parent:

android:layout_weight权重：控件占用的空间


	<LinearLayout ...
		android:orientation="vertical"
		android:layout_width="match_parent"
		android:layout_height="fill_parent"
	>
		...
		
	</LinearLayout>
	
	













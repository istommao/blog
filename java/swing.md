#Swing
===

##Swing组件的层次结构和继承关系

	Java.lang.Object类
   	   -->  Java.awt.Component类
   	      --> Java.awt.Container类
   	        --> Javax.swing.JComponent类
   	        
##常见组件

* JButton
* JCheckBox
* JComBox
* JFrame
* JDialog
* JLabel
* JRadioButton
* JList
* JTextField
* JPasswordField
* JTextArea
* JOptionPane


###JFrame

容器，是Swing程序中各个组件的载体

	JFrame jf = new JFrame(title);
	Container container = jf.getContentPane();
	container.add(new JButton("ok"));
	container.remove(new)
	...

###JDialog

	JDialog()
	JDialog(Frame f)
	JDialog(Frame f, boolean model)
	JDialog(Frame f, String title)
	JDialog(Frame f, String title, boolean model)

###JLabel
标签，可以显示一行只读文本、一个图像或带图像的文本

	JLabel()
	JLabel(Icon icon)
	JLabel(Icon icon, int aligment)
	JLabel(String text, int aligment)
	JLabel(String text, Icon icon, int aligment)

####Icon
Icon接口来创建图标，必须实现Icon接口的3个方法：

	int getIconHeight()
	int getIconWidth()
	void paintIncon(Component arg0, Graphics args, int arg2, int arg3)
	
###ImageIcon

##布局管理器

###绝对布局

* 取消布局布局管理器:container.setLayout(null)
* 绝对定位setBounds()

###流布局管理器

FlowLayout：从左到右摆放，当组件填满一行后，将自动换行
		
###边界布局管理器

BorderLayout: 根据方位划分区域	


###网格布局管理器

GridLayout: 

##常用面板

###JPanel

聚集一些组件来布局，因此面板也是一种容器。

###JScrollPane

带滚动条的面板


##按钮组件

###JButton

###JRadioButton

按钮组：ButtonGroup

###JCheckBox

##列表组件

###下拉列表框：JComboBox

####JComboBox模型
一般将下拉列表框中的项目封装为ComboBoxModel（接口），代表一般模型。可以自定一个类实现该接口，然后初始化JComboBox对象是向上转型为ComboBoxModel接口类型，但必须实现:

* void setSelectedItem(Object item)
* Object getSelectedItem()

###列表框组件JList

列表框在窗体上占据固定的大小，如果需要列表框具有滚蛋效果，可将列表框放入滚动面板中。

##文本组件

###文本框JTextField

###密码框JPasswordField

###文本域JTextArea

##常用事件监听器

事件源、事件、监听程序

###动作事件监听器
|事件名|事件源|监听接口|添加、删除监听器方法|
|:--:|:--:|:--:|:--:|
|ActionEvent|JButton、JList、JTextFiedl等|ActionListener|addActionLIstener()、removeActionListener()|

为事件源做监听事件时通常使用(匿名)内部类。否则，会出现问题。

###焦点事件监听器
|事件名|事件源|监听接口|添加、删除监听器方法|
|:--:|:--:|:--:|:--:|
|FocusEvent|Compnent及其派生类等|FocusListener|addFocusListener()、removeFocusListener()|


	
	
	
	
	
	
	
	
	
	
	
	
		
		
	
	 
  	        
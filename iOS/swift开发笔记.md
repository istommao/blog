#swift开发笔记


##导航控制器

controller

	RootViewController.swift
	class RootViewController: UIViewController{
		override func viewDidLoad() {
			self.title = "ios";
			
			// 放一个UIbarButtonItem
			let nextItem = UIBarButtonItem(title:"下一页", style:.Plain, target:self, action:"nextPage")
		
			self.navigationItem.rightBarButtonItem = nextItem;
		}
		
		func nextPage() {
			NSLog("click nextPage");
			// 推出下一页
			let svc = SecondViewController();
			// 推出下一界面，指定动画
			self.navagationController.pushViewController(svc, animated:true);
		}
	}
	
	SecondViewController.swift
	class SecondViewController:UIViewController {
		override func viewDidLoad() {
			super.viewDidLoad();
			self.title = "第二页"；
			
			self.view.backgroundColor = UIColor.redColor();
			
			var b = UIButton.buttonWithType(.System) as Button;
			var frame = CGRect(x:100, y:100, width:100, height:40);
			b.frame = frame;
			// 按钮标题
			b.setTile("返回上一层", forState:.Normal);
			// 给按钮加上点击事件， 调用sefl clickMe:
			b.addTarget(self, action:"clickMe:", forControlEvents:.TouchUpInside);
			self.view.addSubview(b);
		}
		
		func clickMe(sender:UIButton) {
			self.navigationController.popViewControllerAnimated(true);
		}
	}
	
##代理反向传值

第二个页面设置字体，第一个页面使用第二个页面传递回来的字体大小

	RootViewController.swift
	class RootViewController: UIViewController{
		var myLabel:UILabel?; //声明一个全局UILabel对象
		override func viewDidLoad() {
			self.title = "ios";
			
			// 放一个UIbarButtonItem
			let nextItem = UIBarButtonItem(title:"下一页", style:.Plain, target:self, action:"nextPage")
		
			self.navigationItem.rightBarButtonItem = nextItem;
			
			// 放一个Label
			let rect = CGRect(x:0, y:100, width:320, height:40);
			myLabel = UILabel(frame:rect);
			myLabel!.text = "iOS/swift";
			self.view.addSubview(myLabel);
			
			
		}
		
		func nextPage() {
			NSLog("click nextPage");
			// 推出下一页
			let svc = SecondViewController();
			// 设置这个协议
			svc.delegate = self;
			// 推出下一界面，指定动画
			self.navagationController.pushViewController(svc, animated:true);
		}
		
		// 代理实现方法
		func fontSizeDidChange(controller:SecondViewController, fontSize:Int) {
			println("controller is \(controller), fontsize \(fontSize)");
			
			let font = UIFont.systemFontOfSize(Float(fontSize));
			myLabel!.font = font	
		}
	}
	
	// 定义一个协议
	protocol FontSizeChangeDelegate: NSObjectProtocol {
		// 定义一个协议函数/代理一个函数
		func fontSizeDidChange(controller:SecondViewController, fontSize:Int) {
			
		}
	}
	
	SecondViewController.swift
	class SecondViewController:UIViewController, FontSizeChangeDelegate {
		var fontSize:Int = 20;
		// 定义一个代理
		var delegate:FontSizeChangeDelegate?;
		override func viewDidLoad() {
			super.viewDidLoad();
			self.title = "第二页"；
			
			self.view.backgroundColor = UIColor.redColor();
			
			var b = UIButton.buttonWithType(.System) as Button;
			var frame = CGRect(x:100, y:100, width:100, height:40);
			b.frame = frame;
			// 按钮标题
			b.setTile("增大字体大小", forState:.Normal);
			// 给按钮加上点击事件， 调用sefl clickMe:
			b.addTarget(self, action:"clickMe:", forControlEvents:.TouchUpInside);
			self.view.addSubview(b);
		}
		
		func clickMe(sender:UIButton) {
			fontSize++;
			println("font size: \(fontSize)");
			if (delegate) {
				// 调用协议方法
				delegate?.fontSizeDidChagne(self, fontSize);
			}
		}
	}
	
##TabBarController使用

	FirstViewController.swift
	
	class FirstViewController : UIViewController {
		override func viewDidLoad {
			super.viewDidLoad();
			self.view.backgroundColor = UIColor.greenColor();
		}
	
	}
	
	SecondViewController.swift
	
	class SecondViewController : UIViewController {
		override func viewDidLoad {
			super.viewDidLoad();
			self.view.backgroundColor = UIColor.redColor();
		}
	
	}
	
	ThirdViewController.swift
	
	class ThirdViewController : UIViewController {
		override func viewDidLoad {
			super.viewDidLoad();
			self.view.backgroundColor = UIColor.blueColor();
		}
	
	}
	
	AppDelegate.swift
	class AppDelegate : UIResponder, UIApplicationDelegate {
		...
		func application(...) {
			...
			// 创建3个页面
			let vc1:UIViewController = FirstViewController();
			let nav1 = UINavigationController(rootViewCOntroller:vc1);
			let image1 = UIImage(named:"1.png");
			nav1.tabBarItem = UITabBarItem(title:"会话"， image:image1, tag:1);
			
			let vc2:UIViewController = FirstViewController();
			let nav2 = UINavigationController(rootViewCOntroller:vc1);
			nav2.tabBarItem = UITabBarItem(title:"2"， image:nil, tag:2);
			
			let vc3:UIViewController = FirstViewController();
			let nav3 = UINavigationController(rootViewCOntroller:vc1);
			nav3.tabBarItem = UITabBarItem(title:"3"， image:nil, tag:3);
			
			let arr = [nav1, nav2, nav3];
			let tabBarController = UITabBarCOntroller();
			tabBarController.viewControllers = arr;
			self.window!.rootViewController = tabBarController;
			...
		}
	}


##TableView
	AppDelegate.swift
	class AppDelegate : UIResponder, UIApplicationDelegate {
		...
		func application(...) {
			...
			// 
			let rcv:UIViewController = RootViewController();
			let nav = UINavigationController(rootViewCOntroller:rcv);			
			self.window!.rootViewController = nav;
			...
		}
	}
	
	RootViewController.swift
	
	class RootViewController : UIViewController, UITableVIewDelegate, UITableViewDataSource {
		// 数据源NSMutableArray
		var dataArr = NSMutableArray();
		// 全局tableView对象
		var _tableView: UITableView?;
		
		override func viewDidLoad {
			super.viewDidLoad();
			// 初始化数据源
			for (var i = 0; i < 100; i++) {
				dataArr.addObject("row \(i)");
			}
			
			var rect:CGRect= self.view.bounds;//取得self.view区域
			_tableView= UITableView(frame:rect, style:.Plain);
			_tableView!.delegate = self;
			_tableView!.dataSource = self;
			self.view.addSubview(_tableView)
		}
		
		func tableView(tableView: UITableView!, numberOfRowsInSection section:Int) -> Int {
			return dataArr.count;
		}
		
		func tableView(tableView: UITableView!, cellOfRowAtIndexPath indexPath:NSIndexPath!) -> Int {
			let cellid = "my cell id";
			var cell = tableView.dequeReusableCellViwhIdentifier(cellid) as ?UITableViewCell;
			if (cell == nil) {
				cell = UITableViewCell(style:.Default, reuseIdentifier:cellid);
			}
			var s = dataArr.objectAtIndex(indexPath.row) as ?String;
			cell!.textLabel.text = s;
			return cell;
		}
		
		// 点击cell进行回调
		func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
			println("row \(indexPaht.row) selected");
		}
	
	}
		
##swift调用oc代码
	AppDelegate.swift
	class AppDelegate : UIResponder, UIApplicationDelegate {
		...
		func application(...) {
			...
			// 创建QFImage
			let img = UIImage(named:"test.png");
			let iv = QFImage(frame:CGRectMake(100, 200,100,100));
			iv.image = img;
			
			// 加点击事件, addTarget对应oc里的方法，注意两者之间的对应关系
			// 第一个参数不能有标签，后面的需要标签
			iv.addTarget(self, withSelector:"imageClick:");
			iv.test();
			let v = iv.getImageValue();
			println("v is \(v)");
			// 此处没创建ViewController，直接添加到window
			self.window!.addSubview(iv);
			...
		}
		
		// 点击回调方法
		func imageClick(sender:QFImageView) {
			NSLog("click \(sender)");
		}
	}
	
	创建oc类QFImageView生成：QFImageView.h/.m，同时生成SwiftCallOC-Bridging-Header.h
	SwiftCallOC-Bridging-Header.h
	// 包含所有swift所有需要调用的oc类
	import "QFImageView.h"
	
	QFImageView.h
	@interface QFImageView:UIImageView {
		id _target;
		SEL _sel;
	}
	
	-（void）test;
	-(NSString *)getImageValue;
	
	// 
	- (void) addTaget:(id)target withSelector:(SEL)sel;
	
	@end	
	
	QFImageView.m
	@implementation QFImageView
	- (void) addTaget:(id)target withSelector:(SEL)sel {
		_target = target;
		_sel = sel;
		self.userInterationEnabled = YES;
	}
	
		-(void) touchedEnded:(NSSet *)touches withEvent:(UIEvent *)event {
			if (_target) {
				[_target performSelector:_sel withObject:self];
			}
		}	
		
		-(void) test {
			NSLog(@"test in QFImageView");
		}	
		
		(NSString *)getImageValue{
			return @"QFImageView";
		}
	}
	@end
	
##oc调用swift

	AppDelegate.swift
	class AppDelegate : UIResponder, UIApplicationDelegate {
		...
		func application(...) {
			...
			// 创建QFImage
			let img = UIImage(named:"test.png");
			let iv = QFImage(frame:CGRectMake(100, 200,100,100));
			iv.image = img;
			
			// 加点击事件, addTarget对应oc里的方法，注意两者之间的对应关系
			// 第一个参数不能有标签，后面的需要标签
			iv.addTarget(self, withSelector:"imageClick:");
			iv.test();
			let v = iv.getImageValue();
			println("v is \(v)");
			// 此处没创建ViewController，直接添加到window
			self.window!.addSubview(iv);
			...
		}
		
		// 点击回调方法
		func imageClick(sender:QFImageView) {
			NSLog("click \(sender)");
		}
	}
	
	创建oc类QFImageView生成：QFImageView.h/.m，同时生成SwiftCallOC-Bridging-Header.h
	SwiftCallOC-Bridging-Header.h
	// 包含所有swift所有需要调用的oc类
	import "QFImageView.h"
	
	QFImageView.h
	@interface QFImageView:UIImageView {
		id _target;
		SEL _sel;
	}
	
	-（void）test;
	-(NSString *)getImageValue;
	
	// 
	- (void) addTaget:(id)target withSelector:(SEL)sel;
	
	@end	
	
	QFImageView.m
	
	// 如果oc要调用swift代码，需要包含头文件：项目名称-Swift
	#import <SwiftCallOC-Swift.h>
	@implementation QFImageView
	- (void) addTaget:(id)target withSelector:(SEL)sel {
		_target = target;
		_sel = sel;
		self.userInterationEnabled = YES;
		
		// 调用swift中的方法
		TestSwift *ts = [[TestSwift alloc] init];
		[ts someFunc];
		
		NSArray *arr = [ts getArrayByValue:@"ios", v2:@"swift"];
		for (NSString *s in arr) {
			NSLog(@"s is %@", s);
		}
		
		arr = [ts getArrayByValue:@"ios", withValue:@"swift", withValue:@"oc"];
		for (NSString *s in arr) {
			NSLog(@"s is %@", s);
		}
	}
	
		-(void) touchedEnded:(NSSet *)touches withEvent:(UIEvent *)event {
			if (_target) {
				[_target performSelector:_sel withObject:self];
			}
		}	
		
		-(void) test {
			NSLog(@"test in QFImageView");
		}	
		
		(NSString *)getImageValue{
			return @"QFImageView";
		}
	}
	@end
	
	TestSwift.swift
	
	class TestSwift:NSObject{
		init() {
			println("in init");
		}
		func someFunc() {
			println("in some func");
		}
		func getArrayByValue(v1:String, v2:String) -> NSArray {
			return [v1, v2];
		}
		// 带标签
		func getArrayByValue(v1:String, withValue v2:String, withValue v3:String) -> NSArray {
			return [v1, v2, v3];
		}
	}


##网络下载
	
	AppDelegate.swift
	class AppDelegate : UIResponder, UIApplicationDelegate {
		...
		func application(...) {
			...
			// 创建3个页面
			let rcv:UIViewController = RootViewController();
			let nav = UINavigationController(rootViewCOntroller:rcv);			
			self.window!.rootViewController = nav;
			...
		}
	}
	
	RootViewController.swift
	// 列表数据
	let urlpath = "http://xxx/app/demo.json"
	class RootViewController : UIViewController, UITableVIewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate {
		// 数据源NSMutableArray
		var dataArr = NSMutableArray();
		// 全局tableView对象
		var _tableView: UITableView?;
		var _connection: NSURLConnection?;
		//var _recvData:NSMutableData?;
		@lazy var _recvData = NSMutableData();
		override func viewDidLoad {
			super.viewDidLoad();
			self.title = "网路下载";
			
			var rect:CGRect= self.view.bounds;//取得self.view区域
			_tableView= UITableView(frame:rect, style:.Plain);
			_tableView!.delegate = self;
			_tableView!.dataSource = self;
			self.view.addSubview(_tableView);
			
			downloadData();
		}
		
		func downloadData()
		{
			let url = NSURL(string:urlpath);
			let request = NSURLRequest(URL:url);
			// 创建连接
			_conncetion = NSURLCOnnectio(request:request, delegate:self)
		}
		func tableView(tableView: UITableView!, numberOfRowsInSection section:Int) -> Int {
			return dataArr.count;
		}
		
		func tableView(tableView: UITableView!, cellOfRowAtIndexPath indexPath:NSIndexPath!) -> Int {
			let cellid = "my cell id";
			var cell = tableView.dequeReusableCellViwhIdentifier(cellid) as ?UITableViewCell;
			if (cell == nil) {
				cell = UITableViewCell(style:.Default, reuseIdentifier:cellid);
			}
			var s = dataArr.objectAtIndex(indexPath.row) as ?String;
			cell!.textLabel.text = s;
			return cell;
		}
		
		// 点击cell进行回调
		func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
			println("row \(indexPaht.row) selected");
			
		}
		
		// 接收到响应头
		func connection(connection:NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
			// _recvData = NSMutableData();
		}
		
		// 接收到一段数据，被调用多次
		func connection(connection:NSURLConnection!, didReceiveData data:NSData!) {
			_recvData.appendData(data);
		}
		
		// 接收完成
		func connectionDidFinishLoading(connection:NSURLConnection!) {
			let s = NSString(data:_recvData, encoding:NSUTF8StringEncoding);
			println("s is \(s)");
			// 解析和tableview刷新
			// videoModel, json解析并强制转为NSArray
			let videoArr = NSJSONSerialization.JSONObjectWithData(_recvData, options:MutableContainers, error:nil) as? NSArray;
 			
 			if (videoArr?.count > 0) {
 				for (var i = 0; i < videoArr?.cound; i++) {
 				
 				}
 			}
 			
 		}
	
	}	
	
	import UIKit
	class VideoModel:NSObject {
		var name:String?;
		var date:String?;
		var author:String?;
	}
			
	
	
	
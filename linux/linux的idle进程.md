title: linux的idle进程
date: 2016-05-23 21:22:00
tags:
- linux
- idle
- init
- kthreadd

# linux的idle进程

> Linux下有3个特殊的进程，`idle`进程(PID = 0), `init`进程(PID = 1)和`kthreadd`(PID = 2)

* `idle`进程由系统自动创建, 运行在内核态 

	`idle`进程其`pid=0`，其前身是系统创建的第一个进程，也是唯一一个没有通过`fork`或者`kernel_thread`产生的进程。完成加载系统后，演变为进程调度、交换
	
* `init`进程由`idle`通过`kernel_thread`创建，在内核空间完成初始化后, 加载`init`程序, 并最终用户空间 
	
	由0进程创建，完成系统的初始化. 是系统中所有其它用户进程的祖先进程。Linux中的所有进程都是有init进程创建并运行的。首先Linux内核启动，然后在用户空间中启动init进程，再启动其他系统进程。在系统启动完成完成后，init将变为守护进程监视系统其他进程。

* `kthreadd`进程由`idle`通过`kernel_thread`创建，并始终运行在内核空间, 负责所有内核线程的调度和管理 

	它的任务就是管理和调度其他内核线程`kernel_thread`, 会循环执行一个`kthread`的函数，该函数的作用就是运行`kthread_create_list`全局链表中维护的`kthread`, 当我们调用`kernel_thread`创建的内核线程会被加入到此链表中，因此所有的内核线程都是直接或者间接的以`kthreadd`为父进程 
	
## 总结

系统允许一个进程创建新进程，新进程即为子进程，子进程还可以创建新的子进程，形成进程树结构模型。整个linux系统的所有进程也是一个树形结构。树根(`init_task`，后变为`idle`)是系统自动构造的(或者说是由内核黑客手动创建的)，即在内核态下执行的0号进程，它是所有进程的远古先祖。

> 在smp系统中，每个处理器单元有独立的一个运行队列，而每个运行队列上又有一个idle进程，即有多少处理器单元，就有多少idle进程。

* `idle`进程其pid=0，其前身是系统创建的第一个进程(我们称之为`init_task`)，也是唯一一个没有通过fork或者kernel_thread产生的进程。
* `init_task`是内核中所有进程、线程的`task_struct`雏形，它是在内核初始化过程中，通过静态定义构造出了一个`task_struct`接口，取名为`init_task`，然后在内核初始化的后期，在`rest_init`()函数中通过`kernel_thread`创建了两个内核线程内核`init`线程和`kthreadd`内核线程, 前者后来通过演变，进入用户空间，成为所有用户进程的先祖, 而后者则成为所有内核态其他守护线程的父线程, 负责接手内核线程的创建工作
* 然后`init_task`通过变更调度类为`sched_idle`等操作演变成为`idle`进程, 此时系统中只有`0(idle), 1(init), 2(kthreadd)` 3个进程, 然后执行一次进程调度, 必然切换当前进程到到`init`。

	



## 参考

* [Linux下0号进程的前世](http://blog.csdn.net/gatieme/article/details/51484562)
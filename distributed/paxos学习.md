title: Paxos学习
date: 2016-05-13 11:27:00
tags:
- Paxos
- concurrency control
- distrubuted


# Paxos学习

看到[可靠分布式系统基础 Paxos 的直观解释](http://drmingdrmer.github.io/tech/distributed/2015/11/11/paxos-slide.html) 这篇文章，图文并茂，写的简单易懂，特此摘录，加深理解。至于图片就不截取了。忘记的时候可以重新读取原文。

同时，备份了[原文pdf](https://github.com/zhuwei05/blog-resources/blob/master/distributed/paxos.pdf)

## 背景

由于

* 磁盘（4%年损坏率）
* 服务器宕机时间(>=0.1%)
* IDC间丢包率（5%~30%）

而我们对系统需求要：>= 99.999%

因此其中一个解决方案就是`多节点`，实现`多副本`解决这个问题。

多副本可靠性：

* 1 副本: ~ 0.63%
* 2 副本: ~ 0.00395%
* 3 副本: < 0.000001%
* n 副本: = 1 - x^n /* x = 单副本损坏率 */

`多副本处理副本数n之外，还要考虑：可用性、原子性、一致性......`


`分布式多节点`：

* 多个节点一起完成一件事
* 分布式中唯一的问题：对某事达成一致
* Paxos：分布式系统的核心算法

## 多副本复制方案

* 主从异步复制 
* 主从同步复制 
* 主从半同步复制 
* 多数派写(读)

### 主从异步复制

如Mysql的binlog复制.
1. 主接到写请求.2. 主写入本磁盘.3. 主应答‘OK’.4. 主复制数据到从库.
  `问题：`
* 如果磁盘在复制前损坏: 数据丢失.
### 主从同步复制
1. 主接到写请求.2. 主复制日志到从库.3. 从库这时可能阻塞...4. 客户端一直在等应答’OK’,直到所有从库返回.

`问题：`

* 一个失联节点造成整个系统 不可用.
* 没有数据丢失.* 可用性降低.

### 主从半同步复制

1. 主接到写请求.2. 主复制日志到从库.3. 从库这时可能阻塞...4. 如果1<=x<=n个从库返回‘OK’,则返回客户端‘OK‘
  `问题：`

* 高可靠性.
* 高可用性.* 可能任何从库都不完成.
  **基于上述几种方案的问题，新的解决方法：多数派写（读）**

### 多数派写(读)

* 客户端写： W >= N/2 + 1 个节点，不需要主
* 客户端读： W + R > N ==> R >= N/2 + 1
* 容忍最多 (N - 1) / 2 个节点损坏

多数派写特定：

* 最后一次写入覆盖之前写入
* 所有写入操作需要一个全局顺序：时间戳

`多数派写的问题`：

* 一致性：最终一致性
* 事务性：非原子更新、脏读、更新丢失问题

参考：[Concurrency control](http://en.wikipedia.org/wiki/Concurrency_control)

比如：两个写操作需要先后对i=0进行+1，+2操作，这是由于非原子更新，就得不到想要的结果3（可能为1，2或3）。要解决这个问题需要引入：`写前读取机制`

#### 写前读取

> 要保证并发问题可靠性，就要符合：整个系统对i的某个版本，只能有一次成功写入。
>
> 推广：在存储系统中,一个值(1个变量的1个版本)在`被认为确定`(客户端接到OK)之后,就不允许被修改(产生新的版本).
>

即：

需要解决两个问题：

* 如何定义一个值为：`被确定的`

  > 原始方案：每次写入一个值前,先运行一次多数派读,来确认是 否这个值(可能)已经被写过了.

  > 但是, X操作和Y操作可能同时以为还没有值被写入过,然后同时开始 写。

  > 改进方案：让存储节点记住谁最后1次做过“写前读取”,并拒绝之前其他的“写前读取”的写入操作

* 如何避免修改 `被确定的` 值


## Paxos

### 简介

* 一个可靠的存储系统: 基于多数派读写. 
* 每个paxos实例用来存储一个值.
* 用2轮RPC来确定一个值.
* 一个值‘确定’后不能被修改.
* ‘确定’指被多数派接受写入. 
* 强一致性.

### 分类

* Classic Paxos：1个实例(确定1个值)写入需要2轮RPC.
* Multi Paxos：约为1轮RPC,确定1个值(第1次RPC做了合并).
* Fast Paxos：没冲突:1轮RPC确定一个值. 有冲突:2轮RPC确定一个值

### Paxos执行条件

* 存储必须是可靠的，没有数据丢失和错误。（注：否则需要用Byzantine Paxos）
* 容忍：消息丢失（节点不可达）、消息乱序

### 基本概念

* `Proposer`: 发起Paxos的进程
* `Acceptor`: 存储节点，接受、处理和存储消息
* `Quorum`: Acceptor的多数派，在Classic中值为: (N/2 + 1) 个Acceptor
* `Round`：1轮包含2个阶段：Phase-1 和 Phase-2
* `rnd`：每一轮的编号，单调递增，后写胜出，全局唯一（用于区分Proposer）
* `last_rnd`: Acceptor看到的最大rnd，Acceptor记住这个值来识别哪个Proposer可以写
* Vlaue（`v`）: Acceptor接受的值
* `vrnd`: value round number，Acceptor接受v的时候的rnd
* `值被确定的定义`: 有多数（多于半数，Quorum）个Acceptor接受了这个值。

### Classic

#### Phase-1

首先，`Proposer`发送`phase-1`；

然后，当`Acceptor`收到`phase-1`的请求时:

* 如果请求中`rnd`比`Acceptor`的`last_rnd`小,则拒绝请求* 将请求中的`rnd`保存到本地的`last_rnd`. 从此这个`Acceptor`只接受带有这个`last_rnd`的`phase-2`请求。* 返回应答, 带上自己之前的`last_rnd`和之前已接受的`v`.
  最后，当`Proposer`收到`Acceptor`的应答时:
* 如果应答中的`last_rnd`大于发出的`rnd`: 退出.* 从所有应答中选择`vrnd`最大的`v`: 不能改变(可能)已经确定的值。Q：为什么不退出？A: 这样操作可以进入Phase-2，使得数据达到一致性* 如果所有应答的`v`都是空, 可以选择自己要写入`v`. 
* 如果应答不够多数派,退出

#### Phase-2

首先，`Proposer`发送`phase-2`，带上`rnd`和上一步决定的`v`；

然后，`Acceptor`：

* 拒绝`rnd`不等于`Acceptor`的`last_rnd`的请求
* 将`phase-2`请求中的`v`写入本地,记此`v`为‘已接受的值’* `last_rnd==rnd`，保证没有其他`Proposer`在此过程中写入过其他值

### Paxos的其他

`Learner`角色:

* Acceptor发送`phase-3 `到所有`learner`角色,让`learner`知道一个值被确定了.
* 多数场合`Proposer`就是1个`Learner`.

`Livelock`: 

多个`Proposer`并发对1个值运行`paxos`的时候,可能会互相覆盖对方的`rnd`,然后提升自己的`rnd`再次尝试, 然后再次产 生冲突,一直无法完成
### Multi Paxos
> 将多个`paxos`实例的`phase-1`合并到1个RPC; 使得这些`paxos`只需要运行`phase-2`即可

应用：chubby、zookeeper、megastore、spanner

### Fast Paxos

* Proposer直接发送phase-2.* Fast Paxos的rnd是0.		0保证它一定小于任何一个Classic rnd ,所以可以在出现冲突时安全的回退 到Classic Paxos.* Acceptor只在v是空时才接受Fast phase-2请求* 如果发成冲突,回退到Classic Paxos, 开始用一个 rnd >0 来运行。
#### Fast Paxos的多数派

因为，发送冲突时，Fast Paxos通过`n/2 + 1`不能确定Acceptor返回的哪个v：可能被确定下来（汗，有点绕），因此需要改变其多数派的要求：

* Fast Paxos的多数派必须 `> n * 3/4`
* Fast Paxos的值被确定的条件是：被 `n * 3/4 + 1` 个Acceptor接受

后果：

* 可用性降低,因为Fast Paxos需要更多的Acceptor来工作.* Fast Paxos 需要至少5个Acceptors,才能容忍1个Acceptor不 可用.

注：Fast Paxos在phase-2，Acceptor可以接受 rnd >= last_rnd的请求

## 参考

* [可靠分布式系统基础 Paxos 的直观解释](http://drmingdrmer.github.io/tech/distributed/2015/11/11/paxos-slide.html)
* [wikipedia: Paxos](https://en.wikipedia.org/wiki/Paxos_\(computer_science\))
* [备份：原文pdf](https://github.com/zhuwei05/blog-resources/blob/master/distributed/paxos.pdf)
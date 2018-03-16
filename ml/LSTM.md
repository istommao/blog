# LSTM

## RNN

RNN 是包含循环的网络，允许信息的持久化。

RNN 可以被看做是同一神经网络的多次复制，每个神经网络模块会把消息传递给下一个。所以，如果我们将这个循环展开：

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdf4je4nj22360jrdiw.jpg)



在这个间隔不断增大时，RNN 会丧失学习到连接如此远的信息的能力



## LSTM网络

Long Short Term 网络—— 一般就叫做 LSTM ——是一种 RNN 特殊的类型，可以学习长期依赖信息。

LSTM 通过刻意的设计来避免长期依赖问题。记住长期的信息在实践中是 LSTM 的默认行为，而非需要付出很大代价才能获得的能力！

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdhlla7nj20yg0cydiz.jpg)



LSTM 的关键就是细胞状态，水平线在图上方贯穿运行。
细胞状态类似于传送带。直接在整个链上运行，只有一些少量的线性交互。信息在上面流传保持不变会很容易。

LSTM 有通过精心设计的称作为“门”的结构来去除或者增加信息到细胞状态的能力。门是一种让信息选择式通过的方法。他们包含一个 sigmoid 神经网络层和一个 pointwise 乘法操作

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdijqsd2j205i06qwed.jpg)



### 逐步理解 LSTM



**忘记门层**：决定丢弃信息

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdj9sixmj20yg0an75n.jpg)

更新门层：确定更新的信息

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdkipjuqj20yg0anwg7.jpg)

更新细胞状态

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdl067r1j20yg0an75r.jpg)

输出信息

![](http://ww1.sinaimg.cn/large/616fb088ly1flkdlef17vj20yg0anwg8.jpg)

## LSTM 的变体

* [Gers & Schmidhuber (2000)](ftp://ftp.idsia.ch/pub/juergen/TimeCount-IJCNN2000.pdf) 
*  [Gated Recurrent Unit (GRU) Cho, et al. (2014)](http://arxiv.org/pdf/1406.1078v3.pdf)
* [Depth Gated RNN Yao, et al. (2015)](http://arxiv.org/pdf/1508.03790v2.pdf) 
* [Greff, et al. (2015)](http://arxiv.org/pdf/1503.04069.pdf) 给出了流行变体的比较，结论是他们基本上是一样的

## 参考

* [理解 LSTM 网络](http://www.jianshu.com/p/9dc9f41f0b29)
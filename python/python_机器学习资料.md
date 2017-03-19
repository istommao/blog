# python 机器学习资料

* [从零开始掌握Python机器学习](http://www.jiqizhixin.com/article/2465)



## 从零开始掌握Python机器学习

### 科学计算 Python 软件包概述



* numpy——主要对其 N 维数组对象有用 http://www.numpy.org/ 
* pandas——Python 数据分析库，包括数据框架（dataframes）等结构 http://pandas.pydata.org/ 
* matplotlib——一个 2D 绘图库，可产生出版物质量的图表 http://matplotlib.org/ 
* scikit-learn——用于数据分析和数据挖掘人物的机器学习算法 http://scikit-learn.org/stable/ 

学习这些库的一个好方法是学习下面的材料：

* Scipy Lecture Notes，来自 Gaël Varoquaux、Emmanuelle Gouillart 和 Olav Vahtras：http://www.scipy-lectures.org/ 
* 这个 pandas 教程也很不错：10 Minutes to Pandas：http://suo.im/4an6gY 


### Python 上实现机器学习的基本算法

在有了 scikit-learn 的基本知识后，我们可以进一步探索那些更加通用和实用的算法。我们从非常出名的 K 均值聚类（k-means clustering）算法开始，它是一种非常简单和高效的方法，能很好地解决非监督学习问题：

* K-均值聚类：http://suo.im/40R8zf   

接下来我们可以回到分类问题，并学习曾经最流行的分类算法：

* 决策树：http://thegrimmscientist.com/tutorial-decision-trees/ 

在了解分类问题后，我们可以继续看看连续型数值预测：

* 线性回归：http://suo.im/3EV4Qn 

我们也可以利用回归的思想应用到分类问题中，即 logistic 回归：

* logistic 回归：http://suo.im/S2beL 


### Python 上实现进阶机器学习算法

我们已经熟悉了 scikit-learn，现在我们可以了解一下更高级的算法了。首先就是支持向量机，它是一种依赖于将数据转换映射到高维空间的非线性分类器。

* 支持向量机：http://suo.im/2iZLLa 

随后，我们可以通过 Kaggle Titanic 竞赛检查学习作为集成分类器的随机森林：

* Kaggle Titanic 竞赛（使用随机森林）：http://suo.im/1o7ofe 

降维算法经常用于减少在问题中所使用的变量。主成份分析法就是非监督降维算法的一个特殊形式：

* 降维算法：http://suo.im/2k5y2E 


### Python 深度学习
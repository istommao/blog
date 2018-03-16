# word2vec

## 简介



Word2vec是一个用于处理文本的双层神经网络。它的输入是文本语料，输出则是一组向量：该语料中词语的特征向量。虽然Word2vec并不是深度神经网络，但它可以将文本转换为深度神经网络能够理解的数值形式。

Word2vec的应用不止于解析自然语句。它还可以用于基因组、代码、点赞、播放列表、社交媒体图像等其他语言或符号序列，同样能够有效识别其中存在的模式。

为什么呢？因为这些数据都是与词语相似的离散状态，而我们的目的只是求取这些状态之间的转移概率，即它们共同出现的可能性。所以gene2vec、like2vec和follower2vec都是可行的。

Word2vec与自动编码器相似，它将每个词编码为向量，根据*输入语料中相邻的其他词来进行每个词的定型*。

具体的方式有两种，一种是用*上下文预测目标词*（连续词袋法，简称CBOW），另一种则是*用一个词来预测一段目标上下文*，称为skip-gram方法。我们使用后一种方法，因为它处理大规模数据集的结果更为准确。



## 参考

* [官方 tf word2vec](https://www.tensorflow.org/tutorials/word2vec) and [tf word2vec](http://adventuresinmachinelearning.com/word2vec-tutorial-tensorflow/)
* [Deeplearning4j word2vec](https://deeplearning4j.org/cn/word2vec)
* [jieba word2vec 训练维基百科词](https://codesky.me/archives/ubuntu-python-jieba-word2vec-wiki-tutol.wind)
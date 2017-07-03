title: pandas常见函数学习
date: 2017-07-24 18:29:00
tags:
- opencv

# pandas常见函数学习


## 基本统计特征函数

主要作为 `pandas` 的对象 `DataFrame` 或 `Series` 的方法

* sum(): 计算数据样本的总和(按列计算). D.sum()
* mean(): 计算数据样本的算术平均. D.mean()
* var(): 计算数据样本的方差. D.var()
* std(): 计算数据样本的标准差. D.std()
* corr(): 计算数据样本的 Spearman(Pearson) 相关系数矩阵. D.corr(method='pearson')/S1.corr(S2, method='pearson')
* cov(): 计算数据样本的协方差矩阵. D.cov()/S1.cov(S2)
* skew()/kurt(): 样本值的偏度(三阶矩)/峰度(四阶矩). D.skew()/D.kurt()
* describe ： 给出样本的基本描述(均值, 标准差, 最大值, 最小值, 分位数). D.describe()

## 拓展统计特征矩阵

cum 系列函数主要作为 DataFrame 或 Series 对象的方法出现

* cumsum(): 给出前 n 个数的和. D.cursum()
* cumprod(): 给出前 n 个数的积. D.curprod()
* cummax(): 给出前 n 个数的最大值. D.curmax()
* cummin(): 给出前 n 个数的最小值. D.curmin()


rolling 系列函数是 pandas 的函数

* rolling_sum(): 计算数据样本的总和(按列计算). pd.rolling_sum()
* rolling_mean():
* rolling_var()
* rolling_std():
* rolling_corr():
* rolling_cov():
* rolling\_skew()/rolling\_kurt():

## 统计作图函数

matplotlib/pandas:

* plot()
* pie()
* hist()

pandas:

* boxplot()
* plot(logy=True)
* plot(yerr=error)

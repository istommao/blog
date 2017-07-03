title: sklearn常见函数学习
date: 2017-07-24 22:48:00
tags:
- scipy
- sklearn


## sklearn



## knn

```
from sklearn.neibors import KNeighborsClassifier
knn = KNeighborsClassifier()
knn.fit(iris_X_train, iris_y_train) 
knn.predict(iris_X_test)

```

## Linear regression

```
from sklearn import linear_model
regr = linear_model.LinearRegression()
regr.fit(diabetes_X_train, diabetes_y_train)
print(regr.coef_)
np.mean((regr.predict(diabetes_X_test)-diabetes_y_test)**2)
regr.score(diabetes_X_test, diabetes_y_test) 
```

skrinkage: 降低噪声影响， `Ridge Regression`

```
regr = linear_model.Ridge(alpha=.1)
```

Sparsity: 稀疏矩阵, 将 `coef_` 的某些值设为 0， `Lasso (least absolute shrinkage and selection operator) Regression` 

```
regr = linear_model.Lasso()
scores = [regr.set_params(alpha=alpha
            ).fit(diabetes_X_train, diabetes_y_train
            ).score(diabetes_X_test, diabetes_y_test)            
       for alpha in alphas]
       
```


## LogisticRegression

```
logistic = linear_model.LogisticRegression(C=1e5)
logistic.fit(iris_X_train, iris_y_train)

```

Shrinkage and sparsity with logistic regression


* The `C` parameter controls the amount of regularization in the LogisticRegression object: a large value for C results in less regularization. 
* `penalty="l2"` gives `Shrinkage` (i.e. non-sparse coefficients), while `penalty="l1"` gives `Sparsity`.


## SVM

`SVMs` can be used in regression –`SVR` (Support Vector Regression)–, or in classification –`SVC` (Support Vector Classification).

```
from sklearn import svm
svc = svm.SVC(kernel='linear') # kernale='linear'/ 'poly' / 'rbf' 
svc.fit(iris_X_train, iris_y_train)
```

## score 和 cross-validated scores

* 每个 `estimator` 都有 `fit()`, `predict()` 和 `score()` 方法
* `estimator` 的估计参数都可在初始化估计器或之后通过修改对应的属性进行设置
* 得到的估计结果都可以通过带后缀 `_` 的属性获得

### KFold

```
from sklearn.model_selection import KFold, cross_val_score
X = ["a", "a", "b", "c", "c", "c"]
k_fold = KFold(n_splits=3)
for train_indices, test_indices in k_fold.split(X):
     print('Train: %s | test: %s' % (train_indices, test_indices))
     
Train: [2 3 4 5] | test: [0 1]
Train: [0 1 4 5] | test: [2 3]
Train: [0 1 2 3] | test: [4 5]
```

cross validation

```
kfold = KFold(n_splits=3)
[svc.fit(X_digits[train], y_digits[train]).score(X_digits[test], y_digits[test])
         for train, test in k_fold.split(X_digits)]
```

或者使用 `cross_val_score`

```
cross_val_score(svc, X_digits, y_digits, cv=k_fold, n_jobs=-1)
```

### cross validation 函数

* KFold/StratifiedKFold/GroupFold
* ShuffleSplit/StratifiedShuffleSplit/GroupShuffleSplit
* LeaveOneGroupOut/LeavePGroupsOut/LeaveOneOut/LeavePOut
* PrefinedSplit


### grid search

```
from sklearn.model_selection import GridSearchCV, cross_val_score
Cs = np.logspace(-6, -1, 10)
clf = GridSearchCV(estimator=svc, param_grid=dict(C=Cs),
                   n_jobs=-1)
clf.fit(X_digits[:1000], y_digits[:1000])        

clf.best_score_                                  

clf.best_estimator_.C                            


# Prediction performance on test set is not as good as on train set
clf.score(X_digits[1000:], y_digits[1000:])    
```


## 聚类 cluster

```
from sklearn import cluster
from sklearn.cluster import AgglomerativeClustering

```


## Decompositions

### PCA: Principal component analysis

```
# Create a signal with only 2 useful dimensions
x1 = np.random.normal(size=100)
x2 = np.random.normal(size=100)
x3 = x1 + x2
X = np.c_[x1, x2, x3]

from sklearn import decomposition
pca = decomposition.PCA()
pca.fit(X)


print(pca.explained_variance_)  


# As we can see, only the 2 first components are useful
pca.n_components = 2
X_reduced = pca.fit_transform(X)
X_reduced.shape
```

### ICA: Independent Component Analysis

```

```


## 组合多个 estimators: pipeline

```
from sklearn import linear_model, decomposition, datasets
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV

logistic = linear_model.LogisticRegression()

pca = decomposition.PCA()
pipe = Pipeline(steps=[('pca', pca), ('logistic', logistic)])

digits = datasets.load_digits()
X_digits = digits.data
y_digits = digits.target

###############################################################################
# Plot the PCA spectrum
pca.fit(X_digits)

plt.figure(1, figsize=(4, 3))
plt.clf()
plt.axes([.2, .2, .7, .7])
plt.plot(pca.explained_variance_, linewidth=2)
plt.axis('tight')
plt.xlabel('n_components')
plt.ylabel('explained_variance_')

###############################################################################
# Prediction

n_components = [20, 40, 64]
Cs = np.logspace(-4, 4, 3)

#Parameters of pipelines can be set using ‘__’ separated parameter names:

estimator = GridSearchCV(pipe,
                         dict(pca__n_components=n_components,
                              logistic__C=Cs))
estimator.fit(X_digits, y_digits)

plt.axvline(estimator.best_estimator_.named_steps['pca'].n_components,
            linestyle=':', label='n_components chosen')
plt.legend(prop=dict(size=12))

```

## sklearn常见函数学习


* sklearn.decomposition.PCA(n_components, copy=True, whiten=False)
* sklearn.linear_model.LogisticRegression/RandomizedLogisticRegression
* sklearn.tree.DecisionTreeClassifier
* sklearn.cluster.KMeans/AffinityPropagation/MeanShift/SpectralClustering/AgglomerativeClustering/DBSCAN/BIRCH
* sklearn.svm.SVC
* sklearn.linear_model.AdaptiveLasso
* 




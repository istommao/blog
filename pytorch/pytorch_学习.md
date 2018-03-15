title: pytorch 学习
date: 2018-03-14 18:35:49
tags:

- pytorch
- ml

----

# pytorch 学习



## 基础

### 张量

```python
a = torch.Tensor([[2, 3], [4, 5], [6, 7]])
b = torch.LongTensor([[2, 3], [4, 5], [6, 7]])
c = torch.zeros((3, 2))
d = torch.randn((3, 2))
a[0, 1] = 100
# tensor <-> umpy.ndarray
n_b = b.numpy()
e = np.array([[2, 3], [4, 5]])
t_e = torch.from_numpy(e)
# 类型转换
f_a = a.float()
f_t_e = t_e.float()
# gpu
if torch.cuda.is_available():
    a_cuda = a.cuda()
```

### Variable

Variable 提供了自动求导的功能。`torch.autograd.Variable` 有：`data`, `grad`, `grad_fn` 等属性

```
# Create Variables
x = Variable(torch.Tensor([1]), requries_grad=True)
w = Variable(torch.Tensor([2]), requries_grad=True)
b = Variable(torch.Tensor([3]), requries_grad=True)

# Build computational graph
y = w * x + b

# Compute gradients
y.backward() # 对标量求导, 可以省略参数. 等价于 y.backward(torch.FloatTensor([1]))

print(x.grad)
print(w.grad)
print(b.grad)
```

```
x = torch.randn(3)
x = Variable(x, requires_grad=True)
y = x * 2

y.bachward(torch.FloatTensor([1, 0.1, 0.01]))

print(x.grad)
```



### 数据集

`torch.utils.data.Dataset` 代表数据的抽象类，定义数据类继承和重写这个抽象类，只需要定义 `__len__()` 和 `__getitem__()`

`torch.utils.data.DataLoader` 来定义一个迭代器

计算机视觉数据还有专门的一个类 	`ImageFolder`，主要功能是处理图片，且要求图片的存放形式:

```
root/dog/xxx.png
root/dog/xxy.png
root/dog/xxz.png

root/cat/123.png
root/cat/124.png
root/cat/125.png
```

### nn.Module  

pytorch 编写神经网络，所有的层结构和损失函数都来自 `torch.nn` , 其中模板可以为：

```python
class XxxNet(nn.Module):

    def __init__(self, **args):
        super(XxxNet, self).__init__(**args)
        self.conv1 = nn.Conv2d(in_channels, out_channels, kernel_size)
        # other newword layers

    def forward(self, x):
        x = self.conv1(x)
        return x
```

#### 损失函数

```python
criterion = nn.CrossEntropyLoss()
loss = criterion(output, target)
```

#### 优化

```python
optimizer = torch.optim.SGD(model.parameters(), lr=0.01, momentum=0.9)
```

#### 模型保存和加载

```python
# 保存整个模型的结构和参数
torch.save(model, './model.pth')
loaded_model = troch.load('model.pth')

# 保存模型的参数
torch.save(model.state_dict(), './model_state.pth')
# 需要先导入模型的接口，然后加载模型的参数
loaded_model_state = torch.load_state_dic(torch.load('model_state.pth'))

```
































title: pytest使用手册
date: 2016-11-15 13:59:00
tags:
- pytest
- mock

# pytest使用手册

## quick start

* py.test 框架会在它测试的项目中寻找 conftest.py 文件，然后在这个文件中寻找针对整个项目的选项，比如是否检测并运行 doctest 以及应该使用哪种模式检测测试文件和函数


### run tests

```
pytest tests/ (all tests)
pytest -k filenamekeyword (tests matching keyword)
pytest tests/utils/test_sample.py (single test file)
pytest tests/utils/test_sample.py::test_answer_correct (single test method)
pytest --resultlog=testlog.log tests/ (log output to file)
pytest -s tests/ (print output to console)
```

### demos

import:

```
import mock 
import pytest
from pytest_mock import mocker 
from src.jobitems import manager
```

确保被测方法调用的 `子方法(带参数)` 被调用：先 `mock` 子方法 `sub_method`, 然后调用被测试方法：`method_under_test`, 最后断言子方法被调用: `assert_called_with`, 该方法用来判断是否被调用

```
def test_update_jobs_fleet_capacity(mocker):
  mocker.patch.object(manager, 'sub_method') 
  manager.sub_method.return_value = 120 
  manager.method_under_test()
  manager.sub_method.assert_called_with('somestring', 1, 120)
```

mock 另一个模块的 class：

```
def test_helper_class(mocker):
  mocker.patch.object(manager, 'other_class')
  manager.other_class.other_method.return_value = 50
  manager.method_under_test('option1')
  manager.other_class.other_method.assert_called_with(120)
```


使用多个参数进行测试：

```
@pytest.mark.parametrize('test_type, var1, var2, expect', [
  ('verify_max_returned', 'apple', 90, 100),
  ('verify_min_returned', 'orange', 2, 10)
])
def test_get_size(mocker, test_type, var1, var2, expect):
  print("Logging test type for visibility: " + test_type)
  assert fleet_manager.get_optimal_size('zone1', var1, 
    var2) == expect
```

失败情况的测试：

```
@pytest.mark.xfail(raises=Exception)
def test_that_should_fail(): 
  method_that_throws_Exception()
```

抛出异常的测试：`with pytest.raises(Exceptioin)` 用来断言函数抛出了 `Exception`

```
def test_that_should_throw_exception():
  with pytest.raises(Exception):
    method_that_throws_Exception()
```


创建共享的 `mock` 对象，如这里的 `my_fixture`：

```
@pytest.fixture(scope="module")
def my_fixture(): 
  return SHARED_OBJECT_OR_VARIABLE
def test_that_uses_shared_mock_obj(my_fixture):
  assert manager.do_something(my_fixture, 'hello') == None
```

添加一个以 `Test` 开头的类，将多个测试用例放到该类里就行了。

```
# content of test_class.py
class TestClass:
    def test_one(self):
        x = "this"
        assert 'h' in x

    def test_two(self):
        x = "hello"
        assert hasattr(x, 'check')
```


### pytest.fixture

decorator `@pytest.fixture` 是一个类似于unittest框架里面 setup()/teardown()一套的东西，他里面还有个参数scope 默认情况下scope是function也就是每个函数执行的时候都会执行被这个decorator包裹的函数 具体参照 [pytest-fixture](http://pytest.org/latest/fixture.html#fixture) 这个文档讲的非常清楚

    @pytest.fixture
    def client(request):
        app.config['TESTING'] = True
        # 得到测试客户端
        client = app.test_client()
    
        def teardown():
            app.config['TESTING'] = False
        # 执行回收函数
        request.addfinalizer(teardown)
    
        return client
        
然后这里就是申明一个`fixture` 叫`client` 这个`client` 会帮我打开对应需要测试的`app.config['testing']＝True` 然后帮我得到测试客户端 也就是我的测试上下文。 然后返回这个测试上下文 最后将测试配置恢复原状。`request.addfinalizer` 在上面那个文档地址里面也有介绍到。大致做一个操作就是在操作函数执行结束之后 调用对应参数里面的函数进行收尾工作。

然后就是具体的`test_case`：

    class TestOrder:
        # 最外层请求头
        _data = {
            'api_key': api_key,
            'version': '1',
            'time': str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')),
        }
    
        def test_order_get_success(self, client):
            url = '/order/get'
            value = {
                'tid': '20160104-165157704',
                # 'tid': '12031823'
            }
            self._data['param'] = simplejson.dumps(value)
            self._data['api_sign'] = make_sign(self._data)
            rv = client.post(url, data=self._data)
            assert simplejson.loads(rv.data)['success'] == True, '请求订单失败' # noqa
            
要特别注意: 申明类也必须使用`Test`打头，不然`py.test`框架会找不到对应的测试对象，然后申明具体的test case 这里是test_order_get_success同理要使用`test`作为函数的开头，测试框架才能找到。然后这里传入`测试客户端 client`，*也就是我们前面得到的测试上下文对象*。 最后进行相应的操作就行了，然后调用断言操作对需要检查的项目进行检查。 返回的数据通通保存在 测试对象的.data里 也就是这里的rv.data。 这里只需要对rv.data里面返回值进行校验就可以达到单元测试的目的了。


## 参考

* [Python 测试框架: 用 Python 测试框架简化测试](https://www.ibm.com/developerworks/cn/aix/library/au-python_test/)
* [Python Unit Testing with Pytest and Mock](python_unit_testing_with_pytest_and_mock.md)
* [关于flask 上直接使用py.test测试框架进行测试](http://www.lai18.com/content/4983106.html)
* [pytest-fixture](http://senarukana.github.io/2015/05/29/pytest-fixture/)
* [pytest](http://doc.pytest.org/en/latest/contents.html)
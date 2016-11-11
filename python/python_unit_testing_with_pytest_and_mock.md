title: Python Unit Testing with Pytest and Mock
date: 2016-11-11 10:03:00
tags:
- python
- pytest
- mock


# Python Unit Testing with Pytest and Mock

由于 `medium.com` 需要翻墙，特此摘录：[Python Unit Testing with Pytest and Mock](https://medium.com/@bfortuner/python-unit-testing-with-pytest-and-mock-197499c4623c#.uo0ng0e6n)

	import mock 
	import pytest
	from pytest_mock import mocker 
	from src.jobitems import manager

Verify sub-method called with specific parameters:

	def test_update_jobs_fleet_capacity(mocker):
	  mocker.patch.object(manager, 'sub_method') 
	  manager.sub_method.return_value = 120 
	  manager.method_under_test()
	  manager.sub_method.assert_called_with('somestring', 1, 120)
	  
	  
Mock class in another module:

	  
	def test_helper_class(mocker):
	  mocker.patch.object(manager, 'other_class')
	  manager.other_class.other_method.return_value = 50
	  manager.method_under_test('option1')
	  manager.other_class.other_method.assert_called_with(120)
	  
Run test multiple times with array of params:
	  
	@pytest.mark.parametrize('test_type, var1, var2, expect', [
	  ('verify_max_returned', 'apple', 90, 100),
	  ('verify_min_returned', 'orange', 2, 10)
	])
	def test_get_size(mocker, test_type, var1, var2, expect):
	  print("Logging test type for visibility: " + test_type)
	  assert fleet_manager.get_optimal_size('zone1', var1, 
	    var2) == expect	  
	 
Verify method is called with any parameter (value doesn’t matter):

	manager.update_size(mock.ANY, 'var2', mock.ANY)	 

Override constant in config file:
 
	def test_update_config_val(monkeypatch): 
	  monkeypatch.setattr(config, 'WEBSITE_URL', 'mysite.com')
	  assert manager.method_that_uses_config_val() == 'mysite.com'	
	  
Override environment variable:

    def test_update_env_var(monkeypatch): 
      monkeypatch.setenv('DOMAIN', 'Devo')
      assert manager.method_that_uses_env_var() == 'Devo'	  
	  
	  
Verify unit test fails:
    
    @pytest.mark.xfail(raises=Exception)
    def test_that_should_fail(): 
      method_that_throws_Exception()
   
Verify test throws exception:

    def test_that_should_throw_exception():
      with pytest.raises(Exception):
        method_that_throws_Exception()	 
Skip test that fails intermittently:
    
    @pytest.mark.skipif(True, reason="Method is too slow")
    def test_very_slow_method():
      this_method_is_too_slow(19209938)        
           
           
Create shared Mock object for all tests in module:

    @pytest.fixture(scope="module")
    def my_fixture(): 
      return SHARED_OBJECT_OR_VARIABLE
    def test_that_uses_shared_mock_obj(my_fixture):
      assert manager.do_something(my_fixture, 'hello') == None
           
## 参考

* [Python Unit Testing with Pytest and Mock](https://medium.com/@bfortuner/python-unit-testing-with-pytest-and-mock-197499c4623c#.uo0ng0e6n)  
           
         
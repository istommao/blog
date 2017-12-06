# API Benchmard

* [ab](ab.md)
* [wrk](https://github.com/wg/wrk)
* [siege](https://github.com/JoeDog/siege)
* [api-benchmark](https://www.npmjs.com/package/api-benchmark)
* [locust](https://locust.io/)

## 实例

### ab

```
ab -c 1 -n 1 -T "multipart/form-data" -p ~/Downloads/pic/person.jpg http://www.example.com/
-c: 并发1
-n: 共一次请求
```

### wrk

```
./wrk -t10 -d1m -c100 http://www.excamaple.com/ --script post.lua

-t: 10个线程
-c: 共使用100个连接，即每个线程 100/10 个
-d: 持续时间1m (1s,1h等)

```

### siege

```
siege -b --concurrent=1 --content-type="application/x-www-form-urlencoded" 'http://www.example.com/ POST foo=bar' -t 10S

-b: Run a benchmark/stresstest
--concurrent=n: Simulate n concurrent users
-H: Several additional HTTP headers can be send by using -H (multiple times)
-t: For how long do you want to run siege
-r: 共运行几次，一般不和 -t 同时使用
-f: urls.txt 制定url的文件
```

```
siege -b --concurrent=10 --content-type="text/xml;charset=utf-8" -H "Soapaction: ''" 'http://localhost:18382/ POST < /tmp/xxx' -t 10S 
```



```
结果:
Transactions: 总共测试次数(HTTP responses below 500) 
Availability: 成功次数百分比
Elapsed time: 总共耗时多少秒
Data transferred: 总共数据传输
Response time: 等到响应耗时
Transaction rate: 平均每秒处理请求数
Throughput: 吞吐率
Concurrency: 最高并发
Successful transactions: 成功的请求数
Failed transactions: 失败的请求数
```



One has to look out for the destination URL syntax. It must be in **single quotes** and also contain the request method: `'URL[:port][URI] METHOD'`



### api-benchmark

```
var apiBenchmark = require('api-benchmark');
var fs = require('fs');

var service = {
    server1: "http://www.example.com/"
};

var routes = {
    trending: {
        method: 'post',
        route: 'api/v1/images',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        data: {
            url: 'http://www.example.com/1.png',
        }
    }
};

var options = {
    runMode: 'parallel',
    maxConcurrentRequests: 15,
    minSamples: 500,
    maxTime: 10000,
};

apiBenchmark.measure(service, routes, options, function(err, results) {
    apiBenchmark.getHtml(results, function(error, html) {
        fs.writeFileSync('benchmarks.html', html);
    });
});
```



### locust

```
from locust import HttpLocust, TaskSet, task

class TaskBebavior(TaskSet):

    @task(1)
    def post_img(self):
        self.client.post(
            "api/v1/images",
            data={
                'url': 'http://www.example.com/1.png',
            },
        )


class TestUser(HttpLocust):
    task_set = TaskBebavior

```

```
locust --no-web -c 100 -r 10  --host=http://www.excample.com --only-summary
locust --no-web -c 100 -r 10  --host=http://www.excample.com 
```







## 参考

* [ab docs](https://httpd.apache.org/docs/2.4/programs/ab.html)
* [HTTP POST benchmarking / stress-testing an API behind HAProxy with siege](https://www.claudiokuenzler.com/blog/725/http-post-benchmark-stress-test-api-haproxy-with-siege)
* [benchmark-your-rest-api-the-easy-way](http://www.abhishekshukla.com/javascript/benchmark-your-rest-api-the-easy-way/)
* [locust](https://locust.io/)





​	  
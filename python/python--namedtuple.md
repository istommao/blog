title: python--namedtuple
date: 2017-02-17 17:43:00
tags:
- python
- namedtuple

# python--nametupled

* [Writing Clean Python With Namedtuples](https://dbader.org/blog/writing-clean-python-with-namedtuples)

```
from collections import namedtuple
Car = namedtuple('Car' , 'color mileage')
Car = namedtuple('Car', ['color', 'mileage'])

my_car = Car('red', 3812.4)
my_car.color
my_car.mileage
color, mileage = my_car
print(*my_car)
my_car[0]
```

子类：

```
Car = namedtuple('Car', 'color mileage')
class MyCarWithMethods(Car):
    def hexcolor(self):
        if self.color == 'red':
           return '#ff0000'
        else:
            return '#000000'
       
c = MyCarWithMethods('red', 1234)
c.hexcolor()
```

Built-in Helper Methods：

* `_asdict()` helper. It returns the contents of a namedtuple as a dictionary. This is great for avoiding typos when generating JSON-output, for example:

```

>>> my_car._asdict()
>>> json.dumps(my_car._asdict())
```

* `_replace()`. It creates a (shallow) copy of a tuple and allows you to selectively replace some of its fields:

```
>>> my_car._replace(color='blue')
Car(color='blue', mileage=3812.4)
```

* `_make()`: create new instances of a namedtuple from a sequence or iterable

```
>>> Car._make(['red', 999])
Car(color='red', mileage=999)
```

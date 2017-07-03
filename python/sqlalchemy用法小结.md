title: sqlalchemy用法
date: 2017-01-12 21:40:00
tags:
- sqlalchemy

# sqlalchemy用法小结

* [SqlAlchemy个人学习笔记完整汇总](http://www.cnblogs.com/harrychinese/archive/2012/09/12/My_Own_Tutorial_For_SqlAlchemy.html)


```
# flask
db = SQLAlchemy()
@contextmanager
def auto_commit():
    try:
        yield
        db.session.commit()
    except Exception:
        db.session.rollback()
        raise

class Service(db.Model):
	STATUS = [
        ST_STARTING,
        ST_STOPPED,
        ST_RUNNING,
        ST_DELETED,
    ]
    
	id = db.Column('id', db.CHAR(8), primary_key=True)
	creator_id = db.Column('creator_id', db.Integer, nullable=False)
	is_visible = db.Column('is_visible', db.Boolean, default=1)
	status = db.Column(db.Enum(*STATUS), default= ST_STARTING)
	
# or sqlalchemy(SA)

# declarative_base
class Service(Base):
	# __tablename__ = 'service'
	# __bind_key__ = 'xxx'
	id = Column(Integer, primary_key=True)
	...
	
# Table
user = Table('user', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(16), nullable=False),
    Column('email_address', String(60)),
    Column('password', String(20), nullable=False)
)

	
```

```	
# flask
engine = db.get_engine(current_app, bind=BIND_KEY)
db.session.query(...)...
conn = engine.connect()

# SA
from sqlalchemy import create_engine
engine = create_engine('DB_URI')
DBSession = sessionmaker(bind=engine)

@contextmanager
def session_scope():
    """Provide a transactional scope around a series of operations."""
    session = DBSession()
    try:
        yield session
        session.commit()
    except:
        session.rollback()
        raise
    finally:
        session.close()
	
```

创建表:

```
# flask
db.init_app(app)
db.create_all(bind=None)

# SA    
Base.metadata.create_all(engine)
# 创建某个表：declarative_base
Service.__table__.drop(bind=engine, checkfirst=True)
# 创建某个表: Table
user.create(engine)
```

查询写法:

```	
# 不用session，使用 declarative
q = (
    Service.query
    .filter_by(creator_id=creator_id)
    .filter(Service.status != Service.ST_DELETED)
)
q = q.filter_by(is_visible=Service.VISIBLE)
q.all()

# 或者
q = (
    Service.query
    .filter_by(creator_id=creator_id)
    .filter(Service.status != Service.ST_DELETED)
    .with_entities(Serivce.id, Service.creator_id)
)

# 或者 session
# flask
q = (
    db.session.query(Service.creator_id, db.func.sum(Service.amount))
    .filter_by(is_visible=Service.VISIBLE)
    .group_by(Service.creator_id)
)
q = q.filter(cls.created_at >= start_time)

# SA
session = DBSession()
q = session.query(Service).filter_by(id=id).first()
q = session.query(Service.creator_id, func.count(Service.creator_id)).group_by(Service.creator_id)
q = session.query(User).with_entities(
        User.name, func.count(User.id)).group_by(User.name).all()


# 或者 使用 sql (拿到 conn 之后，就可以执行各种sql语句了，不单单是查询，其他各种 sql 语句都可以，（如 INSERT, UPDATE, INSERT IGNORE, INSERT ON DUPLICATE KEY UPDATE 等等)

## raw sql
sql = (
    'SELECT `id`, `creator_id` FROM `service` '
    'WHERE `is_visible`=1 AND `creator_id `="%s" ' % (creator_id,)
)
## 或者 SA 的 select, update 等
from sqlalchemy.sql.expression import select, update
sql = (
	select([Service.id, Service.creator_id])
	.where(Service.is_visible == 1)
)
sql = (
	select([Service])
	.where(Service.is_visible == 1)
)
res = conn.execute(sql)

## 或者用 session 的 execute

result = session.execute('INSERT INTO user (name) VALUES (:name)', {'name': 'xxx'})
session.commit()

```

插入:

```
# 使用 declarative
# flask
with auto_commit():
	service  = Service(
		creator_id='123',
		....
	)
	db.session.add(service)
	
# SA
with session_scope() as session:
	service  = Service(...)
	session.add(service)
```

```
多个：
# flask
db.session.add_all(services)
# SA
session.add_all(services)

# sql
rows = [('123', 1), ...]
sql = (
    'INSERT INTO `service` (id, creator_id) '
    ' VALUES (%s, %s) '
)

conn.excuete(sql, *rows)
```

	
更新:

```
# 使用 declarative
# flask
with auto_commit():
	service.status = Service.ST_DELTED
	db.session.add(service)
	
# SA
with session_scope() as session:
	service.status = Service.ST_DELTED
	session.add(service)
	
```

```
使用 update

# 使用session
# flask
db.session.query(Service).filter_by(id='2').update({"status": Service.ST_DELETED})
db.session.query(Service).filter_by(id='2').update({Service.status: Service.ST_DELETED})
# SA
session.query(Service).filter_by(id='2').update({"status": Service.ST_DELETED})
session.query(Service).filter_by(id='2').update({Service.status: Service.ST_DELETED})

# 使用 decalarative
Service.query.filter_by(id='2').update({"status": Service.ST_DELETED})

# 使用 session execute
result = session.execute('UPDATE user SET name=:name WHERE id=:id', {'name': 'xxx', 'id': 6})
session.commit()
    
...其他类似

```

```
# 使用到in_
# flask
with db.auto_commit():
    (
        db.session.query(Service)
        .filter_by(id=id)
        .filter(Service.creator_id.in_(['1', '2']))
        .update({"status": Service.ST_DELETED}, synchronize_session=False)
    )
```

join: <http://docs.sqlalchemy.org/en/latest/orm/query.html#sqlalchemy.orm.query.Query.join>

```

# 使用 session

q = (
    Session.query(User, Document, DocumentPermissions)
    .filter(User.email == Document.author)
    .filter(Document.name == DocumentPermissions.document)
    .filter(User.email == 'someemail').all()
)

# 使用 decalarative

q = (User.query)


```

索引: 

* <http://stackoverflow.com/questions/10059345/sqlalchemy-unique-across-multiple-columns>
* <http://stackoverflow.com/questions/6626810/multiple-columns-index-when-using-the-declarative-orm-extension-of-sqlalchemy>

```
# declarative:

class Service(...)
	...
	__table_args__ = (db.Index('uix_service_creator', 'service_id', 'customer_id', unique=True), )
	
Index('idx_name', Service.creator_id, unique=True)
	
# Table
Index('myindex', mytable.c.customer_id, mytable.c.location_code, unique=True)

```


## 其他

BigInt: 兼容不同数据库

```
from sqlalchemy import BigInteger
from sqlalchemy.dialects import sqlite
BigIntegerType = BigInteger()
BigIntegerType = BigIntegerType.with_variant(sqlite.INTEGER(), 'sqlite')

class A(db.Model):
	id = db.Column(BigIntegerType, primary_key=True, autoincrement=True)
	...
```

注入：

<http://bobby-tables.com/python>


时间格式：

	db.func.date_format('%Y-%m-%d', created_at) # only mysql
	db.func.strftime('%Y-%m-%d', created_at) # only sqllite
	db.func.date(create_at) # both mysql, sqlite
	query(extract('hour', timeStamp).label('h')).group_by('h')
	group_by(func.date_trunc('hour', date_col))
	
	
## 文章

* [SQLAlchemy 简单笔记](http://www.jianshu.com/p/e6bba189fcbd)	
#Python计算文件的MD5

<http://segmentfault.com/a/1190000002978881>

使用Python进行文件Hash计算必须要注意：

1. 文件打开方式一定要是二进制方式，既打开文件时使用b模式，否则Hash计算是基于文本的那将得到错误的文件Hash(网上看到有人说遇到Python的Hash计算错误在大多是由于这个原因造成的)。

2. 对于MD5如果需要16位(bytes)的值那么调用对象的digest()而hexdigest(）默认是32位(bytes)，同理Sha1的digest()和hexdigest()分别产生20位(bytes)和40位(bytes)的hash值

3. 大文件如果一次性读入计算，会占用大量内存，可以分块读取、分块计算，效果与一次读取计算相同。代码如下：

```

import hashlib
import base64

'''
sha1 file with filename (SHA1)
'''
def SHA1FileWithName(fineName, block_size=64 * 1024):
  with open(fineName, 'rb') as f:
    sha1 = hashlib.sha1()
    while True:
      data = f.read(block_size)
      if not data:
        break
      sha1.update(data)
    retsha1 = base64.b64encode(sha1.digest())
    return retsha1

'''
md5 file with filename (MD5)
'''
def MD5FileWithName(fineName, block_size=64 * 1024):
  with open(fineName, 'rb') as f:
    md5 = hashlib.md5()
    while True:
      data = f.read(block_size)
      if not data:
        break
      md5.update(data)
    retmd5 = base64.b64encode(md5.digest())
    return retmd5

```


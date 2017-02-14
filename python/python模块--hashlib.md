title: python模块--hashlib
date: 2017-02-14 15:52:00
tags:
- hashlib

# python模块--hashlib
===

## md5 和 sha1 加密

md5:

 	import hashlib
 	sign_str = 'a_sign_str'
 	if isinstance(sign_str, unicode):
        sign_str = sign_str.encode('utf-8')
    hash_md5 = hashlib.md5(sign_str)
    hash_md5.hexdigest()
    
sha1 与之类似。

如果处理大文件，可以使用 update 方法：

	_md5 = hashlib.md5()
	while True:
		sign_str = f.read(1024)
		_md5.update(data)
	return _md5.hexdigest()
	
		
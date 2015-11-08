#Python使用pickle读取和保存数据

只要是一个对象，通过pickle就可以把对象保存到文件，也可以从保存的文件读取出来，这样不需要使用数据库，就可以完成数据的记录。
	
	import pickle
	
	'''
	save to file
	'''
	def pickle_save(fileName, obj):
	    # try:
	        with open(fileName, 'wb') as f:
	            pickle.dump(obj, f)
	    # except IOError, e:
	    #     print e
	
	'''
	load from file
	'''
	def pickle_load(fileName):
	    # try:
	        with open(fileName, 'rb') as f:
	            obj = pickle.load(f)
	        return obj
	    # except IOError, e:
	    #     print e

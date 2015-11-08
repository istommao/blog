#Python获取目录下的所有文件

	
	'''
	get all files of the path
	'''
	def get_files(path):
	    if os.path.isfile(path):
	        return [path]
	    files = []
	    entries = os.listdir(path)
	    for entry in entries:
	        path1 = path + '/' + entry
	        if os.path.isdir(path1):
	            files += get_files(path1)
	        elif os.path.isfile(path1):
	            files.append(path1)
	        else:
	            pass
	    return files
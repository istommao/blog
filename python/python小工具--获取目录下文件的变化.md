#Python小工具--获取目录下文件的变化

将本地指定目录下的文件变化（增，删，改）记录下来，然后通过运行系统命令--scp，将变化的文件拷贝到服务器。

1. 首先读取本地目录的所有文件，并通过pickle模块将所有文件名保存到起来
2. 同时，计算每个文件的md5，并保存以{文件名:md5}构成字典保存起来
3. 之后，执行该脚本的时候，将本次执行时目录里的文件读取出来与原有保存起来的文件名进行比较，即可得知有哪些文件增加或删除，并将现在的文件名对步骤1保存的记录的进行更新
4. 接着，将本次执行时的目录文件的md5计算出来，与原有保存起来的md5进行比较，即可得出有哪些文件修改过了，并将本次的{文件名:md5}构成字典，对步骤2中保存的记录进行更新
5. 最后，根据步骤3，4得到的结果运行scp命令，拷贝到远端服务器

源码：

	#!/usr/bin/env python
	# -*- coding: utf-8 -*-
	
	__author__ = 'zhuwei'
	
	import os
	import sys
	
	import hashlib
	import base64
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
	
	
	'''
	sha1 file with filename (SHA1)
	'''
	def SHA1FileWithName(fileName, block_size=64 * 1024):
	    try:
	        with open(fileName, 'rb') as f:
	            sha1 = hashlib.sha1()
	            while True:
	                data = f.read(block_size)
	                if not data:
	                    break
	                sha1.update(data)
	            retsha1 = base64.b64encode(sha1.digest())
	            return retsha1
	    except IOError, e:
	        print e
	
	'''
	md5 file with filename (MD5)
	'''
	def MD5FileWithName(fileName, block_size=64 * 1024):
	    try:
	        with open(fileName, 'rb') as f:
	            md5 = hashlib.md5()
	            while True:
	                data = f.read(block_size)
	                if not data:
	                    break
	                md5.update(data)
	        retmd5 = base64.b64encode(md5.digest())
	        return retmd5
	    except IOError, e:
	        print e
	
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
	
	'''
	initial database
	'''
	def init_database(curr_path='./', md5_path='./files_md5.dat', files_path='./files_path.dat'):
	    print 'initial database'
	    file_md5_dict = {}
	    files = get_files(curr_path)
	    for f in files:
	        file_md5_dict[f] = MD5FileWithName(f)
	
	    pickle_save(md5_path, file_md5_dict)
	    pickle_save(files_path, set(files))
	
	def get_variation_files(curr_path, md5_path, files_path):
	    # first things to do is initialize database
	    try:
	        old_file_md5_dict = pickle_load(md5_path)
	        old_files_set = pickle_load(files_path)
	    except Exception, e:
	        print e
	        init_database(curr_path, md5_path, files_path)
	
	    # load database
	    old_file_md5_dict = pickle_load(md5_path)
	    old_files_set = pickle_load(files_path)
	
	    file_md5_dict = {}
	    mod_files = []
	    add_files = []
	    del_files = []
	
	    # calc the difference files between now and database
	    files = get_files(curr_path)
	    files_set = set(files)
	    add_files = list(files_set - old_files_set)
	    del_files = list(old_files_set - files_set)
	
	    # calc files md5
	    for f in files:
	        file_md5_dict[f] = MD5FileWithName(f)
	
	    #
	    for k in file_md5_dict:
	        if k in old_file_md5_dict:
	            if old_file_md5_dict[k] != file_md5_dict[k]:
	                mod_files.append(k)
	
	    # print mod, add, del files
	    # print "===mf===="
	    # for mf in mod_files:
	    #     print mf
	    # print "===af===="
	    # for af in add_files:
	    #     print af
	    # print "===df===="
	    # for df in del_files:
	    #     print df
	
	    # update database
	    pickle_save(md5_path, file_md5_dict)
	    pickle_save(files_path, set(files))
	    return mod_files, add_files, del_files
	
	def running_system_cmd(command):
	    # os.system(command)
	    return os.popen(command).read()
	
	def scp_to_server(mod_strs, del_strs, base_local_path, base_serv_path):
	    serv = 'root@192.168.1.11'
	    for str in mod_strs:
	        if str.find(base_local_path) != -1:
	            # change local base path to server local path
	            dst = str.replace(base_local_path, base_serv_path)
	
	            # build linux command to new unexisting files in case of
	            # scp command failed: No such file or directory
	            index = dst.rfind('/')
	            if index != -1:
	                dir1 = dst[0:index]
	                build_dir = 'ssh ' + serv + ' "[ -f ' + dst + ' ] && echo ok || mkdir -p ' + dir1 + '"'
	            else:
	                print 'incorrect path(/): ', str
	
	            print 'build_dir: ', build_dir
	            # running_system_cmd(build_dir)
	
	            # build scp command
	            scp_cmd = 'scp ' + str + ' ' + serv + ':' + dst
	            print 'scp_cmd: ', scp_cmd
	            # running_system_cmd(scp_cmd)
	
	        else:
	            print 'incorrect path: ', str
	
	    # del
	    for str in del_strs:
	        if str.find(base_local_path) != -1:
	            # change local base path to server local path
	            dst = str.replace(base_local_path, base_serv_path)
	            del_cmd = 'ssh ' + serv + ' '+ '"rm -f ' + dst + '"'
	            print 'del_cmd: ', del_cmd
	            running_system_cmd(del_cmd)
	        else:
	            print 'incorrect path: ', str
	
	if __name__ == '__main__':
	
	    if len(sys.argv) == 1:
	        path = "/Users/zhuwei/Source/dev/python"
	    elif len(sys.argv) == 2:
	        path = sys.argv[1]
	    else:
	        raise Exception("too many arguments")
	
	    if path[0] == '.':
	        raise Exception("path must be abs path")
	
	
	    md5_path = './files_md5.dat'
	    files_path = './files_path.dat'
	
	    mod_files, add_files, del_files = get_variation_files(curr_path=path, md5_path=md5_path, files_path=files_path)
	    # print mod, add, del files
	    print "===mf===="
	    for mf in mod_files:
	        print mf
	    print "===af===="
	    for af in add_files:
	        print af
	    print "===df===="
	    for df in del_files:
	        print df
	
	    base_local_path = '/Users/zhuwei/Source/dev/python'
	    base_serv_path = '/opt/python/'
	
	    scp_to_server(mod_strs=mod_files+add_files, del_strs=del_files, base_local_path=base_local_path, base_serv_path=base_serv_path)
	
	
	

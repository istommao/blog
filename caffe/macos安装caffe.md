title: macos安装caffe
date: 2017-05-05 11:40:00
tags:
- mac
- caffe


# macos安装caffe

* http://caffe.berkeleyvision.org/install_osx.html

```

brew tap homebrew/science
brew install -vd snappy leveldb gflags glog szip lmdb
brew install hdf5 opencv

```


```

# with Python pycaffe needs dependencies built from source
brew install --build-from-source --with-python -vd protobuf
brew install --build-from-source -vd boost boost-python
# without Python the usual installation suffices
# brew install protobuf boost
```

```

cd ~

git clone https://github.com/BVLC/caffe.git

cp Makefile.config.example Makefile.config

将 `CPU_ONLY := 1` 打开

make all -j4
make test
make runtest
```

p.s.: 编译过程可能会出现很多 `warning` 之类的，可以不用管
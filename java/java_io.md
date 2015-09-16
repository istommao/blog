#Java IO
===

所有输入流类都是抽象类InputStream(字节输入流)或抽象类Reader（字符输入流）的子类；而所有输出流都是抽象类OutputStream（字节输出流）或抽象类Writer（字符输出流）的子类。

##输入流

* read()
* read(byte[] b)
* mark(int readlimit)
* reset()
* skip(long n)
* markSupported()
* close()

###InputSteam类层次结构
InputStream <--  AudioInputStream, ByteArrayInputStream, StringBufferInputStream, FileInputStream, FilterInputStream, InputStream, ObjectInputStream, SequenceInputStream, PipedInputStream  <--  BufferedInputStream, DataInputStream, PushbackInputStream...

###Reader类层次
Reader <--  CharArrayReader, BufferedReader, FilterReader, InputStreamReader, PipedReader, StringReader  <-- LineNumberReader, PushbackReader, FileReader

##输出流

* write(int b)
* write(byte[] b)
* write(byte[] b, int off, int len)
* flush()
* close()

###Writer类层次
Writer <-- BufferedWriter, CharArrayWriter, FilterWriter, OutputStreamWriter, PipedWriter, PrintWriter, StringWriter  <-- FileWriter


##File类
文件类

###文件创建、删除
* File(String pathname)
* File(String parent, String child)
* File(File f, String child)

* delete()

###获取文件信息
* getName()
* canRead()
* canWrite()
* exits()
* length()
* getAbsolutePath()
* isFile()
* isDirectory()
* isHidden()
* lastModified()

###文件输入输出流FileInputStream, FileOutputStream

* FileInputStream(String name)
* FileInputStream(File file)

###FileReader和FileWriter类


###BufferedInputStream和BufferedOutputStream
带缓存的输入输出流。


###BuffredReader与BuffredWriter类

##数据输入/输出流

DataInputStream和DataOutputStream类

##ZIP压缩输入/输出流

ZipOutputStream与ZipInputStream类












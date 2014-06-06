#-*- coding:utf-8 -*-
import urllib
import socket
import sys
type = sys.getfilesystemencoding()

def reporthook(blocks_read,block_size,total_size):
    if not blocks_read:
    	s = "连接源成功，正在下载……"
        print s.decode('UTF-8').encode('GBK')
    if total_size <0:
        s = "读取 %d 块"  % blocks_read
        print s.decode('UTF-8').encode('GBK')
    else:
        download_read = blocks_read*block_size/1024.0
        download_total = total_size/1024.0
        s = "正在下载: %d KB / %d KB ( %d )" % (download_read,download_total,download_read/download_total*100)
        print s.decode('UTF-8').encode('GBK')

def downloadnow(url,file):
    s = ("正在连接源...")
    print s.decode('UTF-8').encode('GBK')
    socket.setdefaulttimeout(10)
    try:
        urllib.urlretrieve(url,file,reporthook)
    except:
        s = "连接失败"
        print s.decode('UTF-8').encode('GBK')

#if __name__ == '__main__':
#    print ("Ready")
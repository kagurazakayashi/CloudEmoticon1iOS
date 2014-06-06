#-*- coding:utf-8 -*-
import hashlib
import os
import download

def readData(url_string,isOnlyOnline):
    url_md5_o = hashlib.md5(url_string.encode('utf-8')).hexdigest()
    filename = url_md5_o + ".yashi"
    data = ""
    if isOnlyOnline == 0:
        if os.path.isfile(filename):
            data = readLocalData(filename)
        else:
            download.downloadnow(url_string,filename)
            data = readLocalData(filename)
    else:
        download.downloadnow(url_string,filename)
        data = readLocalData(filename)
    return data

def readLocalData(filename):
    data_o = ""
    file_object = open(filename)
    try:
        data_o = file_object.read()
    finally:
        file_object.close()
    return data_o

#if __name__ == '__main__':
#    readData("http://dl.dropboxusercontent.com/u/73985358/Emoji/_KT_Current.xml",0)
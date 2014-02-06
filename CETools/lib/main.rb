#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows

class Main
    def start
        puts "初始化..."
    end
end

if __FILE__ == $0
    begin
        puts "执行..."
        load 'welcome.rb'
        wel_class = Welcome.new
        wel_class.welinfo
        puts "*** END ***"
    rescue Exception => exception
        #NSLog ("error")
        puts ""
        puts "*" * 20
        puts "啊咧？程序已经傲娇或者被您强行推倒了？"
        puts "程序立即退出，如果这个提示中断了程序，请反馈错误报告。"
        open('errorlog_错误报告请到我的G+反馈.txt', 'w') { |f| f.write [exception.inspect, *exception.backtrace].join("\n") }
        puts "已经生成了一份错误报告在安装文件夹,文件名是："
        puts "errorlog_错误报告请到我的G+反馈.txt"
        puts "*" * 20
        puts ""
        exit
    end
end
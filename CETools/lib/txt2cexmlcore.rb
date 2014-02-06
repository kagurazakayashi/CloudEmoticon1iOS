#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows

class Txt2cexmlcore
    #attr_accessor : sname
    #attr_accessor : gname
    #attr_accessor : txtline

#def initialize(sname,gname,txtline)
#    @sname = sname
#    @gname = gname
#    @txtline = txtline
#end

def convert(sname,gname,txtline)
    xmlarr = Array.new
    puts ""
    puts "转换过程开始……"
    puts "创建基础结构(级别0)：<emoji>"
    xmlarr << "<emoji>"
    infoos = "<infoos>#{sname}</infoos>"
    puts "创建头信息(级别1)：#{infoos}"
    xmlarr << " " + infoos
    category = "<category name=\"#{gname}\" continuous=\"0\" split=\"1\">"
    puts "创建分组信息(级别1)：#{category}"
    xmlarr << " " + category
    txtline.each do |emoji|
        puts "创建条目块(级别2)：<entry>"
        xmlarr << " " * 2 + "<entry>"
        emostr = "<string>#{emoji.chomp}</string>"
        puts "创建颜文字(级别3):#{emostr}"
        xmlarr << " " * 3 + emostr
        puts "结束条目块(级别2)：</entry>"
        xmlarr << " " * 2 + "</entry>"
    end
    puts "结束分组信息(级别1)：</category>"
    xmlarr << " " + "</category>"
    puts "结束基础结构(级别0)：</emoji>"
    xmlarr << "</emoji>"
    puts "\n开始合成……"
    allstr = ""
    xmlarr.each do |nowstr|
        allstr = allstr + nowstr + "\n"
    end
    puts "合成完成，转换过程结束。"
    return allstr
end
    
end
#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows
require "rexml/document"
include REXML

class Xmltest
    
def xmltest
    logstr = ""
    xmltesttxt
    while TRUE
        input = gets.chomp
        if input == "" then
            break
        else
            isOK = true
            if File.exists?(input) then
            begin
                doc = Document.new(File.open(input))
                load 'cexml.rb'
                cexml_o = CExml.new
                logstr = cexml_o.cexml(doc)
            rescue
                isOK = false
                puts "解析失败：XML文件存在问题。"
            end
            else
                puts ""
                puts "读取失败：文件不存在。"
                inpinfo
            end
            if isOK then
                savefile(logstr)
            end
            if isOK then
                break
            end
        end
    end
end

def savefile(xmlstr)
    while TRUE
        puts ""
        puts "请输入要将日志文件保存到何处："
        puts "（例如C:\\wwwroot\\xmllog.txt）："
        puts "（不输入任何内容则返回主菜单）："
        save = gets.chomp
        if save == "" then
            puts ""
            inpinfo
            break
        else
            begin
                wFile = File.new(save, "w")
                wFile.write(xmlstr)
                wFile.close()
                puts "保存已经成功完成。"
                puts "按回车返回主菜单。"
                gets.chomp
                break
                rescue => err
                puts ""
                puts "保存失败了，目标可能没有权限写入。"
            end
        end
    end
end

def xmltesttxt
    system('clear')
    system('cls')
    puts ""
    puts "============================"
    puts "云颜文字实用工具"
    puts "云颜文字xml源文件测试工具"
    puts "============================"
    puts ""
    inpinfo
end

def inpinfo
    puts "请输入要打开的本地XML文件地址："
    puts "（例如C:\\wwwroot\\myce.xml）："
    puts "（不输入任何内容则返回主菜单）："
end

end
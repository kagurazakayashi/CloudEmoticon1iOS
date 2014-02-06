#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows

class Txt2Xml
    def txt2xmlmenu
        txtline = Array.new
        sname = ""
        gname = ""
        xmlstr = ""
        txt2xmlmenutxt
        while TRUE
            input = gets.chomp
            if input == "" then
                break
            else
                if File.exists?(input) then
                    File.open(input,"r") do |file|
                        while line = file.gets
                            puts "正在准备转换：#{line}"
                            newline = ""
                            rep = false
                            line.each_char() do |nowline|
                                if nowline == "<" then
                                    nowline = "&lt;"
                                    rep = true
                                end
                                newline += nowline
                            end
                            if rep then
                                puts "发现可能导致解析器问题的\"<\"，已修正为：#{newline}"
                            end
                            txtline << newline
                        end
                    end
                    if txtline.size.to_i > 0 then
                        isOK = true
                        puts ""
                        puts "请输入源名称（不输入任何内容则取消）："
                        sname = gets.chomp
                        if sname == "" then
                            isOK = false
                            puts ""
                            inpinfo
                        end
                        if isOK then
                            puts ""
                            puts "请输入分组名（不输入任何内容则取消）："
                            gname = gets.chomp
                            if gname == "" then
                                puts ""
                                inpinfo
                                break
                            else
                                load 'txt2cexmlcore.rb'
                                txt2cexmlcore = Txt2cexmlcore.new
                                xmlstr = txt2cexmlcore.convert(sname,gname,txtline)
                            end
                        end
                        if isOK then
                            savefile(xmlstr)
                        end
                        if isOK then
                            break
                        end
                    else
                        puts ""
                        puts "转换失败：文件空白或格式不正确。"
                        inpinfo
                    end
                else
                    puts ""
                    puts "转换失败：文件不存在。"
                    inpinfo
                end
            end
        end
    end
    
    def txt2xmlmenutxt
        system('clear')
        system('cls')
        puts ""
        puts "============================"
        puts "云颜文字实用工具"
        puts "txt文本文档转云颜文字源xml"
        puts "============================"
        puts ""
        puts "你可以创建一个txt文本文档，包含多个颜文字。"
        puts "每个颜文字一行，不支持多行的颜文字。"
        puts ""
        inpinfo
    end
    
    def savefile(xmlstr)
        while TRUE
            puts ""
            puts "请输入要将XML文件保存到何处："
            puts "（例如C:\\wwwroot\\myce.xml）："
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
                    puts "恭喜，转换程序已经成功完成。"
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
    
    def inpinfo
        puts "请输入待转换txt文件的完整路径："
        puts "（例如C:\\wwwroot\\myce.txt）："
        puts "（不输入任何内容则返回主菜单）："
    end
end
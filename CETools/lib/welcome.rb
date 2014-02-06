#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows

class Welcome
    def welinfo
        menutxt
        while TRUE
            input = gets.chomp
            #redo unless input=~/^[123]$/
            case input.to_i
                when 1
                #system('clear')
                load 'txt2cexml.rb'
                txt2cexml_o = Txt2Xml.new
                txt2cexml_o.txt2xmlmenu
                menutxt
                when 2
                #system('clear')
                load 'xmltest.rb'
                xmltest_o = Xmltest.new
                xmltest_o.xmltest
                menutxt
                when 9
                menutxt
                when 0
                system('clear')
                system('cls')
                puts "程序结束，有关更多详情欢迎前往："
                puts "http://www.heartunlock.com/soft/cloud_emoticon/"
                puts ""
                break
                else
                puts "选项错误，请重新输入序号数字，或输入9重新显示菜单："
            end
        end
    end
    def menutxt
        system('clear')
        system('cls')
        puts ""
        puts "=============================="
        puts "   欢迎使用云颜文字实用工具"
        puts "           v0.8"
        puts "       by 神楽坂雅詩"
        puts "     简体中文版 (UTF-8)"
        puts "=============================="
        puts ""
        puts "请输入数字序号选择："
        puts ""
        puts "1.txt文本文档转云颜文字源xml"
        puts ""
        puts "2.云颜文字xml源文件测试工具"
        puts ""
        puts "0.退出"
        puts ""
        puts "请输入选项："
        
    end
end
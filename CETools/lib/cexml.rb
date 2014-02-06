#!/usr/bin/env ruby
# coding: utf-8
#require "jcode" #仅限Windows
#$KCODE='utf8' #仅限Windows

require "rexml/document"
include REXML

class CExml

def cexml(doc)
    gi = 0-1
    ti = 0-1
    log = Array.new
    heng = "-" * 20
    system('clear')
    system('cls')
    puts "\n============================\n云颜文字实用工具\n云颜文字xml源文件测试工具\n============================\n\n"
    log << "============================\n云颜文字实用工具\n云颜文字xml源文件测试工具\nby 神楽坂雅詩\n============================\n\n"
    root = doc.root
    scname = ""
    isTwoInfo = true
    begin
        scname = root.elements[1].elements[1].text
    rescue
        isTwoInfo = false
        scname = root.elements[1].text #源名称
    end
    puts heng
    log << heng
    sinfo = "源名称：#{scname}"
    log << sinfo
    puts sinfo
    first = 0
    root.elements.each do |group|
        gname = group.attributes['name'] #组名称
        if gname != "" then
            puts ""
            log << ""
            puts heng
            log << heng
            gname_i = "分组：#{gname}\n有以下内容："
            gi += 1
            puts gname_i
            log << gname_i
            puts heng
            log << heng
        end
        
        if isTwoInfo == false then
            first = 3
        end
        group.elements.each do |item|
            if first < 3 then
                first += 1
            else
                sname = "无名称"
                if item.elements["note"] then
                    sname = item.elements["note"].text
                end
                sname_i = "\n颜文字名称：#{sname}"
                puts sname_i
                log << sname_i
                string = item.elements["string"].text
                string_i = "颜文字字形：#{string}"
                ti += 1
                puts string_i
                log << string_i
            end
        end
    end
    
    puts ""
    log << ""
    puts heng
    log << heng
    tt = "统计信息：\n源名称：#{scname}\n总计分组数：#{gi}\n总计颜文字数：#{ti}\nSCXML源验证成功。"
    puts tt
    log << tt
    puts "\n生成记录文件……"
    allstr = ""
    log.each do |nowstr|
        allstr = allstr + nowstr + "\n"
    end
    puts "生成记录文件完成，校验过程结束。"
    return allstr
    puts "\n要保存记录文件，请在下面输入.txt记录文件存储位置：\n（例如C:\\log\\xmllog.txt）：\n（不输入任何内容则返回主菜单）："
    #group = root.elements[3]
    #item = group.elements[1]
    #string = item.elements["string"]
    #puts string.text
    
end

end
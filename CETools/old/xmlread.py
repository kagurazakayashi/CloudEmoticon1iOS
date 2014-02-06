# -*- coding:utf-8 -*-
from  xml.dom import minidom

def get_attrvalue(node, attrname):
     return node.getAttribute(attrname) if node else ''

def get_nodevalue(node, index = 0):
    return node.childNodes[index].nodeValue if node else ''

def get_xmlnode(node,name):
    return node.getElementsByTagName(name) if node else []

def get_xml_data(filename):
    main_data_array_tmp = []
    doc = minidom.parse(filename) 
    root = doc.documentElement
    category = get_xmlnode(root,'category')
    for category_o in category:
        group_name = get_attrvalue(category_o,'name')
        #print (group_name)
        #group_name_array.append(group_name)
        entry = get_xmlnode(category_o,'entry')
        for entry_o in entry:
            string_node = get_xmlnode(entry_o,'string')
            seting = get_nodevalue(string_node[0]).encode('utf-8','ignore') #utf-8,gbk
            note_node = get_xmlnode(entry_o,'note')
            note = ""
            try:
                note_o = get_nodevalue(note_node[0]).encode('utf-8','ignore') #utf-8,gbk
            except:
                note = ""
            else:
                note = note_o
            item_array = [group_name,note,seting]
            main_data_array_tmp.append(item_array)
    return main_data_array_tmp

#if __name__ == "__main__":
#    get_xml_data()

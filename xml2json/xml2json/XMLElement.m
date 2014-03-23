//
//  XMLElement.m
//  xml2json
//
//  Created by 神楽坂雅詩 on 14-3-22.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "XMLElement.h"

@implementation XMLElement
@synthesize name,text,attributes,subElements,parent;

-(NSMutableArray *) subElements
{
    if(subElements == nil){
        subElements = [[NSMutableArray alloc]init];
    }
    return subElements;
}
@end

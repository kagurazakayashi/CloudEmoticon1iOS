//
//  PasteboardController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-2-23.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "PasteboardController.h"

@implementation PasteboardController
+ (void)whiteString:(NSString*)str
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:str];
}
+ (NSString*)readString
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    return pasteboard.string;
}
+ (void)whiteArray:(NSArray*)arr
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //NSString *str = [arr componentsJoinedByString:@"<!#ceitem#!>"];
    if ([NSJSONSerialization isValidJSONObject:arr]) {
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
        [pasteboard setString:str];
    }
}
+ (NSArray*)readArray
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //NSArray *arr = [pasteboard.string componentsSeparatedByString:@"<!#ceitem#!>"];
    NSData *jsonData = [pasteboard.string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    return arr;
}
@end
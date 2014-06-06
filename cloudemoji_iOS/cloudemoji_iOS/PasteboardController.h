//
//  PasteboardController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-2-23.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasteboardController : NSObject
+ (void)whiteString:(NSString*)str;
+ (NSString*)readString;
+ (void)whiteArray:(NSArray*)arr;
+ (NSArray*)readArray;
@end
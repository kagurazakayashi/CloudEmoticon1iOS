//
//  S.h
//  cloudemoji_iOS
//
//  Created by 王 燚 on 14-1-5.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S : NSObject
{
    NSMutableArray *allinfo;
}

+ (S*)s;

+ (float)txtHeightWithText:(NSString*)text MaxWidth:(float)width;

@property (nonatomic, retain) NSMutableArray *allinfo;

@end

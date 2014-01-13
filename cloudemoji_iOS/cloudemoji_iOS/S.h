//
//  S.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-5.
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
@property (nonatomic, assign) BOOL isupdateData;
@property (nonatomic, assign) float ios;
@property (nonatomic, assign) CGSize correct;
@end

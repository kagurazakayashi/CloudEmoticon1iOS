//
//  S.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-5.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ColorConvert.h"
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
@property (nonatomic, assign) int ad;
@property (nonatomic, assign) BOOL networkBusy;
//@property (nonatomic, retain) ColorConvert *colorconvert;
@end

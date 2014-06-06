//
//  ColorConvert.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-28.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorConvert : NSObject
- (UIColor *)colorWithHexString:(NSString *)stringToConvert;
- (NSString*)changeUIColorToRGB:(UIColor*)color;
- (NSString *)ToHex:(int)tmpid;
@end

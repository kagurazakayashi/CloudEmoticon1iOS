//
//  ColorConvert.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-28.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "ColorConvert.h"

@implementation ColorConvert
- (UIColor *)colorWithHexString:(NSString *) stringToConvert {
//    NSLog(@"颜色输入：%@",stringToConvert);
//    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    NSLog(@"cString=%@",cString);
//    if ([cString length] < 6)
//        return [UIColor whiteColor];
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//        return [UIColor whiteColor];
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    NSArray *array = [stringToConvert componentsSeparatedByString:@","];
    float r = [[array objectAtIndex:0] floatValue];
    float g = [[array objectAtIndex:1] floatValue];
    float b = [[array objectAtIndex:2] floatValue];
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (NSString*)changeUIColorToRGB:(UIColor*)colory {
//    const CGFloat *cs=CGColorGetComponents(color.CGColor);
//    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
//    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
//    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
//    NSString *s16 = [NSString stringWithFormat:@"#%@%@%@",r,g,b];
//    NSLog(@"颜色输出：%@",s16);
//    return s16;
    CGFloat R = 0, G = 0, B = 0;
    
    CGColorRef color = [colory CGColor];
    int numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
    }
    NSString *rgb = [NSString stringWithFormat:@"%F,%F,%F",R,G,B];
    NSLog(@"颜色输出：%@",rgb);
    return rgb;
}

-(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

@end

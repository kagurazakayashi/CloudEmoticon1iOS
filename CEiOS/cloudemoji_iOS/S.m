//
//  S.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-5.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "S.h"

@implementation S
@synthesize allinfo = _allinfo;
+ (S*)s
{
    static S *s;
    @synchronized(self)
    {
        if (!s) {
            //s.colorconvert = [[ColorConvert alloc] init];
            s = [[S alloc] init];
            s.allinfo = [[NSMutableArray alloc] init];
            s.networkBusy = NO;
            s.storeBusy = NO;
            //s.impURL = nil;
            s.ios = [[[UIDevice currentDevice] systemVersion] floatValue];
            s.correct = CGSizeMake(64, 48);
            if (s.ios < 7.0) {
                s.correct = CGSizeMake(0, 0);
            }
        }
        return s;
    }
}

+ (float)txtHeightWithText:(NSString*)text MaxWidth:(float)width
{
    if ([S s].ios >= 7.0)
    {
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.text = text;
        textView.numberOfLines = 0;
        textView.lineBreakMode = NSLineBreakByCharWrapping;
        CGRect txtFrame = textView.frame;
        return [[NSString stringWithFormat:@"%@\n",textView.text] boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:textView.font,NSFontAttributeName, nil] context:nil].size.height;
        /*
         NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
         textView.attributedText = attrStr;
         NSRange range = NSMakeRange(0, attrStr.length);
         NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
         // 计算文本的大小
         CGSize textSize = [textView.text boundingRectWithSize:textView.bounds.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
         return textSize.height;
         */
    } else {
        CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        return sizeToFit.height;
    }
    return 0;
}
+ (float)txtWidthWithText:(NSString*)text MaxHeight:(float)height
{
    if ([S s].ios >= 7.0)
    {
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, height)];
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.text = text;
        textView.numberOfLines = 0;
        textView.lineBreakMode = NSLineBreakByCharWrapping;
        CGRect txtFrame = textView.frame;
        return [[NSString stringWithFormat:@"%@\n",textView.text] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, txtFrame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:textView.font,NSFontAttributeName, nil] context:nil].size.width;
    } else {
        CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByCharWrapping];
        return sizeToFit.width;
    }
    return 0;
}
+ (void)scoreInfo:(NSDictionary*)dataDic
{
    NSDictionary *emoji = [dataDic objectForKey:@"emoji"];
    NSDictionary *infoos = [emoji objectForKey:@"infoos"];
    NSArray *infoosKeys = [infoos allKeys];
    NSMutableString *cName = [[NSMutableString alloc] init];
    BOOL isOne = NO;
    for (NSString *minfokey in infoosKeys) {
        if ([minfokey isEqualToString:@"info"]) {
            isOne = YES;
            break;
        }
    }
    if (isOne) {
        NSArray *kinfo = [infoos objectForKey:@"info"];
        NSMutableString *kinfoarr = [NSMutableString string];
        for (int i = 0; i < [kinfo count]; i++) {
            NSDictionary *textarr = [kinfo objectAtIndex:i];
            NSString *nowinfo = [textarr objectForKey:@"text"];
            if (i == 0) {
                [cName setString:nowinfo];
            } else {
                [kinfoarr setString:[NSString stringWithFormat:@"%@%@\n",kinfoarr,nowinfo]];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cName message:kinfoarr delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}
+ (BOOL)viewIsPortrait:(CGRect)viewFrame
{
    if (viewFrame.size.height > viewFrame.size.width) {
        return YES;
    } else {
        return NO;
    }
}
+ (int)orientationMode
{
    //宣告一個UIDevice指標，並取得目前Device的狀況
    UIDevice *device = [UIDevice currentDevice] ;
    //取得當前Device的方向，來當作判斷敘述。（Device的方向型態為Integer）
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            return 0; //NSLog(@"螢幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            return 0; //NSLog(@"螢幕朝下平躺");
            break;
            //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
            return 0; //NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            return 2; //NSLog(@"螢幕向左橫置");
            break;
        case UIDeviceOrientationLandscapeRight:
            return 2; //NSLog(@"螢幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            return 1; //NSLog(@"螢幕直立");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return 1; //NSLog(@"螢幕直立，上下顛倒");
            break;
        default:
            return 0; //NSLog(@"無法辨識");
            break;
    }
    // Return YES for supported orientations
    return 0; //(interfaceOrientation == UIInterfaceOrientationLandscapeLeft); // 只支持向左横向, YES 表示支持所有方向
}

//+ (void)sentR:(UIDeviceOrientation)rMode
//{
//    
//}
//+ (BOOL)isLandscapeWithFrame:(CGRect)frame
//{
//    float w = frame.size.width;
//    float h = frame.size.height;
//    if (w > h) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//+ (CGRect)xyWithFrame:(CGRect)frame
//{
//    return CGRectMake(frame.origin.x, frame.origin.y, frame.size.height, frame.size.width);
//}

//iOS7标题栏高度64
//iOS6-7工具栏高度49
//iOS6标题栏高度31

//iOS6横屏上补Tab-31
//iOS6横屏下补Tab+94
//iOS6竖屏下补View+94
//iOS6竖屏下补Tab+49
//+ (CGRect)tableFrame:(CGRect)viewFrame;
//{
//    int orientationMode=[S orientationMode];
//}
//+ (CGRect)viewFrame:(CGRect)oldFrame;
//{
//    
//}
@end

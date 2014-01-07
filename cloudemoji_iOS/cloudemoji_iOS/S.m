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
            s = [[S alloc] init];
            s.allinfo = [[NSMutableArray alloc] init];
            s.ios = [[[UIDevice currentDevice] systemVersion] floatValue];
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
@end

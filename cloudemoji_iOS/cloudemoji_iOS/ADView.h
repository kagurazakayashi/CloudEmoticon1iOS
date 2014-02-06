//
//  ADView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "GADBannerView.h"

@interface ADView : UIView <GADBannerViewDelegate>
{
    GADBannerView *bannerView_;
    UILabel *adinfo;
    CGRect showFrame;
    CGRect hideFrame;
}
- (id)initWithViewController:(UIViewController*)rootViewController ShowNow:(BOOL)shownow FixHeight:(BOOL)fix;
@end

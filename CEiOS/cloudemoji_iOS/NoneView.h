//
//  NoneView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-24.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneView : UIView
@property (nonatomic, retain) UILabel *logoLabel;
@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic, retain) UIView *bg;
@property (nonatomic, retain) NSString *info;
- (void)hide:(NSUInteger)dataCount;
@end

//
//  AnimationPauseVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADView.h"
@interface AnimationPauseVC : UIViewController
@property (nonatomic, retain) UIImageView *imgUp;
@property (nonatomic, retain) UIImageView *imgDown;
@property (nonatomic, retain) NSString *nowName;
@property (nonatomic, retain) NSString *nowString;
- (void)addAnimations;
@end
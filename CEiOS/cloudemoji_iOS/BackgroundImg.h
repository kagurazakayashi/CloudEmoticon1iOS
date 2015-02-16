//
//  BackgroundImg.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundImg : UIView
//@property (nonatomic, retain) UIView *bg;
@property (nonatomic, retain) UIImageView *img;
@property (nonatomic, assign) BOOL mode;

- (void)changeFrame:(CGRect)newframe;
- (void)changeImage:(UIImage*)i;

- (void)loadSetting:(NSInteger)imgID;
- (void)saveSetting:(NSInteger)imgID;

- (void)loadSettingImg:(NSInteger)imgID;
- (void)saveSettingImg:(NSInteger)imgID;


@end

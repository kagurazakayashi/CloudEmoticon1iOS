//
//  DIYViewController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundImg.h"
@protocol DIYViewDelegate <NSObject>
- (void)openPicID:(int)imgID;
@end
@interface DIYViewController : UIViewController<UIAlertViewDelegate>
@property (nonatomic,assign) id<DIYViewDelegate> delegate;
@property (nonatomic, retain) BackgroundImg *imgA;
@property (nonatomic, retain) BackgroundImg *imgB;
@property (nonatomic, assign) int mode;
@property (nonatomic, assign) int alertmode;
@property (nonatomic, retain) NSArray *zName;
@property (nonatomic, retain) UIButton *zoom1;
@property (nonatomic, retain) UIButton *zoom2;
- (void)selectPic:(UIImage*)image;
@end

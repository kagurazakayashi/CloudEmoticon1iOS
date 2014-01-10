//
//  MainViewController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibrary.h"
#import "Library.h"

@interface MainViewController : UIViewController <UITabBarControllerDelegate,OnlineLibraryMDelegate,LibraryMDelegate>
@property (nonatomic, retain) UITabBarController *tab;
@property (nonatomic, assign) float size7title;
@property (nonatomic, assign) float size7toolbar;
//@property (nonatomic, retain) UIView *hudView;
@end

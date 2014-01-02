//
//  MainViewController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryTVC.h"
#import "LibraryTVC.h"

@interface MainViewController : UIViewController <UITabBarControllerDelegate,OnlineLibraryDelegate,LibraryDelegate>
@property (nonatomic, retain) UITabBarController *tab;
@end

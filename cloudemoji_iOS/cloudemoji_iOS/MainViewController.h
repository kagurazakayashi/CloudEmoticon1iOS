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
#import "RefreshView.h"

#import "History.h"
#import "Favorites.h"
#import "Custom.h"
#import "Setting.h"
#import "AboutViewController.h"
#import "About.h"
#import "Search.h"
#import "Diy.h"
#import "AnimationPause.h"
#import "Game.h"
//#import "BlackView.h"
@interface MainViewController : UIViewController <UITabBarControllerDelegate,OnlineLibraryMDelegate,LibraryMDelegate,RefreshViewDelegate>
@property (nonatomic, retain) UITabBarController *tab;
@property (nonatomic, assign) float size7title;
@property (nonatomic, assign) float size7toolbar;
//@property (nonatomic, retain) UIView *hudView;
@property (nonatomic, retain) UILabel *sharename;
@property (nonatomic, retain) UIView *black;

@property (nonatomic, retain) OnlineLibrary *ol;
@property (nonatomic, retain) Favorites *f;
@property (nonatomic, retain) History *h;
@property (nonatomic, retain) Custom *c;
@property (nonatomic, retain) Search *s;
@property (nonatomic, retain) SettingViewController *setView;
@property (nonatomic, retain) Diy *diy;
@property (nonatomic, retain) Library *lib;
@property (nonatomic, retain) AboutViewController *about;
@property (nonatomic, retain) About *xabout;
@property (nonatomic, retain) AnimationPause *yao;
@property (nonatomic, retain) Game *g;
@property (nonatomic, assign) BOOL firstRun;

@property (nonatomic, assign) BOOL firstRun;

@end
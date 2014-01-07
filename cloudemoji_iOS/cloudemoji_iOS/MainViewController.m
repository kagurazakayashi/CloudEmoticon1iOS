//
//  MainViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "MainViewController.h"
#import "RefreshView.h"
#import "HistoryTVC.h"
#import "FavoritesTVC.h"
#import "CustomTVC.h"
//#import "IASKAppSettingsViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"
#import "XAboutViewController.h"
#import "SearchTVC.h"
#import "RefreshView.h"
#import "DIYViewController.h"
#import "ProgressHUD.h"
#import "S.h"
#import "AnimationPauseViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tab, size7title, size7toolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
    //NSLog(@"数据文件夹：%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
//    self.tabBarController.tabBar.translucent = NO;
    [self didInit];
    OnlineLibraryTVC *ol = [[OnlineLibraryTVC alloc] init];
    ol.title = NSLocalizedString(@"SoftwareName", nil);
    UINavigationController *oln = [[UINavigationController alloc] initWithRootViewController:ol];
//    oln.navigationBar.translucent = NO;
    //UITabBarItem *olI = [[UITabBarItem alloc] initWithTitle:ol.title image:[UIImage imageNamed:@"pcould.png"] selectedImage:[UIImage imageNamed:@"pcould2.png"]];
    UITabBarItem *olI = [[UITabBarItem alloc] initWithTitle:ol.title image:[UIImage imageNamed:@"pcould.png"] tag:0];
    ol.delegate = self;
    ol.tabBarItem = olI;
    FavoritesTVC *f = [[FavoritesTVC alloc] init];
    f.title = NSLocalizedString(@"Favorites", nil);
    UINavigationController *fn = [[UINavigationController alloc] initWithRootViewController:f];
    UITabBarItem *fI = [[UITabBarItem alloc] initWithTitle:f.title image:[UIImage imageNamed:@"pbook.png"] tag:0];
    f.tabBarItem = fI;
    HistoryTVC *h = [[HistoryTVC alloc] init];
    h.title = NSLocalizedString(@"History", nil);
    UINavigationController *hn = [[UINavigationController alloc] initWithRootViewController:h];
    UITabBarItem *hI = [[UITabBarItem alloc] initWithTitle:h.title image:[UIImage imageNamed:@"pclock.png"] tag:0];
    h.tabBarItem = hI;
    CustomTVC *c = [[CustomTVC alloc] init];
    c.title = NSLocalizedString(@"Custom", nil);
    UINavigationController *cn = [[UINavigationController alloc] initWithRootViewController:c];
    UITabBarItem *cI = [[UITabBarItem alloc] initWithTitle:c.title image:[UIImage imageNamed:@"pwri.png"] tag:0];
    c.tabBarItem = cI;
    SearchTVC *s = [[SearchTVC alloc] init];
    s.title = NSLocalizedString(@"Search", nil);
    UINavigationController *sn = [[UINavigationController alloc] initWithRootViewController:s];
    UITabBarItem *sI = [[UITabBarItem alloc] initWithTitle:s.title image:[UIImage imageNamed:@"psearch.png"] tag:0];
    s.tabBarItem = sI;
    SettingViewController *setView = [[SettingViewController alloc] init];
//    IASKAppSettingsViewController *setView = [[IASKAppSettingsViewController alloc] init];
//    setView.showCreditsFooter = NO;
//    setView.showDoneButton = NO;
    setView.title = NSLocalizedString(@"Setup", nil);
    UINavigationController *setn = [[UINavigationController alloc] initWithRootViewController:setView];
    UITabBarItem *setViewI = [[UITabBarItem alloc] initWithTitle:setView.title image:[UIImage imageNamed:@"psetting2.png"] tag:0];
    setView.tabBarItem = setViewI;
    DIYViewController *diy = [[DIYViewController alloc] init];
    diy.title = NSLocalizedString(@"Individuation", nil);
    UINavigationController *diyn = [[UINavigationController alloc] initWithRootViewController:diy];
    UITabBarItem *diyi = [[UITabBarItem alloc] initWithTitle:diy.title image:[UIImage imageNamed:@"psetting.png"] tag:0];
    diy.tabBarItem = diyi;
    LibraryTVC *lib = [[LibraryTVC alloc] init];
    lib.title = NSLocalizedString(@"SourceManagement", nil);
    UINavigationController *libn = [[UINavigationController alloc] initWithRootViewController:lib];
    UITabBarItem *libI = [[UITabBarItem alloc] initWithTitle:lib.title image:[UIImage imageNamed:@"pweb.png"] tag:0];
    lib.delegate = self;
    lib.tabBarItem = libI;
    AboutViewController *about = [[AboutViewController alloc] init];
    about.title = NSLocalizedString(@"UpdatesAndOnlineInformation", nil);
    UINavigationController *aboutn = [[UINavigationController alloc] initWithRootViewController:about];
    UITabBarItem *aboutI = [[UITabBarItem alloc] initWithTitle:about.title image:[UIImage imageNamed:@"info2.png"] tag:0];
    about.tabBarItem = aboutI;
    XAboutViewController *xabout = [[XAboutViewController alloc] init];
    xabout.title = NSLocalizedString(@"About", nil);
    UINavigationController *xaboutn = [[UINavigationController alloc] initWithRootViewController:xabout];
    UITabBarItem *xaboutI = [[UITabBarItem alloc] initWithTitle:xabout.title image:[UIImage imageNamed:@"pinfo.png"] tag:0];
    xabout.tabBarItem = xaboutI;
    AnimationPauseViewController *yao = [[AnimationPauseViewController alloc] init];
    yao.title = NSLocalizedString(@"Shake", nil);
    UINavigationController *yaon = [[UINavigationController alloc] initWithRootViewController:yao];
    UITabBarItem *yaoI = [[UITabBarItem alloc] initWithTitle:yao.title image:[UIImage imageNamed:@"psun.png"] tag:0];
    yao.tabBarItem = yaoI;
    about.tabBarItem = aboutI;
    self.tab = [[UITabBarController alloc] init];
    self.tab.delegate = self;
//    self.tab.tabBar.translucent = NO;
    self.tab.viewControllers = [NSArray arrayWithObjects:oln,fn,hn,cn,sn,libn,yaon,setn,diyn,aboutn,xaboutn, nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alt:) name:@"alt" object:nil];
    
    [self.view addSubview:self.tab.view];
}
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    float rfY = 0;
    if ([S s].ios < 7.0) {
        rfY = 20.0;
    }
    RefreshView *rf = [[RefreshView alloc] initWithFrame:CGRectMake(0, rfY, self.view.frame.size.width, self.view.frame.size.height)];
    
    rf.alpha = 0;
    [self.view addSubview:rf];
    [UIView animateWithDuration:0.3 animations:^{
        rf.alpha = 1;
    } completion:^(BOOL finished) {
        [rf startreload:URL ModeTag:mtag Local:local];
    }];
}
- (void)didInit
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    //自动更新源
    NSDate *nowDate = [NSDate date];
    [self registerDefaultsFromSettingsBundle];
    if(![setting boolForKey:@"firstStart"]){
        //NSLog(@"第一次启动");
        [setting setBool:YES forKey:@"firstStart"];
        [setting setObject:nowDate forKey:@"oldData"];
//        [setting setObject:nowDate forKey:@"oldApp"];
        NSString *nowURL = @"http://dl.dropboxusercontent.com/u/73985358/Emoji/_KT_Current.xml";
        [setting setObject:nowURL forKey:@"nowURL"];
        
        [setting setObject:[NSMutableArray array] forKey:@"fav"];
        [setting setObject:[NSMutableArray array] forKey:@"his"];
        [setting setObject:[NSMutableArray array] forKey:@"diy"];
        [self defaultImageFile];
    }else{
        NSDate *oldData = [setting objectForKey:@"oldData"];
//        NSDate *oldApp = [setting objectForKey:@"oldApp"];
        float oldDataI = [oldData timeIntervalSinceNow];
//        float oldAppI = [oldApp timeIntervalSinceNow];
        float dataI = [(NSNumber*)[setting objectForKey:@"dataupdatemode"] floatValue];
//        float appI = [(NSNumber*)[setting objectForKey:@"dataupdatemode"] floatValue];
        //NSLog(@"上次更新数据%g/%g，上次更新程序%g/%g。",oldDataI,dataI,oldAppI,appI);
        if ((oldDataI*(-1)) >= dataI) {
            //更新数据
            [S s].isupdateData = YES;
            [setting setObject:nowDate forKey:@"oldData"];
        } else {
            [S s].isupdateData = NO;
        }
//        if ((oldAppI*(-1)) >= appI) {
//            //更新APP
//            
//            [setting setObject:nowDate forKey:@"oldApp"];
//        }
    }
    [setting synchronize];
}
- (void)alt:(NSNotification*)notification
{
    [ProgressHUD shared];
    NSArray *info = [notification object];
    NSNumber *num = [info objectAtIndex:0];
    NSString *str = [info objectAtIndex:1];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:str];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *sh = [NSMutableArray arrayWithArray:[S s].allinfo];
    NSArray *hisData = [setting objectForKey:@"diy"];
    [sh addObjectsFromArray:hisData];
    for (NSArray *nowArr in sh) {
        NSString *nowStr = [nowArr objectAtIndex:2];
        if ([nowStr isEqualToString:str]) {
            NSMutableArray *his = [setting mutableArrayValueForKey:@"his"];
            for (int i = 0; i < [his count]; i++) {
                NSArray *nowArr2 = [his objectAtIndex:i];
                NSString *str1 = [nowArr objectAtIndex:2];
                NSString *str2 = [nowArr2 objectAtIndex:2];
                if ([str1 isEqualToString:str2]) {
                    [his removeObjectAtIndex:i];
                }
            }
            [his addObject:nowArr];
            [setting setObject:his forKey:@"his"];
            [setting synchronize];
            break;
        }
    }
    
    int mode = [num intValue];
    [MobClick event:@"copy"];
    if (mode == 0) {
        [ProgressHUD show:NSLocalizedString(@"Clipboard", nil)];
    } else if (mode == 1) {
        [ProgressHUD showSuccess:NSLocalizedString(@"Clipboard", nil)];
    } else if (mode == 2) {
        [ProgressHUD showError:NSLocalizedString(@"Clipboard", nil)];
    }
    
    BOOL iexit = [[setting objectForKey:@"copyclose"] boolValue];
    if (iexit) {
        [self exit];
    }
}

- (void)exit
{
    self.view.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:1 animations:^{
        self.tab.view.alpha = 0;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        BOOL nov = [[setting objectForKey:@"nov"] boolValue];
        if (nov) {
            UILocalNotification *newNotification = [[UILocalNotification alloc] init];
            if (newNotification) {
                newNotification.timeZone=[NSTimeZone defaultTimeZone];
                newNotification.fireDate=[[NSDate date] dateByAddingTimeInterval:1];
                newNotification.alertBody = NSLocalizedString(@"Notification", nil);
                newNotification.applicationIconBadgeNumber = 0;
                [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
            }
        }
        [MobClick event:@"exit"];
        exit(0);
    }];
}

- (void)defaultImageFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *f0 = [[NSBundle mainBundle] pathForResource:@"psz0" ofType:@"jpg"];
    NSString *f1 = [[NSBundle mainBundle] pathForResource:@"psz1" ofType:@"jpg"];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *t0 = [NSString stringWithFormat:@"%@/bg0.cxc",documentDirectory];
    NSString *t1 = [NSString stringWithFormat:@"%@/bg1.cxc",documentDirectory];
    if (![fileManager fileExistsAtPath:t0]) {
        [fileManager copyItemAtPath:f0 toPath:t0 error:nil];
    }
    if (![fileManager fileExistsAtPath:t1]) {
        [fileManager copyItemAtPath:f1 toPath:t1 error:nil];
    }
}

- (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIImageView *cc = [[UIImageView alloc] init];
    cc.contentMode = UIViewContentModeBottom;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"r" object:nil];
    
//    if(fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        NSLog(@"左右");
//    }
//    if (self.interfaceOrientation == UIDeviceOrientationPortrait){
//        NSLog(@"竖直");
//    }
//    else if(self.interfaceOrientation == UIDeviceOrientationLandscapeLeft)
//    {
//        NSLog(@"水平向左");
//    }
//    else if(self.interfaceOrientation == UIDeviceOrientationLandscapeLeft)
//    {
//        NSLog(@"水平向左");
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

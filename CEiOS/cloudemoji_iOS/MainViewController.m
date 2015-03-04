//
//  MainViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "MainViewController.h"
#import "RefreshView.h"
//#import "IASKAppSettingsViewController.h"
#import "Toast+UIView.h"
//#import "UMSocial.h"
//#import "ShareView.h"
//#import "AppAD.h"
#import "PasteboardController.h"

//#import "ColorConvert.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tab, size7title, size7toolbar, sharename, black;
@synthesize ol,f,h,c,s,setView,diy,lib,about,xabout,yao;//,g;
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
    self.firstRun = YES;
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    if (screenFrame.size.height > screenFrame.size.width) {
        [S s].screenSize = screenFrame.size;
    } else {
        [S s].screenSize = CGSizeMake(screenFrame.size.height, screenFrame.size.width);
    }

    
//    [self sentR:self.interfaceOrientation];
    

    //NSLog(@"数据文件夹：%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
//    self.tabBarController.tabBar.translucent = NO;
    [self didInit];
    ol = [[OnlineLibrary alloc] init];
    ol.title = NSLocalizedString(@"SoftwareName", nil);
    UINavigationController *oln = [[UINavigationController alloc] initWithRootViewController:ol];
//    oln.navigationBar.translucent = NO;
    //UITabBarItem *olI = [[UITabBarItem alloc] initWithTitle:ol.title image:[UIImage imageNamed:@"pcould.png"] selectedImage:[UIImage imageNamed:@"pcould2.png"]];
    UITabBarItem *olI = [[UITabBarItem alloc] initWithTitle:ol.title image:[UIImage imageNamed:@"pcould.png"] tag:0];
    ol.delegate = self;
    ol.tabBarItem = olI;
    f = [[Favorites alloc] init];
    f.title = NSLocalizedString(@"Favorites", nil);
    UINavigationController *fn = [[UINavigationController alloc] initWithRootViewController:f];
    UITabBarItem *fI = [[UITabBarItem alloc] initWithTitle:f.title image:[UIImage imageNamed:@"pbook.png"] tag:0];
    f.tabBarItem = fI;
    h = [[History alloc] init];
    h.title = NSLocalizedString(@"History", nil);
    UINavigationController *hn = [[UINavigationController alloc] initWithRootViewController:h];
    UITabBarItem *hI = [[UITabBarItem alloc] initWithTitle:h.title image:[UIImage imageNamed:@"pclock.png"] tag:0];
    h.tabBarItem = hI;
    c = [[Custom alloc] init];
    c.title = NSLocalizedString(@"Custom", nil);
    UINavigationController *cn = [[UINavigationController alloc] initWithRootViewController:c];
    UITabBarItem *cI = [[UITabBarItem alloc] initWithTitle:c.title image:[UIImage imageNamed:@"pwri.png"] tag:0];
    c.tabBarItem = cI;
    s = [[Search alloc] init];
    s.title = NSLocalizedString(@"Search", nil);
    UINavigationController *sn = [[UINavigationController alloc] initWithRootViewController:s];
    UITabBarItem *sI = [[UITabBarItem alloc] initWithTitle:s.title image:[UIImage imageNamed:@"psearch.png"] tag:0];
    s.tabBarItem = sI;
    setView = [[SettingViewController alloc] init];
//    IASKAppSettingsViewController *setView = [[IASKAppSettingsViewController alloc] init];
//    setView.showCreditsFooter = NO;
//    setView.showDoneButton = NO;
    setView.title = NSLocalizedString(@"Setup", nil);
    UINavigationController *setn = [[UINavigationController alloc] initWithRootViewController:setView];
    UITabBarItem *setViewI = [[UITabBarItem alloc] initWithTitle:setView.title image:[UIImage imageNamed:@"psetting2.png"] tag:0];
    setView.tabBarItem = setViewI;
    diy = [[Diy alloc] init];
    diy.title = NSLocalizedString(@"Individuation", nil);
    UINavigationController *diyn = [[UINavigationController alloc] initWithRootViewController:diy];
    UITabBarItem *diyi = [[UITabBarItem alloc] initWithTitle:diy.title image:[UIImage imageNamed:@"psetting.png"] tag:0];
    diy.tabBarItem = diyi;
    lib = [[Library alloc] init];
    lib.title = NSLocalizedString(@"SourceManagement", nil);
    UINavigationController *libn = [[UINavigationController alloc] initWithRootViewController:lib];
    UITabBarItem *libI = [[UITabBarItem alloc] initWithTitle:lib.title image:[UIImage imageNamed:@"pweb.png"] tag:0];
    lib.delegate = self;
    lib.tabBarItem = libI;
//    g = [[Game alloc] init];
//    g.title = NSLocalizedString(@"Game", nil);
//    UINavigationController *gn = [[UINavigationController alloc] initWithRootViewController:g];
//    UITabBarItem *gI = [[UITabBarItem alloc] initWithTitle:g.title image:[UIImage imageNamed:@"flag-vector.png"] tag:0];
//    g.tabBarItem = gI;
    about = [[AboutViewController alloc] init];
    about.title = NSLocalizedString(@"UpdatesAndOnlineInformation", nil);
    UINavigationController *aboutn = [[UINavigationController alloc] initWithRootViewController:about];
    UITabBarItem *aboutI = [[UITabBarItem alloc] initWithTitle:about.title image:[UIImage imageNamed:@"info2.png"] tag:0];
    about.tabBarItem = aboutI;
    xabout = [[About alloc] init];
    xabout.title = NSLocalizedString(@"About", nil);
    UINavigationController *xaboutn = [[UINavigationController alloc] initWithRootViewController:xabout];
    UITabBarItem *xaboutI = [[UITabBarItem alloc] initWithTitle:xabout.title image:[UIImage imageNamed:@"pinfo.png"] tag:0];
    xabout.tabBarItem = xaboutI;
    yao = [[AnimationPause alloc] init];
    yao.title = NSLocalizedString(@"Shake", nil);
    UINavigationController *yaon = [[UINavigationController alloc] initWithRootViewController:yao];
    UITabBarItem *yaoI = [[UITabBarItem alloc] initWithTitle:yao.title image:[UIImage imageNamed:@"psun.png"] tag:0];
    yao.tabBarItem = yaoI;
//    about.tabBarItem = aboutI;
    self.tab = [[UITabBarController alloc] init];
    self.tab.delegate = self;
    
//    AppADTVC *adv = [[AppADTVC alloc] init];
//    adv.title = NSLocalizedString(@"FindApplication", nil);
//    UINavigationController *advn = [[UINavigationController alloc] initWithRootViewController:adv];
//    UITabBarItem *advI = [[UITabBarItem alloc] initWithTitle:adv.title image:[UIImage imageNamed:@"pkey.png"] tag:0];
//    adv.tabBarItem = advI;
    
    //    self.tab.tabBar.translucent = NO;
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL safe = [setting boolForKey:@"safemode"];
    if (safe) {
        UIViewController *exitn = [[UIViewController alloc] init];
        UINavigationController *xexitn = [[UINavigationController alloc] initWithRootViewController:exitn];
        exitn.title = NSLocalizedString(@"ExitSafeMode", nil);
        UITabBarItem *exitI = [[UITabBarItem alloc] initWithTitle:exitn.title image:[UIImage imageNamed:@"pok.png"] tag:0];
        exitn.tabBarItem = exitI;
        UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnExit setTitle:NSLocalizedString(@"exitnow", nil) forState:UIControlStateNormal];
        [btnExit addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchDown];
        btnExit.frame = CGRectMake(self.view.frame.size.width * 0.5 - 100, self.view.frame.size.height * 0.5 - 100, 200, 200);
        btnExit.backgroundColor = [UIColor lightGrayColor];
        [exitn.view addSubview:btnExit];
        
        self.tab.viewControllers = [NSArray arrayWithObjects:libn,diyn,xaboutn,xexitn, nil];
        [setting setBool:NO forKey:@"safemode"];
        [setting synchronize];
        
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(share:) name:@"share" object:nil];
        self.tab.viewControllers = [NSArray arrayWithObjects:oln,fn,hn,cn,sn,libn,yaon,setn,diyn,aboutn,xaboutn, nil]; //,gn,advn
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alt:) name:@"alt" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whatR:) name:@"whatR" object:nil];
    
    [self.view addSubview:self.tab.view];
    [MobClick checkUpdate];
}
//- (void)whatR:(NSNotification*)notification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"whatR" object:nil];
//    [self sentR];
//}

- (void)share:(NSNotification*)notification
{
    NSArray *info = [notification object];
    NSString *str = [info objectAtIndex:0];
    //[UMSocialSnsService presentSnsIconSheetView:self appKey:@"52cba0fc56240be2220355c9" shareText:str shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,nil] delegate:nil];
    //已删除自定义分享模块
//    ShareView *share = [[ShareView alloc] initWithFrame:self.tab.selectedViewController.view.frame ShareStr:str ViewController:self];
//    [self.view addSubview:share];
}

- (void)exit:(id)sender
{
    exit(0);
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    RefreshView *rf = [[RefreshView alloc] initWithFrame:CGRectMake(0, 0, self.tab.selectedViewController.view.frame.size.width, self.tab.selectedViewController.view.frame.size.height)];
    rf.delegate = self;
    rf.alpha = 0;
    [self.view addSubview:rf];
    [UIView animateWithDuration:0.3 animations:^{
        rf.alpha = 1;
    } completion:^(BOOL finished) {
        [rf startreload:URL ModeTag:mtag Local:local];
    }];
}
    
- (void)showBlack:(BOOL)isBalck
{
    if (isBalck) {
        if (!black) {
            black = [[UIView alloc] initWithFrame:self.view.window.frame];
            black.backgroundColor = [UIColor blackColor];
            black.alpha = 0.0f;
            [self.view addSubview:black];
            [UIView animateWithDuration:0.5 animations:^{
                black.alpha = 0.5f;
            }];
        }
    } else {
        if (black) {
            [UIView animateWithDuration:0.5 animations:^{
                black.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [black removeFromSuperview];
                black = nil;
            }];
        }
    }
}
    
- (void)didInit
{
    [S s].alertEnabled = YES;
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    //自动更新源
    NSDate *nowDate = [NSDate date];
    [self registerDefaultsFromSettingsBundle];
    
    if (![setting objectForKey:@"oldData"]) {
        [setting setObject:nowDate forKey:@"oldData"];
    }
    if (![setting objectForKey:@"nowURL"]) {
        NSString *nowURL = @"http://uuu.moe/ce.xml";
        [setting setObject:[NSString stringWithString:nowURL] forKey:@"nowURL"];
    } else {
        if([[setting objectForKey:@"nowURL"] rangeOfString:@"heartunlock.com"].location != NSNotFound)
        {
            NSString *nowURL = @"http://uuu.moe/ce.xml";
            [setting setObject:[NSString stringWithString:nowURL] forKey:@"nowURL"];
        }
    }
    if (![setting objectForKey:@"fav"]) {
        [setting setObject:[NSMutableArray array] forKey:@"fav"];
    }
    if (![setting objectForKey:@"his"]) {
        [setting setObject:[NSMutableArray array] forKey:@"his"];
    }
    if (![setting objectForKey:@"diy"]) {
        [setting setObject:[NSMutableArray array] forKey:@"diy"];
    }
    if (![setting objectForKey:@"TAcell"]) {
        NSData *object = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blackColor]];
        [setting setObject:[NSData dataWithData:object] forKey:@"TAcell"];
    }
    if (![setting objectForKey:@"TAtxt"]) {
        NSData *object = [NSKeyedArchiver archivedDataWithRootObject:[UIColor yellowColor]];
        [setting setObject:[NSData dataWithData:object] forKey:@"TAtxt"];
    }
    if (![setting objectForKey:@"TBcell"]) {
        NSData *object = [NSKeyedArchiver archivedDataWithRootObject:[UIColor whiteColor]];
        [setting setObject:[NSData dataWithData:object] forKey:@"TBcell"];
    }
    if (![setting objectForKey:@"TBtxt"]) {
        NSData *object = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blackColor]];
        [setting setObject:[NSData dataWithData:object] forKey:@"TBtxt"];
    }
    if (![setting floatForKey:@"TAalpha"] || [setting floatForKey:@"TAalpha"] == 0) {
        [setting setFloat:0.5f forKey:@"TAalpha"];
    }
    if (![setting floatForKey:@"TBalpha"] || [setting floatForKey:@"TBalpha"] == 0) {
        [setting setFloat:0.5f forKey:@"TBalpha"];
    }
    
    [self defaultImageFile];
    
    if(![setting boolForKey:@"firstStart"]){
        //NSLog(@"第一次启动");
        [setting setBool:YES forKey:@"firstStart"];
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

//            [setting setObject:nowDate forKey:@"oldApp"];
//        }
        [S s].ad = [setting integerForKey:@"ad"];
    }
    [setting synchronize];
}
- (void)alt:(NSNotification*)notification
{
    NSArray *info = [notification object];
    NSNumber *num = [info objectAtIndex:0];
    NSString *str = [info objectAtIndex:1];
    
    [PasteboardController whiteString:str];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *sh = [NSMutableArray arrayWithArray:[S s].allinfo];
    NSArray *hisData = [setting objectForKey:@"diy"];
    [sh addObjectsFromArray:hisData];
    for (NSArray *nowArr in sh) {
        NSString *nowStr = [nowArr objectAtIndex:2];
        if ([nowStr isEqualToString:str]) {
            NSMutableArray *his = [setting mutableArrayValueForKey:@"his"];
            NSLog(@"his == %@",his);
            for (int i = 0; i < [his count]; i++) {
                NSArray *nowArr2 = [his objectAtIndex:i];
                NSString *str1 = [nowArr objectAtIndex:2];
                NSString *str2 = [nowArr2 objectAtIndex:2];
                if ([str1 isEqualToString:str2]) {
                    [his removeObjectAtIndex:i];
                }
            }
            [his addObject:nowArr];
            [setting setObject:[NSArray arrayWithArray:his] forKey:@"his"];
            [setting synchronize];
            //break;
        }
    }
    
    int mode = [num intValue];
    [MobClick event:@"copy"];
    if (mode == 0) {
        [self.view makeToast:NSLocalizedString(@"Clipboard", nil)];
    } else if (mode == 1) {
        [self.view makeToast:NSLocalizedString(@"Clipboard", nil)];
    } else if (mode == 2) {
        [self.view makeToast:NSLocalizedString(@"Clipboard", nil)];
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
//    NSString *f0 = [[NSBundle mainBundle] pathForResource:@"psz0" ofType:@"jpg"];
//    NSString *f1 = [[NSBundle mainBundle] pathForResource:@"psz1" ofType:@"jpg"];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *t0 = [NSString stringWithFormat:@"%@/bg0.cxc",documentDirectory];
    NSString *t1 = [NSString stringWithFormat:@"%@/bg1.cxc",documentDirectory];
    if (![fileManager fileExistsAtPath:t0]) {
//        [fileManager copyItemAtPath:f0 toPath:t0 error:nil];
        [fileManager removeItemAtPath:t0 error:nil];
    }
    if (![fileManager fileExistsAtPath:t1]) {
//        [fileManager copyItemAtPath:f1 toPath:t1 error:nil];
        [fileManager removeItemAtPath:t1 error:nil];
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
//    [self sentR:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"r" object:nil];
}

- (void)sentR:(UIInterfaceOrientation)rMode
{
    //iOS7标题栏高度64
    //iOS6-7工具栏高度49
    //iOS6标题栏高度31
    CGSize screenSize = [S s].screenSize;
    if (rMode == UIDeviceOrientationPortrait){
        NSLog(@"按钮下");
        if ([S s].ios < 7.0f) {
            self.view.frame = CGRectMake(0, 40, screenSize.width-20, screenSize.height-20);
            [S s].viewFrame = CGRectMake(0, -6, screenSize.width, screenSize.height-101);
        } else {
            [S s].viewFrame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        }
    }
    else if(rMode == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"按钮右");
        if ([S s].ios < 7.0f) {
            self.view.frame = CGRectMake(0, 20, screenSize.width-19, screenSize.height-20);
            [S s].viewFrame = CGRectMake(0, 0, screenSize.height, screenSize.width-100);
        } else {
            [S s].viewFrame = CGRectMake(0, 0, screenSize.height, screenSize.width);
        }
    }
    else if(rMode == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"按钮左");
        if ([S s].ios < 7.0f) {
            self.view.frame = CGRectMake(20, 20, screenSize.width-20, screenSize.height);
            [S s].viewFrame = CGRectMake(0, 0, screenSize.height, screenSize.width-100);
        } else {
            [S s].viewFrame = CGRectMake(0, 0, screenSize.height, screenSize.width);
        }
    }
    else
    {
        NSLog(@"按钮上");
        if ([S s].ios < 7.0f) {
            self.view.frame = CGRectMake(20, 20, screenSize.width-20, screenSize.height-20);
            [S s].viewFrame = CGRectMake(0, -6, screenSize.width, screenSize.height-101);
        } else {
            [S s].viewFrame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        }
    }
    self.firstRun = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"r" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [MobClick event:@"MemoryWarning"];
    [super didReceiveMemoryWarning];
    [self.view makeToast:NSLocalizedString(@"MemoryWarning", nil)];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    if ([S s].ios < 7.0f) {
        return NO;
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ([S s].ios < 7.0f) {
        return NO;
    }
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([S s].ios < 7.0f) {
        return NO;
    }
    return UIInterfaceOrientationMaskAll;
}

@end

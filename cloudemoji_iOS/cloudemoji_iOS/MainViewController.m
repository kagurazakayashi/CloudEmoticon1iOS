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
#import "IASKAppSettingsViewController.h"
#import "AboutViewController.h"
#import "SearchTVC.h"
#import "RefreshView.h"
#import "DIYViewController.h"
#import "ProgressHUD.h"
#import "S.h"
@interface MainViewController ()

@end

@implementation MainViewController

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
    NSLog(@"数据文件夹：%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    [self didInit];
    OnlineLibraryTVC *ol = [[OnlineLibraryTVC alloc] init];
    ol.title = @"云颜文字";
    UINavigationController *oln = [[UINavigationController alloc] initWithRootViewController:ol];
    oln.navigationBar.translucent = NO;
    UITabBarItem *olI = [[UITabBarItem alloc] initWithTitle:ol.title image:[UIImage imageNamed:@"pcould.png"] selectedImage:[UIImage imageNamed:@"pcould2.png"]];
    ol.delegate = self;
    ol.tabBarItem = olI;
    FavoritesTVC *f = [[FavoritesTVC alloc] init];
    f.title = @"收藏夹";
    UINavigationController *fn = [[UINavigationController alloc] initWithRootViewController:f];
    UITabBarItem *fI = [[UITabBarItem alloc] initWithTitle:f.title image:[UIImage imageNamed:@"pbook.png"] selectedImage:[UIImage imageNamed:@"pbook2.png"]];
    f.tabBarItem = fI;
    HistoryTVC *h = [[HistoryTVC alloc] init];
    h.title = @"历史记录";
    UINavigationController *hn = [[UINavigationController alloc] initWithRootViewController:h];
    UITabBarItem *hI = [[UITabBarItem alloc] initWithTitle:h.title image:[UIImage imageNamed:@"pclock.png"] selectedImage:[UIImage imageNamed:@"pclock2.png"]];
    h.tabBarItem = hI;
    CustomTVC *c = [[CustomTVC alloc] init];
    c.title = @"自定义";
    UINavigationController *cn = [[UINavigationController alloc] initWithRootViewController:c];
    UITabBarItem *cI = [[UITabBarItem alloc] initWithTitle:c.title image:[UIImage imageNamed:@"pwri.png"] selectedImage:nil];
    c.tabBarItem = cI;
    SearchTVC *s = [[SearchTVC alloc] init];
    s.title = @"搜索";
    UINavigationController *sn = [[UINavigationController alloc] initWithRootViewController:s];
    UITabBarItem *sI = [[UITabBarItem alloc] initWithTitle:s.title image:[UIImage imageNamed:@"psearch.png"] selectedImage:nil];
    s.tabBarItem = sI;
    IASKAppSettingsViewController *setView = [[IASKAppSettingsViewController alloc] init];
    setView.showCreditsFooter = NO;
    setView.showDoneButton = NO;
    setView.title = @"设置";
    UINavigationController *setn = [[UINavigationController alloc] initWithRootViewController:setView];
    UITabBarItem *setViewI = [[UITabBarItem alloc] initWithTitle:setView.title image:[UIImage imageNamed:@"psetting2.png"] selectedImage:nil];
    setView.tabBarItem = setViewI;
    DIYViewController *diy = [[DIYViewController alloc] init];
    diy.title = @"个性化";
    UINavigationController *diyn = [[UINavigationController alloc] initWithRootViewController:diy];
    UITabBarItem *diyi = [[UITabBarItem alloc] initWithTitle:diy.title image:[UIImage imageNamed:@"psetting.png"] selectedImage:nil];
    diy.tabBarItem = diyi;
    LibraryTVC *lib = [[LibraryTVC alloc] init];
    lib.title = @"源管理";
    UINavigationController *libn = [[UINavigationController alloc] initWithRootViewController:lib];
    UITabBarItem *libI = [[UITabBarItem alloc] initWithTitle:lib.title image:[UIImage imageNamed:@"pweb.png"] selectedImage:nil];
    lib.delegate = self;
    lib.tabBarItem = libI;
    AboutViewController *about = [[AboutViewController alloc] init];
    about.title = @"更新和在线信息";
    UINavigationController *aboutn = [[UINavigationController alloc] initWithRootViewController:about];
    UITabBarItem *aboutI = [[UITabBarItem alloc] initWithTitle:about.title image:[UIImage imageNamed:@"pinfo.png"] selectedImage:[UIImage imageNamed:@"pinfo2.png"]];

    about.tabBarItem = aboutI;
    self.tab = [[UITabBarController alloc] init];
    self.tab.delegate = self;
    self.tab.tabBar.translucent = NO;
    self.tab.viewControllers = [NSArray arrayWithObjects:oln,fn,hn,cn,sn,libn,aboutn,setn,diyn, nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alt:) name:@"alt" object:nil];
    
    [self.view addSubview:self.tab.view];
}
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    RefreshView *rf = [[RefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
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
        NSLog(@"第一次启动");
        [setting setBool:YES forKey:@"firstStart"];
        [setting setObject:nowDate forKey:@"oldData"];
        [setting setObject:nowDate forKey:@"oldApp"];
        NSString *nowURL = @"http://dl.dropboxusercontent.com/u/120725807/test.xml";
        [setting setObject:nowURL forKey:@"nowURL"];
        
        [setting setObject:[NSMutableArray array] forKey:@"fav"];
        [setting setObject:[NSMutableArray array] forKey:@"his"];
        [setting setObject:[NSMutableArray array] forKey:@"diy"];
        [self defaultImageFile];
    }else{
        NSDate *oldData = [setting objectForKey:@"oldData"];
        NSDate *oldApp = [setting objectForKey:@"oldApp"];
        float oldDataI = [oldData timeIntervalSinceNow];
        float oldAppI = [oldApp timeIntervalSinceNow];
        NSLog(@"TTT=%@",[setting objectForKey:@"dataformat"]);
        float dataI = [(NSNumber*)[setting objectForKey:@"dataupdatemode"] floatValue];
        float appI = [(NSNumber*)[setting objectForKey:@"dataupdatemode"] floatValue];
        NSLog(@"上次更新数据%g/%g，上次更新程序%g/%g。",oldDataI,dataI,oldAppI,appI);
        if ((oldDataI*(-1)) >= dataI) {
            //更新数据
            
            [setting setObject:nowDate forKey:@"oldData"];
        }
        if ((oldAppI*(-1)) >= appI) {
            //更新APP
            
            [setting setObject:nowDate forKey:@"oldApp"];
        }
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
    
    for (NSArray *nowArr in [S s].allinfo) {
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
    if (mode == 0) {
        [ProgressHUD show:@"内容已复制到剪贴板"];
    } else if (mode == 1) {
        [ProgressHUD showSuccess:@"内容已复制到剪贴板"];
    } else if (mode == 2) {
        [ProgressHUD showError:@"内容已复制到剪贴板"];
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

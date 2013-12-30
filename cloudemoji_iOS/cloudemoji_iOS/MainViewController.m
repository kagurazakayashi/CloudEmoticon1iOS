//
//  MainViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "MainViewController.h"
#import "RefreshView.h"
#import "OnlineLibraryTVC.h"
#import "HistoryTVC.h"
#import "FavoritesTVC.h"
#import "CustomTVC.h"
#import "IASKAppSettingsViewController.h"
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
    [self didInit];
    OnlineLibraryTVC *ol = [[OnlineLibraryTVC alloc] init];
    ol.title = @"云颜文字";
    FavoritesTVC *f = [[FavoritesTVC alloc] init];
    f.title = @"收藏夹";
    HistoryTVC *h = [[HistoryTVC alloc] init];
    h.title = @"历史记录";
    CustomTVC *c = [[CustomTVC alloc] init];
    c.title = @"自定义";
    IASKAppSettingsViewController *setView = [[IASKAppSettingsViewController alloc] init];
    setView.title = @"设置";
    self.tab = [[UITabBarController alloc] init];
    self.tab.delegate = self;
    self.tab.viewControllers = [NSArray arrayWithObjects:ol,f,h,c,setView, nil];
    
    [self.view addSubview:self.tab.view];
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
        }
        if ((oldAppI*(-1)) >= appI) {
            //更新APP
        }
    }
    [setting synchronize];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

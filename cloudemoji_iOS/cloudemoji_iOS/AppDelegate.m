//
//  AppDelegate.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UMSocial.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect scr = [[UIScreen mainScreen] bounds];
    [S s].isupdateData = NO;
    float windowY = 0;
    if ([S s].ios < 7.0) {
        windowY = -20;
    }
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, windowY, scr.size.width, scr.size.height)];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self shareSetting];
    
    //allinfo = [[NSMutableArray alloc] init];
    application.applicationSupportsShakeToEdit = YES;
    
    MainViewController *mvc = [[MainViewController alloc] init];
    self.window.rootViewController = mvc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)shareSetting
{
    ///// yashi personal KEY, do not copy /////
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9"];
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"WebDisk"];
    [MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"Github"];
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"app.io"];
    [UMSocialData setAppKey:@"52cba0fc56240be2220355c9"];
    //[MobClick setLogEnabled:YES];
}


@end

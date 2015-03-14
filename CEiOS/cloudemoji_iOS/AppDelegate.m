//
//  AppDelegate.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "AppDelegate.h"
//#import "UMSocial.h"
#import "CESDK.h"

@implementation AppDelegate
@synthesize mvc;
- (void)shareSetting
{
    ///// yashi personal KEY, do not copy /////
    [MobClick startWithAppkey:@"52cba0fc56240be2220355c9"];
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"WebDisk"];
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"Github"];
    //[MobClick startWithAppkey:@"52cba0fc56240be2220355c9" reportPolicy:REALTIME channelId:@"app.io"];
    //[UMSocialData setAppKey:@"52cba0fc56240be2220355c9"];
    //[MobClick setLogEnabled:YES];
    
    //NSLog(NSLocalizedString(@"SdkNoDataTitle", nil));
}

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
    
    mvc = [[MainViewController alloc] init];
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (![S s].storeBusy) {
        NSString *urlStr=[url absoluteString];
        NSArray *info = [urlStr componentsSeparatedByString:@":"];
        if ([info count] != 3 && [info count] != 2) {
            [self errURL:urlStr];
        } else {
            if ([info count] == 2) {
                if ([[info objectAtIndex:0] isEqualToString:@"cloudemoticon"]) {
                    [self impURL:url];
                } else if ([[info objectAtIndex:0] isEqualToString:@"cloudemoticons"]) {
                    [self impURL:url];
                } else {
                    [self errURL:urlStr];
                }
            } else if ([[info objectAtIndex:0] isEqualToString:@"cloudemoticon"] || [[info objectAtIndex:1] isEqualToString:@"sdk"]) {
                CESDK *cesdk = [[CESDK alloc] init];
                [cesdk toSDKwithAPPURLstr:[info objectAtIndex:2]];
            }
        }
    }
    return YES;
}
- (void)impURL:(NSURL*)iurl
{
    [S s].impURL = iurl;
    if (mvc.tab.selectedIndex != 5) {
        [mvc.tab setSelectedIndex:5];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imp" object:nil];
    }
    [MobClick event:@"browserSetup"];
}
- (void)errURL:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无效参数。" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end

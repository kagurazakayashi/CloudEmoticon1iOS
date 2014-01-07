//
//  SettingViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-6.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize lbl1,lbl2,lbl3,lbl4,btn1;
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
    // Do any additional setup after loading the view from its nib.
    lbl1.text = NSLocalizedString(@"slbl1", nil);
    lbl2.text = NSLocalizedString(@"slbl2", nil);
    lbl3.text = NSLocalizedString(@"LocalFile", nil);
    lbl4.text = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [btn1 setTitle:NSLocalizedString(@"exitnow", nil) forState:UIControlStateNormal];
}
- (IBAction)btnExit:(id)sender {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  XAboutViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-7.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "XAboutViewController.h"

@interface XAboutViewController ()

@end

@implementation XAboutViewController
@synthesize versionText,thirdPart,aboutInfo,aboutAppName;
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
    aboutAppName.text = [NSString stringWithFormat:@"%@ for iOS",NSLocalizedString(@"SoftwareName", nil)];
    versionText.text = NSLocalizedString(@"VersionText", nil);
    NSString *third = @"AnimationPauseViewController (gamy)\nProgressHUD (Related Code)\nMobClick (Umeng)\nXCImageView (XiaoXiao)";
    thirdPart.text = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"ThirdPart", nil),third];
    aboutInfo.text = [NSString stringWithFormat:NSLocalizedString(@"AboutInfo", nil),NSLocalizedString(@"translator", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

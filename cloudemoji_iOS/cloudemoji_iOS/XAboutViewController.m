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
    float dstitle = [S s].correct.width;
    float dsfoot = [S s].correct.height;
    self.view.frame = CGRectMake(0, dstitle, self.view.frame.size.width, self.view.frame.size.height - dstitle - dsfoot);
    aboutAppName.text = [NSString stringWithFormat:@"%@ for iOS",NSLocalizedString(@"SoftwareName", nil)];
    versionText.text = NSLocalizedString(@"VersionText", nil);
    thirdPart.backgroundColor = [UIColor lightGrayColor];
    NSString *third = @"Toast (Charles Scalesse)\nMobClick (Umeng)\nAnimationPauseViewController (gamy)\nXCImageView (XiaoXiao)";
    NSString *lenguage = @"简体中文 (Chinese_Simplified)\n正體中文 (Chinese_Traditional)\nEnglish (English)";
    thirdPart.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",NSLocalizedString(@"InstalledLanguages", nil),lenguage,NSLocalizedString(@"ThirdPart", nil),third];
    aboutInfo.text = [NSString stringWithFormat:NSLocalizedString(@"AboutInfo", nil),NSLocalizedString(@"translator", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

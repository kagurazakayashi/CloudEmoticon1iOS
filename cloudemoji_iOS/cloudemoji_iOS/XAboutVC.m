//
//  XAboutVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-29.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "XAboutVC.h"
#import "DazFireworksController.h"
@interface XAboutVC ()

@end

@implementation XAboutVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    [super viewWillAppear:YES];
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)load
{
//    self.view.frame = [S s].viewFrame;
    strID = 0;
    
//    float dstitle = [S s].correct.width;
//    float dsfoot = [S s].correct.height;
//    float bgy = 0;
//    if ([S s].ios < 7.0) {
//        dstitle = 0;
//        dsfoot = 134;
//        bgy = 0 - dstitle - dsfoot + 40;
//    } else {
//        dstitle = 84;
//        dsfoot = 69;
//    }
    self.view.backgroundColor = [UIColor blackColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height)];//CGRectMake(0, dstitle - 20, self.view.frame.size.width, self.view.frame.size.height - dstitle - dsfoot + 40)
    
//    if ([S s].ios >= 7.0) {
//        view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height);
//    }
    view.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = view.backgroundColor;
    [self.view addSubview:view];
    strArr = [[self txt] componentsSeparatedByString:@"\n\n"];
    show = [[UILabel alloc] initWithFrame:view.frame];
    DazFireworksController *dz = [[DazFireworksController alloc] init];
    dz.view.frame = view.frame;
    [self.view addSubview:dz.view];
    show.backgroundColor = [UIColor clearColor];
    show.textColor = [UIColor whiteColor];
    show.textAlignment = NSTextAlignmentCenter;
    show.lineBreakMode = NSLineBreakByWordWrapping;
    show.numberOfLines = 0;
    show.shadowColor = [UIColor grayColor];
    show.shadowOffset = CGSizeMake(1, 1);
    show.font = [UIFont systemFontOfSize:15];
    show.text = [strArr objectAtIndex:0];
    [self.view addSubview:show];
    [self doani];
}

- (void)doani
{
    [UIView animateWithDuration:3 animations:^{
        show.alpha = 0;
    } completion:^(BOOL finished) {
        strID++;
        //NSLog(@"strID=%d/%d",strID,[strArr count]);
        show.text = [strArr objectAtIndex:strID];
        show.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:3 animations:^{
            show.alpha = 1;
            show.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if (strID < [strArr count] - 1) {
                [self doani];
            } else {
                //NSLog(@"OK");
            }
        }];
    }];
}

- (NSString*)txt
{
    NSMutableArray *s = [NSMutableArray array];
    [s addObject:@"( っ*'ω'*c)\n"];
    [s addObject:[NSString stringWithFormat:@"%@ for iOS",NSLocalizedString(@"SoftwareName", nil)]];
    NSString *curVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [s addObject:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"VersionText", nil),curVer]];
    [s addObject:@""];
    
    [s addObject:[NSString stringWithFormat:NSLocalizedString(@"AboutInfo", nil),NSLocalizedString(@"translator", nil)]];
    [s addObject:@""];
    
    [s addObject:NSLocalizedString(@"InstalledLanguages", nil)];
    [s addObject:@" \n简体中文 (Chinese_Simplified)\nby 神楽坂雅詩\n "];
    [s addObject:@"正體中文 (Chinese_Traditional)\nby 神楽坂雅詩\n "];
    [s addObject:@"English (English)\nby Losses Don & Kanade Tachibana\n "];
    [s addObject:@"日本語 (Japanese)\nby fatianyu\n "];
    [s addObject:@""];
    
    [s addObject:NSLocalizedString(@"ThirdPart", nil)];
    [s addObject:@"Toast (Charles Scalesse)"];
    [s addObject:@"QR Code Generator (Andrew Kopanev)"];
    [s addObject:@"AnimationPauseViewController (gamy)"];
    [s addObject:@"PunjabiKeyboard (Kulpreet Chilana)"];
    [s addObject:@"MobClick (Umeng)"];
    //[s addObject:@"UMAppNetwork (Umeng)"];
    [s addObject:@"UMSocial (Umeng)"];
    [s addObject:@"ANImageBitmapRep (Alex Nichol)"];
    [s addObject:@"RSColorPickerView (Ryan Sullivan)"];
    [s addObject:@"AdMob Ads SDK (Google)"];
    [s addObject:@"Dazzle (Leonhard Lichtschlag)"];
    [s addObject:@"EGORefreshTableHeaderView (Devin Doty)"];
    [s addObject:@"XCImageView (XiaoXiao)"];
    [s addObject:@""];
    [s addObject:NSLocalizedString(@"cc", nil)];
    [s addObject:@""];
    [s addObject:@"(C) 神楽坂雅詩(CXC) 2014\nwww.heartunlock.com"];

    
//    for (int i = 0; i < 20; i++) {
//        [s addObject:@" "];
//    }
    
    NSString *allstr = [s componentsJoinedByString:@"\n"];
    //NSLog(@"allstr=\n%@",allstr);
    return allstr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

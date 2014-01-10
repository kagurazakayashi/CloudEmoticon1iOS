//
//  DIYViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "DIYViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DIYViewController ()

@end

@implementation DIYViewController
@synthesize imgA, imgB, mode, zName, zoom1, zoom2, alertmode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mode = 0;
        self.zName = [NSArray arrayWithObjects:NSLocalizedString(@"ContentModeScaleToFill", nil),NSLocalizedString(@"ContentModeScaleAspectFit", nil),NSLocalizedString(@"ContentModeScaleAspectFill", nil),NSLocalizedString(@"ContentModeRedraw", nil),NSLocalizedString(@"ContentModeTop", nil),NSLocalizedString(@"ContentModeBottom", nil),NSLocalizedString(@"ContentModeLeft", nil),NSLocalizedString(@"ContentModeRight", nil),NSLocalizedString(@"ContentModeTopLeft", nil),NSLocalizedString(@"ContentModeTopRight", nil),NSLocalizedString(@"ContentModeBottomLeft", nil),NSLocalizedString(@"ContentModeBottomRight", nil), nil];
        [self didLoad];
        [self loadSetting];
    }
    return self;
}

- (void)didLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    float dstitle = [S s].correct.width;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    float fontSize = 15.0;
    imgA = [[BackgroundImg alloc] init];
    float iy = 10;
    if ([S s].ios < 7.0) {
        iy = 0;
    }
    [imgA changeFrame:CGRectMake(10, dstitle + iy, self.view.frame.size.width * 0.5 - 15, self.view.frame.size.height * 0.5 - 15)];
//    imgA.bg.backgroundColor = [UIColor blackColor];
    imgA.backgroundColor = [UIColor blackColor];
    [scroll addSubview:imgA];
    UIButton *btnA = [UIButton buttonWithType:UIButtonTypeSystem];
//    btnA.backgroundColor = [UIColor blueColor];
    btnA.frame = CGRectMake(imgA.frame.origin.x, imgA.frame.origin.y + imgA.frame.size.height + 5, imgA.frame.size.width, 38);
    [btnA setTitle:NSLocalizedString(@"ReplaceBackground", nil) forState:UIControlStateNormal];
    [btnA addTarget:self action:@selector(btnA:) forControlEvents:UIControlEventTouchDown];
    btnA.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:btnA];
    zoom1 = [UIButton buttonWithType:UIButtonTypeSystem];
//    zoom1.backgroundColor = [UIColor purpleColor];
    zoom1.frame = CGRectMake(imgA.frame.origin.x, imgA.frame.origin.y + imgA.frame.size.height + btnA.frame.size.height + 10, btnA.frame.size.width, btnA.frame.size.height);
    [zoom1 addTarget:self action:@selector(zoom1:) forControlEvents:UIControlEventTouchDown];
    zoom1.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:zoom1];
    UIButton *delA = [UIButton buttonWithType:UIButtonTypeSystem];
//    delA.backgroundColor = [UIColor grayColor];
    delA.frame = CGRectMake(imgA.frame.origin.x, zoom1.frame.origin.y + zoom1.frame.size.height + 5, btnA.frame.size.width, btnA.frame.size.height);
    [delA setTitle:NSLocalizedString(@"RestoreDefaultBackground", nil) forState:UIControlStateNormal];
    [delA addTarget:self action:@selector(delA:) forControlEvents:UIControlEventTouchDown];
    delA.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:delA];
    
    imgB = [[BackgroundImg alloc] init];
    [imgB changeFrame:CGRectMake(self.view.frame.size.width * 0.5 + 5, imgA.frame.origin.y, self.view.frame.size.width * 0.5 - 15, self.view.frame.size.height * 0.5 - 15)];
//    imgB.bg.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:imgB];
    UIButton *btnB = [UIButton buttonWithType:UIButtonTypeSystem];
//    btnB.backgroundColor = [UIColor blueColor];
    btnB.frame = CGRectMake(imgB.frame.origin.x, imgB.frame.origin.y + imgA.frame.size.height + 5, imgB.frame.size.width, btnA.frame.size.height);
    [btnB setTitle:NSLocalizedString(@"ReplaceForeground", nil) forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(btnB:) forControlEvents:UIControlEventTouchDown];
    btnB.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:btnB];
    zoom2 = [UIButton buttonWithType:UIButtonTypeSystem];
//    zoom2.backgroundColor = [UIColor purpleColor];
    zoom2.frame = CGRectMake(imgB.frame.origin.x, imgB.frame.origin.y + imgB.frame.size.height + btnB.frame.size.height + 10, btnB.frame.size.width, btnB.frame.size.height);
    [zoom2 addTarget:self action:@selector(zoom2:) forControlEvents:UIControlEventTouchDown];
    zoom2.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:zoom2];
    UIButton *delB = [UIButton buttonWithType:UIButtonTypeSystem];
//    delB.backgroundColor = [UIColor grayColor];
    delB.frame = CGRectMake(imgB.frame.origin.x, zoom2.frame.origin.y + zoom2.frame.size.height + 5, btnB.frame.size.width, btnB.frame.size.height);
    [delB setTitle:NSLocalizedString(@"RestoreDefaultForeground", nil) forState:UIControlStateNormal];
    [delB addTarget:self action:@selector(delB:) forControlEvents:UIControlEventTouchDown];
    delB.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [scroll addSubview:delB];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, delB.frame.origin.y + delB.frame.size.height + 60);
    [self.view addSubview:scroll];
    
}

- (void)loadSetting
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSNumber *psz0n = [setting objectForKey:@"psz0"];
    NSInteger psz0 = [psz0n integerValue];
    [imgA.img setContentMode:psz0];
    [imgA loadSettingImg:0];
    [zoom1 setTitle:[zName objectAtIndex:psz0] forState:UIControlStateNormal];
    NSNumber *psz1n = [setting objectForKey:@"psz1"];
    NSInteger psz1 = [psz1n integerValue];
    [imgB.img setContentMode:psz1];
    [imgB loadSettingImg:1];
    [zoom2 setTitle:[zName objectAtIndex:psz1] forState:UIControlStateNormal];
    
}

- (void)zoom1:(id)sender
{
    mode = 1;
    [self selectZoom];
}
- (void)zoom2:(id)sender
{
    mode = 2;
    [self selectZoom];
}
- (void)selectZoom
{
    if ([self canContinue]) {
        alertmode = 1;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"ImageScalingMode_title", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ImageScalingMode_cancel", nil) otherButtonTitles:NSLocalizedString(@"ContentModeScaleToFill", nil),NSLocalizedString(@"ContentModeScaleAspectFit", nil),NSLocalizedString(@"ContentModeScaleAspectFill", nil),NSLocalizedString(@"CutOut", nil), nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertmode == 2) {
        [self selectZoom];
    } else if (buttonIndex > 0) {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSInteger idx = buttonIndex - 1;
        if (alertmode == 2) {
            idx += 3;
        }
        if (buttonIndex == 4 && alertmode == 1) {
            alertmode = 2;
            UIAlertView *more = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"Previous", nil) otherButtonTitles:NSLocalizedString(@"ContentModeCenter", nil),NSLocalizedString(@"ContentModeTop", nil),NSLocalizedString(@"ContentModeBottom", nil),NSLocalizedString(@"ContentModeLeft", nil),NSLocalizedString(@"ContentModeRight", nil),NSLocalizedString(@"ContentModeTopLeft", nil),NSLocalizedString(@"ContentModeTopRight", nil),NSLocalizedString(@"ContentModeBottomLeft", nil),NSLocalizedString(@"ContentModeBottomRight", nil), nil];
            [more show];
        } else {
            if (mode == 1) {
                [imgA.img setContentMode:idx];
                [zoom1 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz0"];
            } else if (mode == 2) {
                [imgB.img setContentMode:idx];
                [zoom1 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz1"];
            }
            [setting synchronize];
        }
    }
}

- (void)btnA:(id)sender
{
    mode = 1;
    [self selectPicture];
}
- (void)btnB:(id)sender
{
    mode = 2;
    [self selectPicture];
}
- (void)selectPicture
{
    if ([self canContinue]) {
        [self.delegate openPicID:mode];
    }
}

- (void)delA:(id)sender
{
    mode = 1;
    UIImage *d = [UIImage imageNamed:@"psz0.jpg"];
    [self selectPic:d];
}
- (void)delB:(id)sender
{
    mode = 2;
    UIImage *d = [UIImage imageNamed:@"psz1.jpg"];
    [self selectPic:d];
}

- (BOOL)canContinue
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL cpic = [[setting objectForKey:@"cpic"] boolValue];
    if (!cpic) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Disable_title", nil) message:NSLocalizedString(@"Disable_message", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    return cpic;
}

- (void)selectPic:(UIImage*)image
{
    if (mode == 1) {
        [imgA changeImage:image];
        [imgA saveSettingImg:0];
    } else if (mode == 2) {
        [imgB changeImage:image];
        [imgB saveSettingImg:1];
    }
//    NSNumber *nmode = [NSNumber numberWithInt:mode-1];
//    NSArray *postinfo = [NSArray arrayWithObjects:nmode, image, nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"bg" object:postinfo];
    //[self performSelectorInBackground:@selector(detect:) withObject:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

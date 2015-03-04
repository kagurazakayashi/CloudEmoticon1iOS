//
//  DIYVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-27.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "DIYVC.h"
#import "RSBrightnessSlider.h"
//#import "ColorConvert.h"
@interface DIYVC ()

@end

@implementation DIYVC
@synthesize imgA, imgB;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        zName = [NSArray arrayWithObjects:NSLocalizedString(@"ContentModeScaleToFill", nil),NSLocalizedString(@"ContentModeScaleAspectFit", nil),NSLocalizedString(@"ContentModeScaleAspectFill", nil),NSLocalizedString(@"ContentModeRedraw", nil),NSLocalizedString(@"ContentModeTop", nil),NSLocalizedString(@"ContentModeBottom", nil),NSLocalizedString(@"ContentModeLeft", nil),NSLocalizedString(@"ContentModeRight", nil),NSLocalizedString(@"ContentModeTopLeft", nil),NSLocalizedString(@"ContentModeTopRight", nil),NSLocalizedString(@"ContentModeBottomLeft", nil),NSLocalizedString(@"ContentModeBottomRight", nil), nil];
        //[self loadUI];
        //[self loadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)load
{
    [self loadUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (leftCellA) {
        [self loadData];
    }
}

- (void)loadData
{
    [imgA loadSetting:0];
    [imgB loadSetting:1];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    UIColor *tAcell = [NSKeyedUnarchiver unarchiveObjectWithData:[setting objectForKey:@"TAcell"]];
    UIColor *tAtxt = [NSKeyedUnarchiver unarchiveObjectWithData:[setting objectForKey:@"TAtxt"]];
    UIColor *tBcell = [NSKeyedUnarchiver unarchiveObjectWithData:[setting objectForKey:@"TBcell"]];
    UIColor *tBtxt = [NSKeyedUnarchiver unarchiveObjectWithData:[setting objectForKey:@"TBtxt"]];
    leftCellA.backgroundColor = tAcell;
    leftCellB.backgroundColor = tAcell;
    leftCellA.alpha = [setting floatForKey:@"TAalpha"];
    leftCellB.alpha = [setting floatForKey:@"TAalpha"];
    leftTxt.textColor = tAtxt;
    rightCellA.backgroundColor = tBcell;
    rightCellB.backgroundColor = tBcell;
    rightCellA.alpha = [setting floatForKey:@"TBalpha"];
    rightCellB.alpha = [setting floatForKey:@"TBalpha"];
    rightTxt.textColor = tBtxt;
    
    //alpha
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setObject:[NSKeyedArchiver archivedDataWithRootObject:leftCellA.backgroundColor] forKey:@"TAcell"];
    [setting setObject:[NSKeyedArchiver archivedDataWithRootObject:leftTxt.textColor] forKey:@"TAtxt"];
    [setting setObject:[NSKeyedArchiver archivedDataWithRootObject:rightCellA.backgroundColor] forKey:@"TBcell"];
    [setting setObject:[NSKeyedArchiver archivedDataWithRootObject:rightTxt.textColor] forKey:@"TBtxt"];
    [setting setFloat:leftCellA.alpha forKey:@"TAalpha"];
    [setting setFloat:rightCellA.alpha forKey:@"TBalpha"];
    [setting synchronize];
    [super viewWillDisappear:animated];
}

- (void)loadUI
{
    float dstitle = [S s].correct.width;
    float dsfoot = [S s].correct.height;
    float bgy = 0;
    if ([S s].ios < 7.0) {
        dstitle = 0;
        dsfoot = 134;
        bgy = 0 - dstitle - dsfoot + 40;
    } else {
        dstitle = 84;
        dsfoot = 69;
    }
    //    CGSize diyViewSize = CGSizeMake(360, 367);
    UIView *diyView = [[UIView alloc] initWithFrame:CGRectMake(0, dstitle - 20, self.view.frame.size.width, self.view.frame.size.height - dstitle - dsfoot + 30)];
//<<<<<<< HEAD
    diyView.backgroundColor = [UIColor whiteColor];
//=======
//    diyView.backgroundColor = [UIColor orangeColor];
//>>>>>>> FETCH_HEAD
    
    CGSize ds = CGSizeMake(diyView.frame.size.width, diyView.frame.size.height);
    
    UILabel *demo_title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, ds.width - 10, 40)];
    demo_title.text = @"( っ*'ω'*c)";
    demo_title.font = [UIFont systemFontOfSize:17];
    demo_title.textAlignment = NSTextAlignmentCenter;
    demo_title.backgroundColor = [UIColor whiteColor];
    demo_title.textColor = [UIColor colorWithRed:70.0f/255.0f green:217.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [diyView addSubview:demo_title];
    
    UIView *foottool = [[UIView alloc] initWithFrame:CGRectMake(5, ds.height - 45, ds.width - 10, 40)];
    foottool.backgroundColor = [UIColor whiteColor];
    [diyView addSubview:foottool];
    
	UIImageView *demo_tool_left = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 30, 30)];
    demo_tool_left.image = [UIImage imageNamed:@"psetting.png"];
    demo_tool_left.alpha = 0.5f;
    [diyView addSubview:demo_tool_left];
    
    UIImageView *demo_tool_right = [[UIImageView alloc] initWithFrame:CGRectMake(ds.width - 40, 12, 30, 30)];
    demo_tool_right.image = [UIImage imageNamed:@"pre.png"];
    demo_tool_right.alpha = 0.5f;
    [diyView addSubview:demo_tool_right];
    
    float ww = ds.width / 5.0f;
    NSArray *tbimg = [NSArray arrayWithObjects:@"pcould.png",@"pbook.png",@"pclock.png",@"pwri.png",@"pkey.png", nil];
    
    //NSArray *btnimg = [NSArray arrayWithObjects:[UIImage imageNamed:@"stop.png"],[UIImage imageNamed:@"window.png"],[UIImage imageNamed:@"picture.png"], nil];
    UIImage *btnColorImg = [UIImage imageNamed:@"color.png"];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *demo_tool = [[UIImageView alloc] initWithFrame:CGRectMake(ww * i + 15, ds.height - 40, 30, 30)];
        demo_tool.image = [UIImage imageNamed:[tbimg objectAtIndex:i]];
        demo_tool.alpha = 0.5f;
        [diyView addSubview:demo_tool];
    }
    
    imgA = [[BackgroundImg alloc] initWithFrame:CGRectMake(5, demo_title.frame.size.height + 5, (ds.width - 5) * 0.4, ds.height - 90)];
    
    leftCellA = [[UIView alloc] initWithFrame:CGRectMake(10, demo_title.frame.size.height + 10, imgA.frame.size.width - 10, 45)];
    leftCellA.backgroundColor = [UIColor blackColor];
    leftCellA.alpha = 0.5f;
    [diyView addSubview:leftCellA];
    
    leftTxt = [[UILabel alloc] initWithFrame:leftCellA.frame];
    leftTxt.text = @"　(ノ・ω・)ノ";
    leftTxt.backgroundColor = [UIColor clearColor];
    leftTxt.textColor = [UIColor yellowColor];
    [diyView addSubview:leftTxt];
    
    leftCellAs = [UIButton buttonWithType:UIButtonTypeCustom];
    leftCellAs.frame = CGRectMake(leftCellA.frame.origin.x, leftCellA.frame.origin.y, 30, 30);
    [leftCellAs setImage:btnColorImg forState:UIControlStateNormal];
    [leftCellAs addTarget:self action:@selector(leftCellAs:) forControlEvents:UIControlEventTouchDown];
    [diyView addSubview:leftCellAs];
    
    leftCellB = [[UIView alloc] initWithFrame:CGRectMake(leftCellA.frame.origin.x, leftCellA.frame.origin.y + leftCellA.frame.size.height + 1, leftCellA.frame.size.width, leftCellA.frame.size.height)];
    leftCellB.backgroundColor = [UIColor blackColor];
    leftCellB.alpha = 0.5f;
    [diyView addSubview:leftCellB];
    
    leftCellBs = [UIButton buttonWithType:UIButtonTypeCustom];
    leftCellBs.frame = CGRectMake(leftCellB.frame.origin.x + (leftCellB.frame.size.width * 0.5 - 15), leftCellB.frame.origin.y + (leftCellB.frame.size.height * 0.5 - 15), 30, 30);
    [leftCellBs setImage:btnColorImg forState:UIControlStateNormal];
    [leftCellBs addTarget:self action:@selector(leftCellBs:) forControlEvents:UIControlEventTouchDown];
    [diyView addSubview:leftCellBs];
    
    for (int i = 2; i >= 0; i--) {
        UIButton *btnPic = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPic.frame = CGRectMake(imgA.frame.size.width - 105 + 35 * i, imgA.frame.origin.x + imgA.frame.size.height, 30, 30);
        //[btnimg objectAtIndex:i - 1]
        //NSArray *btnimg = [NSArray arrayWithObjects:,[UIImage imageNamed:@"window.png"],[UIImage imageNamed:@"picture.png"], nil];
        [diyView addSubview:btnPic];
        if (i == 2) {
            [btnPic setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(deletePicA:) forControlEvents:UIControlEventTouchDown];
        } else if (i == 1) {
            [btnPic setImage:[UIImage imageNamed:@"window.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(leftPicModeA:) forControlEvents:UIControlEventTouchDown];
        } else {
            [btnPic setImage:[UIImage imageNamed:@"picture.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(leftChangePicA:) forControlEvents:UIControlEventTouchDown];
        }
    }
    
    imgB = [[BackgroundImg alloc] initWithFrame:CGRectMake(imgA.frame.size.width, imgA.frame.origin.y, ds.width - imgA.frame.size.width - 5, imgA.frame.size.height)];
    imgB.layer.shadowColor = [[UIColor blackColor] CGColor];
    imgB.layer.shadowOffset = CGSizeMake(-10,0);
    imgB.layer.shadowOpacity = 1;
    imgB.layer.shadowRadius = 10;
    [diyView insertSubview:imgB belowSubview:demo_title];
    [diyView insertSubview:imgA belowSubview:imgB];
    
    rightCellA = [[UIView alloc] initWithFrame:CGRectMake(imgA.frame.size.width + 10, imgB.frame.origin.y + 15, imgB.frame.size.width - 20, 60)];
    rightCellA.backgroundColor = [UIColor whiteColor];
    rightCellA.alpha = 0.5f;
    rightCellA.layer.cornerRadius = 10;
    [diyView addSubview:rightCellA];
    
    rightTxt = [[UILabel alloc] initWithFrame:rightCellA.frame];
    rightTxt.text = @"　ლ(╹◡╹ლ)﻿";
    rightTxt.backgroundColor = [UIColor clearColor];
    rightTxt.textColor = [UIColor blackColor];
    [diyView addSubview:rightTxt];
    
    rightCellAs = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCellAs.frame = CGRectMake(rightCellA.frame.origin.x, rightCellA.frame.origin.y, 30, 30);
    [rightCellAs setImage:btnColorImg forState:UIControlStateNormal];
    [rightCellAs addTarget:self action:@selector(rightCellAs:) forControlEvents:UIControlEventTouchDown];
    [diyView addSubview:rightCellAs];
    
    rightCellB = [[UIView alloc] initWithFrame:CGRectMake(rightCellA.frame.origin.x, rightCellA.frame.origin.y + rightCellA.frame.size.height + 15, rightCellA.frame.size.width, rightCellA.frame.size.height)];
    rightCellB.backgroundColor = [UIColor whiteColor];
    rightCellB.alpha = 0.5f;
    rightCellB.layer.cornerRadius = 10;
    [diyView addSubview:rightCellB];
    
    rightCellBs = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCellBs.frame = CGRectMake(rightCellB.frame.origin.x + (rightCellB.frame.size.width * 0.5 - 15), rightCellB.frame.origin.y + (rightCellB.frame.size.height * 0.5 - 15), 30, 30);
    [rightCellBs setImage:btnColorImg forState:UIControlStateNormal];
    [rightCellBs addTarget:self action:@selector(rightCellBs:) forControlEvents:UIControlEventTouchDown];
    [diyView addSubview:rightCellBs];
    
    for (int i = 2; i >= 0; i--) {
        UIButton *btnPic = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPic.frame = CGRectMake(imgA.frame.size.width + imgB.frame.size.width - 105 + 35 * i, imgB.frame.origin.y + imgB.frame.size.height - 40, 30, 30);
        //[btnimg objectAtIndex:i - 1]
        //NSArray *btnimg = [NSArray arrayWithObjects:,[UIImage imageNamed:@"window.png"],[UIImage imageNamed:@"picture.png"], nil];
        [diyView addSubview:btnPic];
        if (i == 2) {
            [btnPic setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(deletePicB:) forControlEvents:UIControlEventTouchDown];
        } else if (i == 1) {
            [btnPic setImage:[UIImage imageNamed:@"window.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(leftPicModeB:) forControlEvents:UIControlEventTouchDown];
        } else {
            [btnPic setImage:[UIImage imageNamed:@"picture.png"] forState:UIControlStateNormal];
            [btnPic addTarget:self action:@selector(leftChangePicB:) forControlEvents:UIControlEventTouchDown];
        }
    }
    
    colorSelectFrame = CGRectMake(20, ds.height - 160, ds.width - 40, 70);
    colorSelect = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, colorSelectFrame.origin.y, colorSelectFrame.size.width, colorSelectFrame.size.height)];
    colorSelect.backgroundColor = [UIColor whiteColor];
    [colorSelect setHidden:YES];
    
    colorSelect.layer.shadowColor = [[UIColor whiteColor] CGColor];
    colorSelect.layer.shadowOffset = CGSizeMake(0,0);
    colorSelect.layer.shadowOpacity = 1;
    colorSelect.layer.shadowRadius = 3;
    
    colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(1, 1, colorSelect.frame.size.height - 2, colorSelect.frame.size.height - 2)];
    colorPicker.backgroundColor = [UIColor whiteColor];
    colorPicker.delegate = self;
    //colorPicker.selectionColor = [UIColor blackColor];
    [colorSelect addSubview:colorPicker];
    
    RSBrightnessSlider *brightnessSlider = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(colorPicker.frame.origin.x + colorPicker.frame.size.width + 5, 2, colorSelect.frame.size.width - (colorPicker.frame.origin.x + colorPicker.frame.size.width) - 35, 35)];
    [brightnessSlider setColorPicker:colorPicker];
    [brightnessSlider setUseCustomSlider:YES];
    [colorSelect addSubview:brightnessSlider];
    
    alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(brightnessSlider.frame.origin.x, brightnessSlider.frame.origin.y + brightnessSlider.frame.size.height, brightnessSlider.frame.size.width, brightnessSlider.frame.size.height)];
    alphaSlider.maximumValue = 1;
    alphaSlider.minimumValue = 0;
    alphaSlider.value = 1;
    [alphaSlider addTarget:self action:@selector(alphaSlider:) forControlEvents:UIControlEventValueChanged];
    [colorSelect addSubview:alphaSlider];
    
    UIButton *closeColor = [UIButton buttonWithType:UIButtonTypeSystem];
    closeColor.frame = CGRectMake(colorSelect.frame.size.width - 20, 0, 20, 20);
    [closeColor setTitle:@"×" forState:UIControlStateNormal];
    [closeColor addTarget:self action:@selector(closeColor:) forControlEvents:UIControlEventTouchDown];
    [colorSelect addSubview:closeColor];
    
    [diyView addSubview:colorSelect];
    [self.view addSubview:diyView];
}

-(void)colorPickerDidChangeSelection:(RSColorPickerView*)cp
{
    [self chageObjectColor:[cp selectionColor] Alpha:2];
    
}

- (void)alphaSlider:(id)sender
{
    [self chageObjectColor:nil Alpha:alphaSlider.value];
}

- (void)chageObjectColor:(UIColor*)color Alpha:(float)alpha
{
    switch (mode) {
        case 1:
            if (color) {
                leftTxt.textColor = color;
            }
            break;
        case 2:
            if (color) {
                leftCellA.backgroundColor = color;
                leftCellB.backgroundColor = color;
            }
            if (alpha <= 1) {
                leftCellA.alpha = alpha;
                leftCellB.alpha = alpha;
            }
            break;
        case 3:
            if (color) {
                rightTxt.textColor = color;
            }
            break;
        case 4:
            if (color) {
                rightCellA.backgroundColor = color;
                rightCellB.backgroundColor = color;
            }
            if (alpha <= 1) {
                rightCellA.alpha = alpha;
                rightCellB.alpha = alpha;
            }
            break;
        default:
            break;
    }
}

- (void)colorSelect:(BOOL)isOpen
{
    if (isOpen) {
        if (colorSelect.hidden == NO) {
            [UIView animateWithDuration:0.25 animations:^{
                colorSelect.frame = CGRectMake(0 - self.view.frame.size.width, colorSelectFrame.origin.y, colorSelectFrame.size.width, colorSelectFrame.size.height);
            } completion:^(BOOL finished) {
                colorSelect.frame = CGRectMake(self.view.frame.size.width, colorSelectFrame.origin.y, colorSelectFrame.size.width, colorSelectFrame.size.height);
            [UIView animateWithDuration:0.25 animations:^{
                colorSelect.frame = colorSelectFrame;
            }];
            }];
        } else {
            [colorSelect setHidden:NO];
            [UIView animateWithDuration:0.3 animations:^{
                colorSelect.frame = colorSelectFrame;
            }];
        }
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            colorSelect.frame = CGRectMake(self.view.frame.size.width, colorSelectFrame.origin.y, colorSelectFrame.size.width, colorSelectFrame.size.height);
        } completion:^(BOOL finished) {
            [colorSelect setHidden:YES];
        }];
    }
}
- (void)closeColor:(id)sender
{
    [self showAllBtnAlpha:NO];
    [self colorSelect:NO];
}
- (void)showAllBtnAlpha:(BOOL)alpha
{
    if (alpha) {
        alphaSlider.enabled = YES;
    } else {
        alphaSlider.value = alphaSlider.maximumValue;
        alphaSlider.enabled = NO;
    }
    if (leftCellAs.hidden) {
        leftCellAs.hidden = NO;
    }
    if (leftCellBs.hidden) {
        leftCellBs.hidden = NO;
    }
    if (rightCellAs.hidden) {
        rightCellAs.hidden = NO;
    }
    if (rightCellBs.hidden) {
        rightCellBs.hidden = NO;
    }
}
- (void)leftCellAs:(id)sender
{
    mode = 1;
    //NSLog(@"mode=%d",mode);
    [self showAllBtnAlpha:NO];
    [self colorSelect:YES];
    [(UIButton*)sender setHidden:YES];
}

- (void)leftCellBs:(id)sender
{
    mode = 2;
    //NSLog(@"mode=%d",mode);
    [self showAllBtnAlpha:YES];
    [self colorSelect:YES];
    alphaSlider.value = leftCellA.alpha;
    [(UIButton*)sender setHidden:YES];
}

- (void)rightCellAs:(id)sender
{
    mode = 3;
    //NSLog(@"mode=%d",mode);
    [self showAllBtnAlpha:NO];
    [self colorSelect:YES];
    [(UIButton*)sender setHidden:YES];
}

- (void)rightCellBs:(id)sender
{
    mode = 4;
    //NSLog(@"mode=%d",mode);
    [self showAllBtnAlpha:YES];
    [self colorSelect:YES];
    alphaSlider.value = rightCellA.alpha;
    [(UIButton*)sender setHidden:YES];
}
- (void)leftChangePicA:(id)sender
{
    mode = 5;
    [self closeColor:nil];
    [self selectPicture];
}
- (void)leftPicModeA:(id)sender
{
    mode = 6;
    [self closeColor:nil];
    [self selectZoom];
}
- (void)deletePicA:(id)sender
{
    mode = 7;
    [self closeColor:nil];
    UIImage *d = nil;
    [self selectPic:d];
}
- (void)leftChangePicB:(id)sender
{
    mode = 8;
    [self closeColor:nil];
    [self selectPicture];
}
- (void)leftPicModeB:(id)sender
{
    mode = 9;
    [self closeColor:nil];
    [self selectZoom];
    
}

- (void)selectPicture
{
    int pmode = 1;
    if (mode == 8) {
        pmode = 2;
    }
    if ([self canContinue]) {
        [self.delegate openPicID:pmode];
    }
}
- (void)deletePicB:(id)sender
{
    mode = 10;
    [self closeColor:nil];
    UIImage *d = nil;
    [self selectPic:d];
}

- (void)selectPic:(UIImage*)image
{
    if (mode == 7 || mode == 5) {
        [imgA changeImage:image];
        [imgA saveSettingImg:0];
    } else if (mode == 10 || mode == 8) {
        [imgB changeImage:image];
        [imgB saveSettingImg:1];
    }
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

- (void)selectZoom
{
    if ([self canContinue]) {
        alertmode = 1;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"ImageScalingMode_title", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ImageScalingMode_cancel", nil) otherButtonTitles:NSLocalizedString(@"ContentModeScaleToFill", nil),NSLocalizedString(@"ContentModeScaleAspectFit", nil),NSLocalizedString(@"ContentModeScaleAspectFill", nil),NSLocalizedString(@"CutOut", nil), nil];
        [S s].alertEnabled = NO;
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
            if (mode == 6) {
                [imgA.img setContentMode:idx];
                //[zoom1 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz0"];
            } else if (mode == 9) {
                [imgB.img setContentMode:idx];
                //[zoom2 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz1"];
            }
            [setting synchronize];
            [S s].alertEnabled = YES;
        }
    } else {
        [S s].alertEnabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

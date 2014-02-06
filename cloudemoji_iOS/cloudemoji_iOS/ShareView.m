//
//  ShareView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "ShareView.h"
#import "QRCodeGenerator.h"
@implementation ShareView
@synthesize shareStr = _shareStr, tableview = _tableview;
- (id)initWithFrame:(CGRect)frame ShareStr:(NSString *)shareStr ViewController:(UIViewController*)vc
{
    CGRect sf = frame;
    CGRect hf = CGRectMake(frame.origin.x, 0 - frame.size.height, frame.size.width, frame.size.height);
    self = [super initWithFrame:hf];
    if (self) {
        showFrame = sf;
        hideFrame = hf;
        openedQR = 0;
        self.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1];
        viewController = vc;
        self.shareStr = shareStr;
        
        [self loadData];
        
        UIView *titleBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showFrame.size.width, 200)];
        titleBG.backgroundColor = [UIColor colorWithRed:79.0f/255.0f green:190.0f/255.0f blue:232.0f/255.0f alpha:1];
        
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.titleLabel.textColor = [UIColor lightGrayColor];
        [btnBack setTitle:@"< (っ*'ω'*c)﻿" forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(closeShare:) forControlEvents:UIControlEventTouchDown];
        btnBack.frame = CGRectMake(10, 20, 100, 20);
        
        UILabel *sstr = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, showFrame.size.width, 80)];
        sstr.backgroundColor = [UIColor clearColor];
        sstr.textColor = [UIColor whiteColor];
        sstr.font = [UIFont systemFontOfSize:40];
        sstr.text = shareStr;
        sstr.textAlignment = NSTextAlignmentCenter;
        
        UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(0, sstr.frame.origin.y + sstr.frame.size.height + 10, showFrame.size.width, 20)];
        info.backgroundColor = [UIColor clearColor];
        info.textColor = [UIColor whiteColor];
        info.text = NSLocalizedString(@"SharingThis", nil);
        info.textAlignment = NSTextAlignmentCenter;
        
        [titleBG addSubview:btnBack];
        [titleBG addSubview:sstr];
        [titleBG addSubview:info];
        [self addSubview:titleBG];
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(20, titleBG.frame.size.height, self.frame.size.width - 40, self.frame.size.height - titleBG.frame.size.height) style:UITableViewStyleGrouped];
        _tableview.dataSource = self;
        _tableview.delegate = self;
//        _tableview.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_tableview];
        [self showShare];
        //
    }
    return self;
}

- (void)loadData
{
//    if ([self isRetinaDisplay]) {
//        qr = [QRCodeGenerator qrImageForString:_shareStr imageSize:78.0f];
//    } else {
        qr = [QRCodeGenerator qrImageForString:_shareStr imageSize:39.0f];
//    }
    groupname = [NSArray arrayWithObjects:NSLocalizedString(@"QuickConvey", nil),NSLocalizedString(@"SNS", nil), nil];
    g1txt = [NSArray arrayWithObjects:NSLocalizedString(@"GenerateQR", nil),NSLocalizedString(@"SMS", nil),NSLocalizedString(@"e-mail", nil), nil];
    g1img = [NSArray arrayWithObjects:@"",@"UMS_sms_icon.png",@"UMS_email_icon.png", nil];
    g2txt = [NSArray arrayWithObjects:NSLocalizedString(@"WechatContact", nil),NSLocalizedString(@"Q-zone", nil),NSLocalizedString(@"SinaWeibo", nil),NSLocalizedString(@"Renren", nil),NSLocalizedString(@"TencentWeibo", nil),NSLocalizedString(@"WechatMoments", nil),NSLocalizedString(@"Facebook", nil),NSLocalizedString(@"Twitter", nil),NSLocalizedString(@"douban", nil), nil];
    g2img = [NSArray arrayWithObjects:@"UMS_wechat_icon.png",@"UMS_qzone_icon.png",@"UMS_sina_icon.png",@"UMS_renren_icon.png",@"UMS_tencent_icon.png",@"UMS_wechat_timeline_icon.png",@"UMS_facebook_icon.png",@"UMS_twitter_icon.png",@"UMS_douban_icon.png", nil];
}
- (BOOL) isRetinaDisplay
{
    int scale = 1.0;
    UIScreen *screen = [UIScreen mainScreen];
    if([screen respondsToSelector:@selector(scale)])
        scale = screen.scale;
    
    if(scale == 2.0f) return YES;
    else return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width - 20, cell.frame.size.height)];
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0 && openedQR == 1) {
            cell.textLabel.text = NSLocalizedString(@"Save", nil);
        } else if (indexPath.row == 0 && openedQR == 2) {
            cell.textLabel.text = NSLocalizedString(@"SavedAlbum", nil);
        } else {
            cell.textLabel.text = [g1txt objectAtIndex:indexPath.row];
        }
        if (indexPath.row == 0) {
            [cell.imageView setImage:qr];
        } else {
            [cell.imageView setImage:[UIImage imageNamed:[g1img objectAtIndex:indexPath.row]]];
        }
    } else {
        cell.textLabel.text = [g2txt objectAtIndex:indexPath.row];
        [cell.imageView setImage:[UIImage imageNamed:[g2img objectAtIndex:indexPath.row]]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (openedQR == 1) {
            UIImage *saveImg = [QRCodeGenerator qrImageForString:_shareStr imageSize:512.0f];
            UIImageWriteToSavedPhotosAlbum(saveImg, nil, nil, nil);
            openedQR = 2;
            qr = [QRCodeGenerator qrImageForString:_shareStr imageSize:39.0f];
            [tableView reloadData];
        } else {
            openedQR = 1;
            qr = [QRCodeGenerator qrImageForString:_shareStr imageSize:180.0f];
            [self.tableview reloadData];
        }
    } else {
        [[UMSocialControllerService defaultControllerService] setShareText:_shareStr shareImage:nil socialUIDelegate:nil];
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 1:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSms].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 2:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToEmail].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 1:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 2:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 3:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToRenren].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 4:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 5:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 6:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToFacebook].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 7:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTwitter].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                case 8:
                    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToDouban].snsClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES);
                    break;
                default:
                    break;
            }
        }
        [self closeShare:nil];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [groupname objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [groupname count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [g1txt count];
    } else {
        return [g2txt count];
    }
}

- (void)setShareStr:(NSString *)shareStr
{
    _shareStr = shareStr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0 && openedQR == 1) {
        return 180;
    } else {
        return 50;
    }
}

- (void)showShare
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = showFrame;
    }];
}

- (void)closeShare:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = hideFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

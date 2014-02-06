//
//  ADView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "ADView.h"

@implementation ADView

- (id)initWithViewController:(UIViewController*)rootViewController ShowNow:(BOOL)shownow FixHeight:(BOOL)fix
{
    CGSize adSize = GAD_SIZE_320x50;
    CGRect screen = [UIScreen mainScreen].bounds;
    float y = screen.size.height - 111;//rootViewController.view.frame.size.height - adSize.height;
    if ([S s].ios < 7.0) {
        y = screen.size.height - 178;
    }
    if ([S s].ios >= 7.0 && screen.size.height > 1000) {
        y -= 10;
    }
    if (fix && [S s].ios < 7.0) {
        y -= 20;
    }
//    if (autoheight) {
//        if ([S s].ios >= 7.0) {
//            y -= 64;
//        }
//    }
    CGRect sf = CGRectMake(screen.size.width - adSize.width, y, adSize.width, adSize.height+15);
    CGRect hf = CGRectMake(sf.origin.x, sf.origin.y + sf.size.height, sf.size.width, sf.size.height);
    self = [super initWithFrame:hf];
    if (self) {
        showFrame = sf;
        hideFrame = hf;
        [self setHidden:YES];
//        [S s].adi++;
//        if ([S s].ad < [S s].adi) {
//            [self didLoad:rootViewController];
//        } else {
//            [self removeFromSuperview];
//        }
        int gl = [S s].ad;
        int rem = 0;
        if (shownow) {
            self.alpha = 1;
        } else {
            rem = arc4random()%99;
            self.alpha = 0.5;
        }
        if (rem < gl) {
            [self didLoad:rootViewController];
        } else {
            [self removeFromSuperview];
        }
        //NSLog(@"%d/%d",rem,gl);
    }
    return self;
}

- (void)didLoad:(UIViewController*)rootViewController
{
    CGSize adSize = GAD_SIZE_320x50;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(self.frame.size.width - adSize.width,self.frame.size.height - adSize.height,adSize.width,adSize.height)];
    
    bannerView_.adUnitID = @"a152e28af12721c";
    
    bannerView_.rootViewController = rootViewController;
    [self addSubview:bannerView_];
    
    bannerView_.delegate = self;
    
    [bannerView_ loadRequest:[GADRequest request]];
    
    adinfo = [[UILabel alloc] initWithFrame:CGRectMake(bannerView_.frame.origin.x, bannerView_.frame.origin.y - 15, bannerView_.frame.size.width, 15)];
    adinfo.backgroundColor = [UIColor blackColor];
    adinfo.textColor = [UIColor whiteColor];
    adinfo.text = @" [AD]┐( Ծ ω Ծ ) :";
    
    UIButton *cAD = [UIButton buttonWithType:UIButtonTypeCustom];
    [cAD setTitle:@"×" forState:UIControlStateNormal];
    [cAD addTarget:self action:@selector(closeAD:) forControlEvents:UIControlEventTouchDown];
    cAD.backgroundColor = [UIColor blackColor];
    cAD.titleLabel.textColor = [UIColor whiteColor];
    cAD.frame = CGRectMake(adinfo.frame.size.width - 20, 0, 20, adinfo.frame.size.height);
    [self addSubview:adinfo];
    [self addSubview:cAD];
}

- (void)closeAD:(id)sender
{
    adinfo.text = @" [×](つ⁰﹏⁰)つ﻿ :";
    [UIView animateWithDuration:1 animations:^{
        self.frame = hideFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showAD
{
    [self setHidden:NO];
    [UIView animateWithDuration:1 animations:^{
        self.frame = showFrame;
    }];
}

- (void)dealloc
{
    bannerView_.delegate = nil;
}

// Sent when an ad request loaded an ad.  This is a good opportunity to add this
// view to the hierarchy if it has not yet been added.  If the ad was received
// as a part of the server-side auto refreshing, you can examine the
// hasAutoRefreshed property of the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    [self showAD];
}

// Sent when an ad request failed.  Normally this is because no network
// connection was available or no ads were available (i.e. no fill).  If the
// error was received as a part of the server-side auto refreshing, you can
// examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self closeAD:nil];
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

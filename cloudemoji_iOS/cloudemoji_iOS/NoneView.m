//
//  NoneView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-24.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "NoneView.h"

@implementation NoneView
@synthesize logoLabel, infoLabel, info = _info, bg;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addObject];
    }
    return self;
}

- (void)addObject
{
    if (!logoLabel) {
        logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.3, self.frame.size.width, 100)];
        logoLabel.textAlignment = NSTextAlignmentCenter;
        logoLabel.backgroundColor = [UIColor clearColor];
        logoLabel.text = @"(´・ω・`)";
        logoLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:logoLabel];
    }
    if (!infoLabel) {
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.4, self.frame.size.width, 100)];
        infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        infoLabel.numberOfLines = 0;
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.text = _info;
        [self addSubview:infoLabel];
    }
    if (!bg) {
        bg = [[UILabel alloc] initWithFrame:CGRectMake(0, logoLabel.frame.origin.y, self.frame.size.width, logoLabel.frame.size.height + infoLabel.frame.size.height * 0.5)];
        bg.backgroundColor = [UIColor whiteColor];
        bg.alpha = 0.5;
        [self addSubview:bg];
    }
}

- (void)setInfo:(NSString *)info
{
    if (infoLabel) {
        infoLabel.text = info;
    }
    _info = info;
}

- (void)hide:(NSUInteger)dataCount
{
    if (dataCount > 0) {
        if (self.hidden == NO) {
            if (logoLabel) {
                [logoLabel removeFromSuperview];
                logoLabel = nil;
            }
            if (infoLabel) {
                [infoLabel removeFromSuperview];
                infoLabel = nil;
            }
            if (bg) {
                [bg removeFromSuperview];
                bg = nil;
            }
            [self setHidden:YES];
        }
    } else {
        if (self.hidden == YES) {
            [self addObject];
            [self setHidden:NO];
        }
    }
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

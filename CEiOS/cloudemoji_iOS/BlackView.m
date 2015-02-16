//
//  BlackView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-2-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "BlackView.h"

@implementation BlackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0f;
    }
    return self;
}
    
- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.5f;
    }];
}
    
- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0f;
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

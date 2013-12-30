//
//  RefreshView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)didLoad
{
    float icoSize = 304.0f;
    UIImageView *logoimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-icoSize*0.5, self.frame.size.height*0.2, icoSize, icoSize)];
    logoimg.image = [UIImage imageNamed:@"ic_launcher-152.png"];
    [self addSubview:logoimg];
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

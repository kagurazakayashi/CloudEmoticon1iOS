//
//  TypeMenuCell.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-3-23.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "TypeMenuCell.h"

@implementation TypeMenuCell
@synthesize pro=_pro, aniSpeed=_aniSpeed, sbView0=_sbView0, sbView1=_sbView1;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _sbView0 = [[UIView alloc] init];
        _sbView1 = [[UIView alloc] init];
        _sbView1.backgroundColor = [UIColor whiteColor];
        _sbView1.alpha = 0.2f;
        [_sbView0 addSubview:_sbView1];
        _pro = [[UIActivityIndicatorView alloc] init];
        _pro.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _pro.hidesWhenStopped = YES;
        [_pro startAnimating];
        [_sbView0 addSubview:_pro];
        self.selectedBackgroundView = _sbView0;
    }
    return self;
}

- (void)loadTableWidth:(float)tableWidth
{
    _sbView0.frame = CGRectMake(0, 0, tableWidth, self.frame.size.height);
    _sbView1.frame = _sbView0.frame;
    _pro.frame = CGRectMake(tableWidth - 45, self.frame.size.height * 0.5 - 15, 30, 30);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)changeOpen:(BOOL)isOpen
{
    /*
    float movex = 45.0f;
    if (!isOpen) {
        movex = 15.0f;
        [_pro stopAnimating];
    } else {
        [_pro startAnimating];
        self.textLabel.frame = CGRectMake(movex, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    }
    */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    if (selected) {
        [self changeOpen:YES];
        [NSTimer scheduledTimerWithTimeInterval:_aniSpeed target:self selector:@selector(closeActiv:) userInfo:nil repeats:NO];
    }
}

- (void)closeActiv:(id)sender
{
    [self changeOpen:NO];
}

@end

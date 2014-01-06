//
//  OnlineLibraryCell.m
//  cloudemoji_iOS
//
//  Created by 王 燚 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "OnlineLibraryCell.h"
#import "S.h"
#define kBK 10.0f

@implementation OnlineLibraryCell
@synthesize name, info, btnFrv, cellBGView, isfaved, cellmode;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)startWithMode:(int)changemode
{
    cellmode = changemode;
    self.backgroundColor = [UIColor clearColor];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL css = [[setting objectForKey:@"css"] boolValue];
    
    cellBGView = [[UIView alloc] init];
    cellBGView.backgroundColor = [UIColor whiteColor];
    cellBGView.alpha = 0.5;
    if (css) {
        cellBGView.layer.shadowColor = [[UIColor whiteColor] CGColor];
        cellBGView.layer.shadowOpacity = 1;
        cellBGView.layer.shadowRadius = 10;
        cellBGView.layer.shadowOffset = CGSizeMake(0, 0);
        cellBGView.layer.cornerRadius = 10;
        cellBGView.layer.masksToBounds = NO;
    }
    [self addSubview:cellBGView];
    name = [[UILabel alloc] init];
    name.font = [UIFont boldSystemFontOfSize:20.0f];
    name.textColor = [UIColor blueColor];
    info = [[UILabel alloc] init];
    info.font = [UIFont boldSystemFontOfSize:15.0f];
    info.numberOfLines = 0;
    info.textColor = [UIColor purpleColor];
    info.lineBreakMode = NSLineBreakByCharWrapping;
    
    if (cellmode < 5) {
        btnFrv = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFrv addTarget:self action:@selector(btnFrv:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btnFrv];
    }
    if (cellmode == 3 || cellmode == 4) {
        [btnFrv setImage:[UIImage imageNamed:@"pdel.png"] forState:UIControlStateNormal];
    }
    
    if (css) {
        if (cellmode == 3 || cellmode == 4) {
            btnFrv.layer.shadowColor = [[UIColor redColor] CGColor];
        } else {
            btnFrv.layer.shadowColor = [[UIColor greenColor] CGColor];
        }
        name.layer.shadowColor = [name.textColor CGColor];
        name.layer.shadowOffset = CGSizeMake(1, 1);
        name.layer.shadowOpacity = 1;
        name.layer.shadowRadius = 2;
        info.layer.shadowColor = [info.textColor CGColor];
        info.layer.shadowOffset = CGSizeMake(1, 1);
        info.layer.shadowOpacity = 1;
        info.layer.shadowRadius = 2;
        if (cellmode < 5) {
            btnFrv.layer.shadowOpacity = 1;
            btnFrv.layer.shadowRadius = 5;
        }
    }
    [self addSubview:name];
    [self addSubview:info];
    
    
}

- (void)btnFrv:(id)sender
{
    if (cellmode <= 2) {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSMutableArray *fav = [setting mutableArrayValueForKey:@"fav"];
        if (isfaved) {
            for (int i = 0; i < [fav count]; i++) {
                NSArray *nowArr = [fav objectAtIndex:i];
                NSString *nowStr = [nowArr objectAtIndex:2];
                if ([nowStr isEqualToString:info.text]) {
                    [fav removeObjectAtIndex:i];
                    isfaved = NO;
                    break;
                }
            }
        } else {
            for (NSArray *nowArr in [S s].allinfo) {
                NSString *nowStr = [nowArr objectAtIndex:2];
                if ([nowStr isEqualToString:info.text]) {
                    [fav addObject:nowArr];
                    isfaved = YES;
                    break;
                }
            }
        }
        [self isFav:isfaved];
        [setting setObject:fav forKey:@"fav"];
        [setting synchronize];
    }
    if (cellmode >= 2 && cellmode != 5) {
        [self.delegate btnSelect:@""];
    }
}
//外部调用
- (void)fav
{
    if (cellmode <= 2) {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSMutableArray *fav = [setting objectForKey:@"fav"];
        BOOL bfav = NO;
        isfaved = NO;
        for (NSArray *nowArr in fav) {
            NSString *nowStr = [nowArr objectAtIndex:2];
            if ([nowStr isEqualToString:info.text]) {
                bfav = YES;
                isfaved = YES;
                break;
            }
        }
        [self isFav:bfav];
    }
}

- (void)isFav:(BOOL)ifav
{
    [btnFrv setImage:nil forState:UIControlStateNormal];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL css = [[setting objectForKey:@"css"] boolValue];
    if (ifav) {
        if (css) {
            btnFrv.layer.shadowColor = [[UIColor yellowColor] CGColor];
        }
        [btnFrv setImage:[UIImage imageNamed:@"pstar2.png"] forState:UIControlStateNormal];
    } else {
        if (css) {
            btnFrv.layer.shadowColor = [[UIColor greenColor] CGColor];
        }
        [btnFrv setImage:[UIImage imageNamed:@"pstar.png"] forState:UIControlStateNormal];
    }
}

- (void)loadFrame:(float)width
{
    name.frame = CGRectMake(kBK * 2, kBK * 2, width * 0.5, 30);
    btnFrv.frame = CGRectMake(width - kBK * 2 - 30, kBK * 2, 30, 30);
}

- (void)btnEdit:(id)sender
{
    [self.delegate btnSelect:@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

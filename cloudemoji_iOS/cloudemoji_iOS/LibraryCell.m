//
//  LibraryCell.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "LibraryCell.h"
@implementation LibraryCell
@synthesize name,info,btnDel,btnFrv,cellBGView,btnEdit;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
//        UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kBK * 0.5)];
//        foot.backgroundColor = [UIColor lightGrayColor];
//        foot.layer.cornerRadius = 10;
//        [cellBGView addSubview:foot];
        [self addSubview:cellBGView];
        name = [[UILabel alloc] init];
        name.font = [UIFont boldSystemFontOfSize:20.0f];
        name.backgroundColor = [UIColor clearColor];
        name.textColor = [UIColor blueColor];
        
        info = [[UILabel alloc] init];
        info.font = [UIFont boldSystemFontOfSize:15.0f];
        info.numberOfLines = 0;
        info.backgroundColor = [UIColor clearColor];
        info.textColor = [UIColor purpleColor];
        info.lineBreakMode = NSLineBreakByCharWrapping;
        
        btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDel setImage:[UIImage imageNamed:@"pdel.png"] forState:UIControlStateNormal];
        //[btnDel setImage:[UIImage imageNamed:@"pdel2.png"] forState:UIControlStateHighlighted];
        [btnDel addTarget:self action:@selector(btnDel:) forControlEvents:UIControlEventTouchDown];
        
        btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnEdit setImage:[UIImage imageNamed:@"pwri.png"] forState:UIControlStateNormal];
        [btnEdit addTarget:self action:@selector(btnEdit:) forControlEvents:UIControlEventTouchDown];
        
        btnFrv = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFrv setImage:[UIImage imageNamed:@"pok.png"] forState:UIControlStateNormal];
        //[btnFrv setImage:[UIImage imageNamed:@"pok2.png"] forState:UIControlStateHighlighted];
        [btnFrv addTarget:self action:@selector(btnFrv:) forControlEvents:UIControlEventTouchDown];
        
        if (css) {
            name.layer.shadowColor = [name.textColor CGColor];
            name.layer.shadowOffset = CGSizeMake(1, 1);
            name.layer.shadowOpacity = 1;
            name.layer.shadowRadius = 2;
            info.layer.shadowColor = [info.textColor CGColor];
            info.layer.shadowOffset = CGSizeMake(1, 1);
            info.layer.shadowOpacity = 1;
            info.layer.shadowRadius = 2;
            btnDel.layer.shadowColor = [[UIColor redColor] CGColor];
            btnDel.layer.shadowOpacity = 1;
            btnDel.layer.shadowRadius = 5;
            btnEdit.layer.shadowColor = [[UIColor yellowColor] CGColor];
            btnEdit.layer.shadowOpacity = 1;
            btnEdit.layer.shadowRadius = 5;
            btnFrv.layer.shadowColor = [[UIColor greenColor] CGColor];
            btnFrv.layer.shadowOpacity = 1;
            btnFrv.layer.shadowRadius = 5;
        }
        [self addSubview:name];
        [self addSubview:info];
        [self addSubview:btnDel];
        [self addSubview:btnEdit];
        [self addSubview:btnFrv];
    }
    return self;
}

- (void)loadFrame:(float)width
{
    name.frame = CGRectMake(kBK * 2, kBK * 2, width * 0.5, 30);
    btnDel.frame = CGRectMake(width - kBK * 2 - 30, kBK * 2, 30, 30);
    btnEdit.frame = CGRectMake(width * 2 - btnDel.frame.origin.x - btnDel.frame.size.width * 2 - 74, btnDel.frame.origin.y, 30, 30);
    btnFrv.frame = CGRectMake(width * 2 - btnDel.frame.origin.x - btnDel.frame.size.width * 3 - 85 , btnDel.frame.origin.y, 30, 30);
    
}

- (void)btnDel:(id)sender
{
    [self.delegate btnDelete:self.info.text];
}
- (void)btnEdit:(id)sender
{
    [self.delegate btnEdit:self.info.text];
}
- (void)btnFrv:(id)sender
{
    [self.delegate btnSelect:self.info.text];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

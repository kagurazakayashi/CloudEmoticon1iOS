//
//  TypeMenuCell.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-3-23.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeMenuCell : UITableViewCell
{
    UIActivityIndicatorView *_pro;
    float _aniSpeed;
    UIView *_sbView0;
    UIView *_sbView1;
    //float _dx;
}
@property (nonatomic ,retain) UIActivityIndicatorView *pro;
@property (nonatomic ,assign) float aniSpeed;
@property (nonatomic ,retain) UIView *sbView0;
@property (nonatomic ,retain) UIView *sbView1;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Width:(float)tableWidth;
- (void)loadTableWidth:(float)tableWidth;
@end
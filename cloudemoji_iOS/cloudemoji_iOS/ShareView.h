//
//  ShareView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@interface ShareView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_shareStr;
    UIViewController *viewController;
    CGRect showFrame;
    CGRect hideFrame;
    UITableView *_tableview;
    
    NSArray *groupname;
    NSArray *g1txt;
    NSArray *g1img;
    NSArray *g2txt;
    NSArray *g2img;
    
    UIImage *qr;
    int openedQR;
}
@property (nonatomic, retain) NSString *shareStr;
@property (nonatomic, retain) UITableView *tableview;
- (id)initWithFrame:(CGRect)frame ShareStr:(NSString *)shareStr ViewController:(UIViewController*)vc;
@end

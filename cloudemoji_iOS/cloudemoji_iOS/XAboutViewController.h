//
//  XAboutViewController.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-7.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAboutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *aboutAppName;
@property (weak, nonatomic) IBOutlet UILabel *versionText;
@property (weak, nonatomic) IBOutlet UITextView *thirdPart;
@property (weak, nonatomic) IBOutlet UILabel *aboutInfo;

@end

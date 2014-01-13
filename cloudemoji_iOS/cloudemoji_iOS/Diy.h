//
//  Diy.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIYViewController.h"
@interface Diy : UIViewController <DIYViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, retain) DIYViewController *vc;
@property (nonatomic, assign) BOOL isOpenPic;
@property (nonatomic, assign) int imgMode;
@end

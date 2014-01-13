//
//  Custom.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTVC.h"
//@protocol CustomTVCMDelegate <NSObject>
////- (void)loadInfo:(NSString*)type;
//@end
@interface Custom : UIViewController <CustomTVCDelegate>
//@property (nonatomic, assign) id<CustomTVCMDelegate> delegate;
@property (nonatomic, retain) CustomTVC *vc;
@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@property (nonatomic, retain) UIBarButtonItem *leftbtn;
@property (nonatomic, assign) BOOL isEdit;
@end

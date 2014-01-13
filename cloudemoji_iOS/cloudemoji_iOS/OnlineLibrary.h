//
//  OnlineLibrary.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryTVC.h"
@protocol OnlineLibraryMDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
@end
@interface OnlineLibrary : UIViewController <OnlineLibraryDelegate>
@property (nonatomic, assign) id<OnlineLibraryMDelegate> delegate;
@property (nonatomic, retain) OnlineLibraryTVC *vc;
@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@property (nonatomic, retain) UIBarButtonItem *leftbtn;
@end

//
//  Library.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryTVC.h"
@protocol LibraryMDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
@end
@interface Library : UIViewController <LibraryDelegate>
@property (nonatomic,assign) id<LibraryMDelegate> delegate;
@property (nonatomic, retain) LibraryTVC *vc;
@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@end

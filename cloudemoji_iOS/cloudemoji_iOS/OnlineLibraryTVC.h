//
//  OnlineLibraryTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeMenuView.h"
#import "BackgroundImg.h"
#import "OnlineLibraryCell.h"
@protocol OnlineLibraryDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
@end

@interface OnlineLibraryTVC : UIViewController <UITableViewDataSource, UITableViewDelegate, TypeMenuViewDelegate>
@property (nonatomic, assign) id<OnlineLibraryDelegate> delegate;
@property (nonatomic, retain) TypeMenuView *typemenu;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) BackgroundImg *typemenuD;
@property (nonatomic, retain) BackgroundImg *tableViewD;
@property (nonatomic, retain) UIView *blackView;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) NSUInteger alertMode;
@property (nonatomic, assign) NSUInteger editNow;
@property (nonatomic, assign) BOOL showTool;
@property (nonatomic, assign) float dstitle;
@property (nonatomic, assign) float dsfoot;
- (void)rightbtn:(id)sender;
- (void)leftbtn:(id)sender;
@end

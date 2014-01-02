//
//  OnlineLibraryTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeMenuView.h"

@protocol OnlineLibraryDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
@end

@interface OnlineLibraryTVC : UIViewController
@property (nonatomic, assign) id<OnlineLibraryDelegate> delegate;
@property (nonatomic, retain) TypeMenuView *typemenu;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *typemenuD;
@property (nonatomic, retain) UIImageView *tableViewD;
@property (nonatomic, retain) UIView *tableViewD2;

- (void)reloadDataOK;
@end

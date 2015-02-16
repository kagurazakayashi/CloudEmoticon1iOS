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
#import "EGORefreshTableHeaderView.h"
#import "NoneView.h"
@protocol OnlineLibraryDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
- (void)changeTitle:(NSString*)titleStr;
@end

@interface OnlineLibraryTVC : UIViewController <UITableViewDataSource, UITableViewDelegate, TypeMenuViewDelegate, EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    float _aniSpeed;
}
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
@property (nonatomic, retain) NoneView *noneview;
- (void)rightbtn:(id)sender;
- (void)leftbtn:(id)sender;
- (void)load;
@end

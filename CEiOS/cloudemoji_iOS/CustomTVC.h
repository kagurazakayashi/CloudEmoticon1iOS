//
//  CustomTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "EditView.h"
#import "NoneView.h"
@protocol CustomTVCDelegate <NSObject>
//- (void)loadInfo:(NSString*)type;
- (void)reloadButton:(BOOL)isEdit;
- (void)openEditWindow:(UIView*)editVC;
- (void)closeEditWindow:(UIView*)editVC;
@end
@interface CustomTVC : UIViewController <OnlineLibraryCellDelegate,UIAlertViewDelegate,EditViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, retain) EditView *edit;
@property (nonatomic, assign) id<CustomTVCDelegate> delegate;
@property (nonatomic, assign) NSUInteger alertMode;
@property (nonatomic, assign) NSUInteger editNow;
@property (nonatomic, assign) int mode;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NoneView *noneview;
- (void)rightbtn:(id)sender;
- (void)load;
@end
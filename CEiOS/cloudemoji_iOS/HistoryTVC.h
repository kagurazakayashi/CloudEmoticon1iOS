//
//  HistoryTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "NoneView.h"
@protocol HistoryTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end
@interface HistoryTVC : UIViewController <OnlineLibraryCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) id<HistoryTVCDelegate> delegate;
- (void)rightbtn:(id)sender;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NoneView *noneview;
- (void)load;
@end

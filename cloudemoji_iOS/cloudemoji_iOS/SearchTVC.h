//
//  SearchTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"

@protocol SearchTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end

@interface SearchTVC : UIViewController <OnlineLibraryCellDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id<SearchTVCDelegate> delegate;
@property (nonatomic, retain) UISearchBar *search;
@end

//
//  SearchTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "S.h"

@protocol SearchTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end

@interface SearchTVC : UITableViewController <OnlineLibraryCellDelegate,UISearchBarDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) id<SearchTVCDelegate> delegate;
@property (nonatomic, retain) UISearchBar *search;
@end

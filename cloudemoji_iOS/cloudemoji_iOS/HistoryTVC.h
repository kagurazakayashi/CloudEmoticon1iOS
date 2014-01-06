//
//  HistoryTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "S.h"
@protocol HistoryTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end
@interface HistoryTVC : UITableViewController <OnlineLibraryCellDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) id<HistoryTVCDelegate> delegate;
@end

//
//  GameTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-5-28.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
//@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, retain) UITableView *tableView;
- (void)load;
@end

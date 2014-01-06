//
//  CustomTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineLibraryCell.h"
#import "S.h"
#import "PKCustomKeyboard.h"
#import "PMCustomKeyboard.h"
@protocol CustomTVCDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end
@interface CustomTVC : UITableViewController <OnlineLibraryCellDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) id<CustomTVCDelegate> delegate;
@end

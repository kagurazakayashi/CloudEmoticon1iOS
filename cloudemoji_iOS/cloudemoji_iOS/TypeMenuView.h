//
//  TypeMenuView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeMenuViewDelegate <NSObject>
- (void)loadInfo:(NSString*)type;
@end

@interface TypeMenuView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<TypeMenuViewDelegate> delegate;
@property (nonatomic, retain) UITableView *tableview;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic ,assign) float aniSpeed;
//@property (nonatomic, retain) NSMutableArray *height;
@end
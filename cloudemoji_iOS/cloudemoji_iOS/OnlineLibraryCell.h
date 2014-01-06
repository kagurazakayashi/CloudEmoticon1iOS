//
//  OnlineLibraryCell.h
//  cloudemoji_iOS
//
//  Created by 王 燚 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OnlineLibraryCellDelegate <NSObject>
-(void)btnSelect:(NSString*)name;
@end
@interface OnlineLibraryCell : UITableViewCell
@property (nonatomic,assign) id<OnlineLibraryCellDelegate> delegate;
@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *info;
@property (nonatomic,retain) UIButton *btnFrv;
@property (nonatomic,retain) UIButton *btnEdit;
@property (nonatomic,retain) UIView *cellBGView;
@property (nonatomic,assign) BOOL isfaved;
@property (nonatomic,assign) int cellmode;

- (void)loadFrame:(float)width;
- (void)fav;
- (void)startWithMode:(int)changemode;
@end

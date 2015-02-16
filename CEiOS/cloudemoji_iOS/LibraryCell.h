//
//  LibraryCell.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LibraryCellDelegate <NSObject>
-(void)btnSelect:(NSString*)name;
-(void)btnEdit:(NSString*)name;
-(void)btnDelete:(NSString*)name;
@end
@interface LibraryCell : UITableViewCell
@property (nonatomic,assign) id<LibraryCellDelegate> delegate;
@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *info;
@property (nonatomic,retain) UILabel *selectedItem;
@property (nonatomic,retain) UIButton *btnDel;
@property (nonatomic,retain) UIButton *btnFrv;
@property (nonatomic,retain) UIButton *btnEdit;
@property (nonatomic,retain) UIView *cellBGView;
- (void)loadFrame:(float)width;
@end

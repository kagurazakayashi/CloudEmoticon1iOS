//
//  LibraryTVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryCell.h"
@protocol LibraryDelegate <NSObject>
- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;
- (void)changeRightButton:(BOOL)isCloseBtn;
- (void)showBlack:(BOOL)isBalck;
@end
@interface LibraryTVC : UIViewController<UIAlertViewDelegate,LibraryCellDelegate,UITableViewDataSource,UITableViewDelegate, UIWebViewDelegate>
@property (nonatomic,assign) id<LibraryDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *height;
@property (nonatomic, assign) NSUInteger alertMode;
@property (nonatomic, assign) NSUInteger editNow;
@property (nonatomic, retain) UITableView *tableView;
//@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@property (nonatomic, retain) UIWebView *storeWeb;
@property (nonatomic, retain) NSString *addStoreURL;
@property (nonatomic, retain) NSURL *weburl;
- (void)rightbtn:(id)sender;
- (void)webView:(BOOL)isShow;
@end

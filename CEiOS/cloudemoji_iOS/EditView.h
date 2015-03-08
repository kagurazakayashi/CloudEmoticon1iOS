//
//  EditView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 15/3/4.
//  Copyright (c) 2015年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewDelegate <NSObject>
- (void)addData:(NSArray*)arr;
- (void)EditViewClose;
@end

@interface EditView : UIView
@property (nonatomic, assign) id<EditViewDelegate> delegate;
@property (nonatomic, retain) UIBarButtonItem *rightbtn;
@property (nonatomic, retain) UITextView *edit;
@property (nonatomic, retain) UITextField *ename;
@property (nonatomic, retain) UIView *bga;
@property (nonatomic, retain) NSString *tagStr;
@property (nonatomic, retain) UIBarButtonItem *tmpRightBtn;
- (void)rightbtn:(id)sender;
- (void)leftbtn:(id)sender;
@end

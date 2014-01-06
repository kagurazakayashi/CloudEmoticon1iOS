//
//  RefreshView.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView <UIAlertViewDelegate>
- (void)startreload:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local;

@property (nonatomic, retain) NSString *cURL;
@property (nonatomic, retain) NSString *mURL;
@property (nonatomic, retain) UILabel *info;
@property (nonatomic ,retain) NSMutableData *connData;
@property (nonatomic ,assign) NSUInteger mode;
@property (nonatomic ,assign) BOOL loc;
@end

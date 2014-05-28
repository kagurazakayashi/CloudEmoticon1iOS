//
//  S.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-5.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kROTATE -(void)viewDidLoad{[super viewDidLoad];}\
-(void)viewDidUnload{[super viewDidUnload];}\
-(BOOL)rotate{[self vd];[self va];return YES;}\
-(void)viewDidAppear:(BOOL)animated{[self va];[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rotate) name:@"r" object:nil];[super viewWillAppear:YES];}\
-(void)viewWillDisappear:(BOOL)animated{[self vd];[[NSNotificationCenter defaultCenter] removeObserver:self];[super viewWillDisappear:YES];}

//self.view.frame = [S s].viewFrame;

//#import "ColorConvert.h"
@interface S : NSObject
{
    NSMutableArray *allinfo;
}

+ (S*)s;

+ (float)txtHeightWithText:(NSString*)text MaxWidth:(float)width;
+ (float)txtWidthWithText:(NSString*)text MaxHeight:(float)height;
+ (void)scoreInfo:(NSDictionary*)dataDic;
+ (int)orientationMode;
//+ (void)sentR:(UIDeviceOrientation)rMode;
//+ (CGRect)tableFrame:(CGRect)viewFrame;
//+ (CGRect)viewFrame:(CGRect)oldFrame;
//+ (BOOL)isLandscapeWithFrame:(CGRect)frame;
//+ (CGRect)xyWithFrame:(CGRect)frame;

@property (nonatomic, retain) NSMutableArray *allinfo;
@property (nonatomic, assign) BOOL isupdateData;
@property (nonatomic, assign) float ios;
@property (nonatomic, assign) CGSize correct;
@property (nonatomic, assign) int ad;
@property (nonatomic, assign) BOOL networkBusy;
@property (nonatomic, assign) BOOL storeBusy;
@property (nonatomic, retain) NSURL *impURL;
@property (nonatomic, assign) BOOL alertEnabled;
@property (nonatomic, assign) CGRect tableFrame;
@property (nonatomic, assign) CGRect viewFrame;
@property (nonatomic, assign) CGSize screenSize;
//@property (nonatomic, retain) ColorConvert *colorconvert;
@end

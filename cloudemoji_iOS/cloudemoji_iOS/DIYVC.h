//
//  DIYVC.h
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-27.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSColorPickerView.h"
#import "BackgroundImg.h"
@protocol DIYViewDelegate <NSObject>
- (void)openPicID:(int)imgID;
@end
@interface DIYVC : UIViewController <RSColorPickerViewDelegate, UIAlertViewDelegate>
{
    UIView *leftCellA;
    UIButton *leftCellAs;
    UIView *leftCellB;
    UIButton *leftCellBs;
    UIView *rightCellA;
    UIButton *rightCellAs;
    UIView *rightCellB;
    UIButton *rightCellBs;
    UILabel *leftTxt;
    UILabel *rightTxt;
    //UIButton *leftChangePic;
    //UIButton *leftPicMode;
    //UIButton *deletePic;
    UIView *colorSelect;
    CGRect colorSelectFrame;
    UISlider *alphaSlider;
    RSColorPickerView *colorPicker;
    int mode;
    int alertmode;
    NSArray *zName;
}
@property (nonatomic, assign) id<DIYViewDelegate> delegate;
@property (nonatomic, retain) BackgroundImg *imgA;
@property (nonatomic, retain) BackgroundImg *imgB;
@end
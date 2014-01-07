//
//  AnimationPauseViewController.h
//  AnimationPause
//
//  Created by gamy on 12-1-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface AnimationPauseViewController : UIViewController <UIAlertViewDelegate>
{
    
    UIButton *controlButton;
   //添加
    IBOutlet  UIImageView*        imgUp;
    IBOutlet  UIImageView*        imgDown;
     SystemSoundID                 soundID;
     IBOutlet UIActivityIndicatorView* aiLoad;
}
@property(nonatomic,retain) IBOutlet  UIImageView*        imgUp;
@property(nonatomic,retain) IBOutlet  UIImageView*        imgDown;

- (IBAction)clickControlButton:(id)sender;
@property (nonatomic, retain) IBOutlet UIButton *controlButton;
@property (nonatomic, retain) NSString *nowName;
@property (nonatomic, retain) NSString *nowString;
//@property (nonatomic, assign) BOOL isBusy;
//添加
- (void)addAnimations;





@end

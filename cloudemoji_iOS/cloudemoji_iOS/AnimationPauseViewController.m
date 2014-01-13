//
//  AnimationPauseViewController.m
//  AnimationPause
//
//  Created by gamy on 12-1-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnimationPauseViewController.h"


@implementation AnimationPauseViewController
@synthesize controlButton;
//添加
@synthesize imgUp;
@synthesize imgDown;
@synthesize nowName, nowString;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//添加
#pragma mark - 摇一摇动画效果
- (void)addAnimations
{
    
//    AudioServicesPlaySystemSound (soundID);
//    CGRect oldDown = imgDown.frame;
//    CGRect oldUp = imgUp.frame;
    float xwidth = imgUp.frame.size.width * 0.5;
    float xheight = imgUp.frame.size.height * 0.5;
    
    //让imgup上下移动
    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(xwidth, xheight + imgUp.frame.origin.y)];
    translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(xwidth, xheight + imgUp.frame.origin.y - xheight)];
    translation2.duration = 0.4;
    translation2.repeatCount = 1;
    translation2.autoreverses = YES;
    
    //让imagdown上下移动
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(xwidth, xheight + imgDown.frame.origin.y)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(xwidth, xheight + imgDown.frame.origin.y + xheight)];
    translation.duration = 0.4;
    translation.repeatCount = 1;
    translation.autoreverses = YES;
    
    [imgDown.layer addAnimation:translation forKey:@"translation"];
    [imgUp.layer addAnimation:translation2 forKey:@"translation2"];
    
    [self showR];
    
//    if (isBusy == NO) {
//        isBusy = YES;
//        CGRect oldDown = imgDown.frame;
//        CGRect oldUp = imgUp.frame;
//        [UIView animateWithDuration:1000 animations:^{
//            imgDown.frame = CGRectMake(imgDown.frame.origin.x, imgDown.frame.origin.y + 100, imgDown.frame.size.width, imgDown.frame.size.height);
//            imgUp.frame = CGRectMake(imgUp.frame.origin.x, imgUp.frame.origin.y - 100, imgUp.frame.size.width, imgUp.frame.size.height);
//        } completion:^(BOOL finished) {
//            [self showR];
//            [UIView animateWithDuration:1000 animations:^{
//                imgDown.frame = oldDown;
//                imgUp.frame = oldUp;
//            } completion:^(BOOL finished) {
//                isBusy = NO;
//            }];
//        }];
//    }
    
   
//    [aiLoad stopAnimating];
//    aiLoad.hidden=YES;
    
}

- (void)showR
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSMutableArray *sh = [NSMutableArray arrayWithArray:[S s].allinfo];
    NSArray *hisData = [setting objectForKey:@"diy"];
    [sh addObjectsFromArray:hisData];
    NSUInteger cou = [sh count];
    NSUInteger rdm = arc4random() % cou;
    NSArray *nowArr = [sh objectAtIndex:rdm];
    NSMutableString *nowGroup = [nowArr objectAtIndex:0];
    nowName = [nowArr objectAtIndex:1];
    nowString = [nowArr objectAtIndex:2];
    if ([nowGroup isEqualToString:@"<USER>"]) {
        [nowGroup setString:NSLocalizedString(@"User-defined", nil)];
    }
    NSMutableString *name = [NSMutableString stringWithString:nowName];
    if ([nowName isEqualToString:@""]) {
        [name setString:nowString];
    }
    NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"RandomText_message", nil),name,nowGroup,nowString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"RandomText_title", nil) message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"RandomText_btn1", nil), nil];
    [MobClick event:@"random"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSNumber *num = [NSNumber numberWithInt:1];
        NSArray *arr = [NSArray arrayWithObjects:num,nowString, nil];
        [MobClick event:@"copy_random"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"alt" object:arr];
    }
}

//#pragma mark - 摇一摇
//
//
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if(motion==UIEventSubtypeMotionShake)
//    {
//        NSLog(@"shake begin ....");
//        aiLoad.hidden=NO;
//        [aiLoad startAnimating];
//    }
//}
//
//
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//
//
//    if(motion==UIEventSubtypeMotionShake)
//    {
//        
//    //添加
//    [self addAnimations];
//    //添加
//    AudioServicesPlaySystemSound (soundID);	
//        
//    }
//    
//    
//  
//
//}

//添加
//-(void)dealloc{
//    
//    [controlButton release];
//    [imgDown release];
//    [imgUp release];
//    [super dealloc];
//
//}


#pragma mark - View lifecycle
- (void)viewDidLoad
{  
   // aiLoad.hidden=YES;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"glass" ofType:@"wav"];
//	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    [super viewDidLoad];
    if ([S s].ios < 7.0) {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 92);
    }
//    isBusy = NO;
//    [panGestureRecognizer release];
	// Erase the view when recieving a notification named "shake" from the NSNotificationCenter object
	// The "shake" nofification is posted by the PaintingWindow object when user shakes the device
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimations) name:@"shake" object:nil];
    
}


- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickControlButton:(id)sender {

    //添加 
    [self addAnimations];
    //添加    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self addAnimations];
    }
}
//-(void)sound{
//
//    //添加
//    AudioServicesPlaySystemSound (soundID);
//    
//    
//    
//    NSTimer *addEnemyTimer;
//    addEnemyTimer=[NSTimer scheduledTimerWithTimeInterval:(2.0) target:self selector:@selector(sound) userInfo:nil repeats:NO]; 
//
//}


@end

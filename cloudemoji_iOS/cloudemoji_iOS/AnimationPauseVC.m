//
//  AnimationPauseVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "AnimationPauseVC.h"

@interface AnimationPauseVC ()

@end

@implementation AnimationPauseVC
@synthesize imgUp;
@synthesize imgDown;
@synthesize nowName, nowString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)addAnimations
{
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
    [S s].alertEnabled = NO;
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
    [S s].alertEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)load
{
//    if ([S s].ios < 7.0) {
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 92);
//    }
//    self.view.frame = [S s].viewFrame;
    float bh = self.view.frame.size.height * 0.5;
    imgUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Shake_01.png"]];
    imgUp.frame = CGRectMake(0, 0, self.view.frame.size.width, bh);
    [self.view addSubview:imgUp];
    imgDown = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Shake_02.png"]];
    imgDown.frame = CGRectMake(0, bh, self.view.frame.size.width, bh);
    [self.view addSubview:imgDown];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimations) name:@"shake" object:nil];
    [self ad];
}

- (void)ad
{
    ADView *ad = [[ADView alloc] initWithViewController:self ShowNow:YES FixHeight:NO];
    [self.view addSubview:ad];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self addAnimations];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

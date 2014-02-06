//
//  AnimationPause.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "AnimationPause.h"

@interface AnimationPause ()

@end

@implementation AnimationPause

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    /*
     if(UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad)
     {
     [[NSBundlemainBundle]loadNibNamed:@"OtherViewController-iPad"owner:selfoptions:nil];
     }
     else
     {
     [[NSBundlemainBundle]loadNibNamed:@"OtherViewController"owner:selfoptions:nil];
     }    
     
     }
     */
    self.vc = [[AnimationPauseVC alloc] init];
    [self.view addSubview:self.vc.view];
    //self.vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.vc.view removeFromSuperview];
    self.vc = nil;
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Game.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-5-28.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Game.h"
<<<<<<< HEAD
=======

>>>>>>> FETCH_HEAD
@interface Game ()

@end

@implementation Game

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

<<<<<<< HEAD
kROTATE

- (void)va
{
    self.vc = [[GameTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}
- (void)vd
{
    [self.vc.view removeFromSuperview];
    self.vc = nil;
=======
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
>>>>>>> FETCH_HEAD
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

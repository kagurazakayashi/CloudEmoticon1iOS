//
//  Search.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Search.h"

@interface Search ()

@end

@implementation Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

kROTATE

- (void)va
{
    self.vc = [[SearchTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}

- (void)vd
{
    [self.vc.view removeFromSuperview];
    self.vc = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

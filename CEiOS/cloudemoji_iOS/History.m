//
//  History.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "History.h"

@interface History ()

@end

@implementation History

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

kROTATE

- (void)va
{
    self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    self.vc = [[HistoryTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}

- (void)vd
{
    self.navigationItem.rightBarButtonItem = nil;
    self.rightbtn = nil;
    [self.vc.view removeFromSuperview];
    self.vc = nil;
}

- (void)rightbtn:(id)sender
{
    [self.vc rightbtn:self.rightbtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

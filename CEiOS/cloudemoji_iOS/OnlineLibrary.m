//
//  OnlineLibrary.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "OnlineLibrary.h"

@interface OnlineLibrary ()

@end

@implementation OnlineLibrary

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
    self.vc = [[OnlineLibraryTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    self.vc.delegate = self;
    self.leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftbtn:)];
    self.navigationItem.leftBarButtonItem = self.leftbtn;
    
    self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    
    [self.view addSubview:self.vc.view];
    
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}

- (void)vd
{
    self.title = NSLocalizedString(@"SoftwareName", nil);
    self.vc.delegate = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.leftbtn = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.rightbtn = nil;
    [self.vc.view removeFromSuperview];
    self.vc = nil;
}

- (void)rightbtn:(id)sender
{
    [self.vc rightbtn:self.rightbtn];
}
- (void)leftbtn:(id)sender
{
    [self.vc leftbtn:self.leftbtn];
}

- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    [self.delegate reloadData:URL ModeTag:mtag Local:local];
}

- (void)changeTitle:(NSString*)titleStr
{
    self.title = titleStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

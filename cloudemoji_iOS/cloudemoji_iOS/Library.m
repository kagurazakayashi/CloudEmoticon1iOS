//
//  Library.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Library.h"

@interface Library ()

@end

@implementation Library

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
    self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = self.rightbtn;
    
    self.vc = [[LibraryTVC alloc] init];
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, 30);
    self.vc.delegate = self;
    [self.view addSubview:self.vc.view];
    self.vc.view.frame = self.view.frame;
    [self.vc load];
}

- (void)vd
{
    self.vc.delegate = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.rightbtn = nil;
    [self.vc.view removeFromSuperview];
    self.vc = nil;
}

- (void)changeRightButton:(BOOL)isCloseBtn
{
    if (isCloseBtn) {
        self.navigationItem.rightBarButtonItem = nil;
        self.rightbtn = nil;
        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(rightbtn2:)];
        self.navigationItem.rightBarButtonItem = self.rightbtn;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
        self.rightbtn = nil;
        self.rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
        self.navigationItem.rightBarButtonItem = self.rightbtn;
    }
}

- (void)reloadData:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    [self.delegate reloadData:URL ModeTag:mtag Local:local];
}
    
- (void)showBlack:(BOOL)isBalck
{
    [self.delegate showBlack:isBalck];
}

- (void)rightbtn:(id)sender
{
    [self.vc rightbtn:self.rightbtn];
}

- (void)rightbtn2:(id)sender
{
    [S s].storeBusy = NO;
    [self.vc webView:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

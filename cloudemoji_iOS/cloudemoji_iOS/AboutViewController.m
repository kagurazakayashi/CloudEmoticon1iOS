//
//  AboutViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize web, rightbtn, url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)rightbtn:(id)sender
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *server = [setting stringForKey:@"server"];
    if ([server length] < 5) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    float dstitle = [S s].correct.width;
    float dsfoot = [S s].correct.height;
    rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightbtn;
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, dstitle, self.view.frame.size.width, self.view.frame.size.height - dstitle -dsfoot)];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *server = [setting stringForKey:@"server"];
    NSString *urlString = nil;
    if ([server length] < 5) {
        urlString = @"http://www.heartunlock.com/soft/cloud_emoticon/";
    } else {
        urlString = [NSString stringWithFormat:@"%@soft/cloud_emoticon/",server];
    }
    url = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem = nil;
    [web removeFromSuperview];
    rightbtn = nil;
    web = nil;
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

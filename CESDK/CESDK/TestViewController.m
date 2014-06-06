//
//  TestViewController.m
//  CESDK
//
//  Created by 神楽坂雅詩 on 14-2-13.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "TestViewController.h"
#import "EmoticonImport.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 20)];
    txt.text = @"test";
    txt.backgroundColor = [UIColor whiteColor];
    EmoticonImport *cloudEmoticon = [[EmoticonImport alloc] initWithTextView:txt];
    cloudEmoticon.enable = YES;
    //[cloudEmoticon autorelease];
    [self.view addSubview:txt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

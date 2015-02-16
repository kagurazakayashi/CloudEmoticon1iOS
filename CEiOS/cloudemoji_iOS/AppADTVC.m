//
//  AppADTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-25.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "AppADTVC.h"

@interface AppADTVC ()

@end

@implementation AppADTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    float dstitle = [S s].correct.width;
    float dsfoot = [S s].correct.height;
    //    _mTableView = [[UMUFPTableView alloc] initWithFrame:CGRectMake(0, 44, 320, 460-44) style:UITableViewStylePlain appkey:@"52cba0fc56240be2220355c9" slotId:nil currentViewController:self];
    //    _mTableView.delegate = self;
    //    _mTableView.dataSource = self;
    //    _mTableView.dataLoadDelegate = self;
    //    [self.view addSubview:_mTableView];
    //    [_mTableView requestPromoterDataInBackground];
    //_mWebView = [[UMUFPWebView alloc] initWithFrame: appKey: slotId:nil currentViewController:self];
    _mWebView = [[UMUFPWebView alloc] initWithFrame:CGRectMake(0, dstitle, self.view.frame.size.width, self.view.frame.size.height - dstitle -dsfoot) appKey:@"52cba0fc56240be2220355c9" slotId:nil];
    //_mWebView.dataLoadDelegate = (id<UMWebViewDataLoadDelegate>)self;
    [self.view addSubview:_mWebView];
    [_mWebView startLoadRequest];
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mWebView removeFromSuperview];
    _mWebView = nil;
    [super viewWillDisappear:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
////获取后
//- (void)UMUFPTableViewDidLoadDataFinish:(UMUFPTableView *)tableview promoters:(NSArray *)promoters
//{
//    
//}
////失败后
//- (void)UMUFPTableView:(UMUFPTableView *)tableview didLoadDataFailWithError:(NSError *)error
//{
//    
//}
////点击跳转
//- (void)UMUFPTableView:(UMUFPTableView *)tableview didClickPromoterForUrl:(NSURL *)url
//{
//    
//}
////列表被点击
//- (void)UMUFPTableView:(UMUFPTableView *)tableview didClickedPromoterAtIndex:(NSInteger)promoterIndex
//{
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

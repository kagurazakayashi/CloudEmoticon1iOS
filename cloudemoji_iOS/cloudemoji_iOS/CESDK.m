//
//  ceSDK.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-2-23.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "CESDK.h"
#import "PasteboardController.h"

@implementation CESDK
- (void)toSDKwithAPPURLstr:(NSString*)urlstr
{
    NSMutableDictionary *webitem = [self data_webitem];
    if ([webitem count] > 0) {
        NSArray *favitem = [self data_favitem];
        NSString *favkey = [NSString stringWithFormat:@"e<!#cedata#!>fav"];
        //NSArray *hisitem = [self data_hisitem];
        //NSString *hiskey = [NSString stringWithFormat:@"e<!#cedata#!>his"];
        NSArray *diyitem = [self data_diyitem];
        NSString *diykey = [NSString stringWithFormat:@"e<!#cedata#!>diy"];
        
        if (favitem) [webitem setObject:favitem forKey:favkey];
        //if (hisitem) [webitem setObject:hisitem forKey:hiskey];
        if (diyitem) [webitem setObject:diyitem forKey:diykey];
        
        id oldPase = [PasteboardController readString];
        NSString *oldPaseStr = nil;
        if (oldPase && [oldPase isKindOfClass:[NSString class]]) {
            oldPaseStr = (NSString*)oldPase;
        }
        
        NSArray *pArr = [NSArray arrayWithObjects:webitem, oldPase, nil];
        [PasteboardController whiteArray:pArr];
        
        NSString *launchURL = [NSString stringWithFormat:@"%@:cloudemoticonsdk",urlstr];
        NSURL *urlToOpen = [NSURL URLWithString:launchURL];
        if ([[UIApplication sharedApplication] canOpenURL:urlToOpen]) {
            [MobClick event:@"sendToSDK"];
            [[UIApplication sharedApplication] openURL:urlToOpen];
        } else {
            [MobClick event:@"sendToSDKfail"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SdkUseErrTitle", nil) message:NSLocalizedString(@"SdkUseErrInfo", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles: nil];
            [alert show];
        }
    } else {
        [MobClick event:@"noDataToSDK"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SdkNoDataTitle", nil) message:NSLocalizedString(@"SdkNoDataInfo", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}
- (NSArray*)data_hisitem
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [setting objectForKey:@"his"];
    if ([userdata count] == 0) {
        return nil;
    }
    NSMutableArray *tmpp = [[NSMutableArray alloc] init];
    for (long i = [userdata count] - 1; i >= 0; i--) {
        [tmpp addObject:[[userdata objectAtIndex:i] objectAtIndex:2]];
    }
    return [NSArray arrayWithArray:tmpp];
}
- (NSArray*)data_favitem
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [setting objectForKey:@"fav"];
    if ([userdata count] == 0) {
        return nil;
    }
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSArray *nowArr in userdata) {
        NSString *nowitem = [nowArr objectAtIndex:2];
        [dataArr addObject:nowitem];
    }
    return [NSArray arrayWithArray:dataArr];
}
- (NSArray*)data_diyitem
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [setting objectForKey:@"diy"];
    if ([userdata count] == 0) {
        return nil;
    }
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSArray *nowArr in userdata) {
        NSString *nowitem = [nowArr objectAtIndex:2];
        [dataArr addObject:nowitem];
    }
    return [NSArray arrayWithArray:dataArr];
}
- (NSMutableDictionary*)data_webitem
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSMutableString *oldgroup = [NSMutableString string];
    NSMutableArray *newitem = [NSMutableArray array];
    int ir = [[S s].allinfo count];
    for (int i = 0; i <= ir; i++) {
        if (i < ir) {
            NSArray *nowitem = [[S s].allinfo objectAtIndex:i];
            NSString *nowgroup = [nowitem objectAtIndex:0];
            if (![oldgroup isEqualToString:nowgroup]) {
                if ([newitem count] > 0) {
                    NSString *addkey = [NSString stringWithFormat:@"c<!#cedata#!>%@",oldgroup];
                    [dataDic setObject:[NSArray arrayWithArray:newitem] forKey:addkey];
                    [newitem removeAllObjects];
                }
                [oldgroup setString:nowgroup];
            }
            [newitem addObject:[nowitem objectAtIndex:2]];
        } else if ([newitem count] > 0) {
            [dataDic setObject:[NSArray arrayWithArray:newitem] forKey:oldgroup];
            [newitem removeAllObjects];
        }
    }
    return dataDic;
}
@end
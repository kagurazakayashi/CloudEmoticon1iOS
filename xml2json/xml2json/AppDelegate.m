//
//  AppDelegate.m
//  xml2json
//
//  Created by 神楽坂雅詩 on 14-3-22.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.txtCmd.string = self.window.title;
    [self addCmdInfo:@"程序启动……"];
    [_window setDelegate:self];
    [self.btnStop setEnabled:NO];
    self.lblInfo.stringValue = @"就绪。";
//    _dataArr = [[NSMutableArray alloc] init];
//    _dataDic = [[NSMutableDictionary alloc] init];
    _jx = [[jsonxml alloc] init];
    _jx.delegate = self;
    [self addCmdInfo:@"程序启动完成。"];
}
- (void)error:(NSString*)errinfo
{
    [self addCmdInfo:[NSString stringWithFormat:@"错误：%@",errinfo]];
}
- (void)addCmdInfo:(NSString*)txt
{
    self.txtCmd.string = [NSString stringWithFormat:@"%@\n%@%@",self.txtCmd.string,[self nowTime],txt];
}
- (BOOL)loadSet
{
    BOOL isOK = YES;
    if (self.btnMode.selectedSegment == 0) {
        [self addCmdInfo:@"模式：XML转JSON。"];
        _jx.mode = NO;
    } else {
        [self addCmdInfo:@"对不起，暂时不支持JSON转XML。"];//模式：JSON转XML。
        _jx.mode = YES;
        isOK = NO;
    }
    if (self.btnType.selectedSegment == 0) {
        [self addCmdInfo:@"根数据类型：字典。"];
        _jx.type = NO;
    } else {
        [self addCmdInfo:@"对不起，暂时不支持数组作为根数据类型。"];//根数据类型：数组。
        _jx.type = YES;
        isOK = NO;
    }
    if (isOK) {
        [self addCmdInfo:@"开始进行转换……"];
    }
    return isOK;
}
- (void)xml2json
{
    NSDictionary *dic = [_jx xml2dic:self.txtFrom.string];
    if (dic) {
        NSString *str = [_jx dic2json:dic];
        if (str) {
            if (self.autoDelete.state) {
                str = [_jx removeAllReturnTable:str];
            }
            if (self.autoEdit.state) {
                str = [_jx removeRedundancyReturnTable:str];
            }
            self.txtTo.string = str;
            [self calc:str];
            [self isOK:YES];
        } else {
            [self isOK:NO];
        }
    } else {
        [self isOK:NO];
    }
}
- (void)calc:(NSString*)str
{
    NSUInteger enter = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        if ([nowChar isEqualToString:@"\n"]) {
            enter++;
        }
    }
    self.lblInfo.stringValue = [NSString stringWithFormat:@"字符数：%lu，行数：%lu",(unsigned long)[str length],(unsigned long)enter];
}
- (void)json2xml
{
    
}
- (void)isOK:(BOOL)ok
{
    [self.btnStop setEnabled:YES];
    if (ok) {
        [self addCmdInfo:@"成功：操作成功完成。"];
    } else {
        [self addCmdInfo:@"中止：操作未能成功完成。"];
    }
}
- (NSString*)nowTime
{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"[YYYY-MM-dd hh:mm:ss] "];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

- (BOOL)windowShouldClose:(id)sender
{
    exit(0);
    return YES;
}
- (IBAction)btnType:(id)sender {
}
- (IBAction)btnMode:(id)sender {
}
- (IBAction)lblInfo:(id)sender {
}
- (IBAction)btnOpenFile:(id)sender {
}
- (IBAction)btnStart:(id)sender {
    if ([self loadSet]) {
        if (_jx.mode) {
            [self json2xml];
        } else {
            [self xml2json];
        }
    }
}
- (IBAction)btnStop:(id)sender {
    self.txtTo.string = @"";
    self.txtCmd.string = @"";
    self.lblInfo.stringValue = @"就绪。";
    [self.btnStop setEnabled:NO];
}

@end

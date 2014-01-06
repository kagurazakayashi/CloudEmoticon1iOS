//
//  RefreshView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-30.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "RefreshView.h"
#import "XMLReader.h"
#import "MD5.h"
#import "S.h"
@implementation RefreshView
@synthesize info, connData, mode, cURL, mURL, loc;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self didLoad];
    }
    return self;
}

- (void)didLoad
{
    self.connData = [[NSMutableData alloc] init];
    float icoSize = self.frame.size.width * 0.5;
    UIImageView *logoimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-icoSize*0.5, self.frame.size.height*0.2, icoSize, icoSize)];
    logoimg.image = [UIImage imageNamed:@"ic_launcher-152.png"];
    info = [[UILabel alloc] initWithFrame:CGRectMake(0, logoimg.frame.origin.y + logoimg.frame.size.height, self.frame.size.width, 20)];
    [self infoShow:@"正在准备更新源，请稍候..."];
    info.textColor = [UIColor blueColor];
    info.textAlignment = NSTextAlignmentCenter;
    [self addSubview:logoimg];
    [self addSubview:info];
}

- (void)startreload:(NSString*)URL ModeTag:(NSUInteger)mtag Local:(BOOL)local
{
    mode = mtag;
    cURL = URL;
    mURL = [NSString stringWithFormat:@"%@.yashi",[MD5 md5:URL]];
    loc = local;
    
    if (local) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
        NSString *path = [documentDirectory stringByAppendingPathComponent:mURL];
        if ([fileManager fileExistsAtPath:path]) {
            [self infoShow:@"正在读取本地缓存..."];
            self.connData = [NSData dataWithContentsOfFile:path];
            [self connectionDidFinishLoading:nil];
        } else {
            [self startAsyConnection];
        }
    } else {
        [self startAsyConnection];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self infoShow:@"重试。"];
        [self startAsyConnection];
    } else {
        [self infoShow:@"取消操作。"];
        //NSArray *cinf = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:mode],cURL, nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"conok" object:cinf];
        [self exit];
    }
}
- (void)startAsyConnection
{
    [self infoShow:@"正在等待服务器响应..."];
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:cURL];
    //第二步：创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    //第三步：发送请求
    [NSURLConnection connectionWithRequest:request delegate:self];
    //接收到服务器回应
}
//服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveReceiveResponse:(NSURLResponse *)response
{
    [self infoShow:@"正在下载数据"];
    self.connData = [[NSMutableData alloc] init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self infoShow:[NSString stringWithFormat:@"%@.",info.text]];
    [self.connData appendData:data];
}
//接收过程中出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *inf = [NSString stringWithFormat:@"未能成功下载数据。请确认现在有足够的网速或请求数据源是否配置正确。\n%@",[error localizedDescription]];
    [self infoShow:inf];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载失败" message:inf delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
    [alert show];
}
- (void)dataErr:(NSString*)errinfo
{
    NSString *inf = [NSString stringWithFormat:@"由于源地址设置或目标服务器配置不正确，收到了无效的数据。%@",errinfo];
    [self infoShow:inf];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"数据解析失败" message:inf delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alert show];
}
//成功接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self infoShow:[NSString stringWithFormat:@"数据接收成功(数据量%d)",[self.connData length]]];
    NSString *str = [[NSString alloc] initWithData:self.connData encoding:NSUTF8StringEncoding];
    [self infoShow:[NSString stringWithFormat:@"正在格式化数据(资源量%d)",[str length]]];
    NSDictionary *okdata = nil;
    
    [self infoShow:@"正在尝试使用XML解析数据..."];
    //将字符串xml转为字典
    NSError *xmlerr = nil;
    NSDictionary *dic = [XMLReader dictionaryForXMLString:str error:&xmlerr];
    if (xmlerr) {
        [self infoShow:[NSString stringWithFormat:@"尝试使用XML解析数据失败。%@",[xmlerr localizedDescription]]];
        [self infoShow:@"正在尝试使用JSON解析数据..."];
        //将json的Data转为字典
        NSError *jsonerr = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:self.connData options:NSJSONReadingMutableContainers error:&jsonerr];
        if (jsonerr) {
            [self infoShow:[NSString stringWithFormat:@"尝试使用JSON解析数据失败。%@",[jsonerr localizedDescription]]];
            [self dataErr:[NSString stringWithFormat:@"%@。%@。",[xmlerr localizedDescription],[jsonerr localizedDescription]]];
        } else {
            okdata = jsonDic;
        }
    } else {
        okdata = dic;
    }
    if ([okdata count] > 0) {
        [self readData:okdata];
    } else {
        [self dataErr:@"内部解析错误"];
    }
}



- (void)readData:(NSDictionary*)dataDic
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentDirectory stringByAppendingPathComponent:mURL];
    if ([fileManager fileExistsAtPath:path] && loc) {
        
    } else {
        [self infoShow:@"正在保存本地缓存..."];
        NSMutableData  *writer = [[NSMutableData alloc] init];
        [writer appendData:self.connData];
        [writer writeToFile:path atomically:YES];
    }
    [self infoShow:@"正在处理数据..."];
    NSArray *cinf = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:mode],cURL,dataDic, nil];
    
    if (([cinf count] > 2) && ([[cinf objectAtIndex:0] unsignedIntegerValue] == 1))
    {
        [[S s].allinfo removeAllObjects];
        //NSString *cURL = [cinf objectAtIndex:1];
        NSDictionary *info = [cinf objectAtIndex:2];
        NSDictionary *emoji = [info objectForKey:@"emoji"];
        NSArray *category = [emoji objectForKey:@"category"];
        
        //NSLog(@"category(%d)=%@",[category count], category);
        for (int icate = 0; icate < [category count]; icate++) {
            NSDictionary *cate = [category objectAtIndex:icate];
            NSString *name = [cate objectForKey:@"name"];
            NSArray *entry = [cate objectForKey:@"entry"];
            
            for (int iitem = 0; iitem < [entry count]; iitem++) {
                NSDictionary *item = [entry objectAtIndex:iitem];
                NSString *string = [[item objectForKey:@"string"] objectForKey:@"text"];
                NSString *nameT = [self removeFirstReturn:name removeT:YES];
                NSString *stringT = [self removeFirstReturn:string removeT:NO];
                if ([item count] == 3) {
                    NSString *note = [[item objectForKey:@"note"] objectForKey:@"text"];
                    NSString *noteT = [self removeFirstReturn:note removeT:YES];
                    NSArray *l = [NSArray arrayWithObjects:nameT,noteT,stringT, nil];
                    [[S s].allinfo addObject:l];
                } else {
                    NSArray *l = [NSArray arrayWithObjects:nameT,@"",stringT, nil];
                    [[S s].allinfo addObject:l];
                }
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"conok" object:nil];
    [self exit];
}
- (NSString*)removeFirstReturn:(NSString*)str removeT:(BOOL)rT
{
    //NSMutableString *oldChar = [NSMutableString string];
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        BOOL okey = YES;
        if ([nowChar isEqualToString:@"\n"]) {
            okey = NO;
        }
        if ([nowChar isEqualToString:@"\t"] && rT) {
            okey = NO;
        }
        if (okey) {
            return [str substringFromIndex:i];
        }
        //[oldChar setString:nowChar];
    }
    return @"";
}
- (void)exit
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)infoShow:(NSString*)txt
{
    NSLog(@"[网络]%@",txt);
    info.text = txt;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

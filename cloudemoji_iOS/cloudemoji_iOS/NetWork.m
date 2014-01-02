//
//  NetWork.m
//  OC20120808A_FileNetwork
//
//  Created by Terence Chen on 12-8-8.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "NetWork.h"
#import "XMLReader.h"
@implementation NetWork 
- (void)startConnection
{
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:@""];
    //第二步：创建请求
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //第三步：发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}
- (void)startAsyConnection
{
    //第一步：创建URL
    NSURL *url = [NSURL URLWithString:@""];
    //第二步：创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //第三步：发送请求
    [NSURLConnection connectionWithRequest:request delegate:self];
    //接收到服务器回应
}
//服务器响应
- (void)connection:(NSURLConnection *)connection didReceiveReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"服务器响应");
    self.connData = [[NSMutableData alloc] init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收数据");
    [self.connData appendData:data];
}
//接收过程中出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"出现错误 %@",[error localizedDescription]);
}
//成功接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"成功接收");
    NSString *str = [[NSString alloc] initWithData:self.connData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    
    //将字符串xml转为字典
    NSDictionary *dic = [XMLReader dictionaryForXMLString:str error:nil];
    NSLog(@"%@",dic);
    NSString *resultStr = [[[[[[dic valueForKey:@"response"] valueForKey:@"docList"] valueForKey:@"docInfo"] objectAtIndex:1] valueForKey:@"docImg"] valueForKey:@"text"];
    NSLog(@"找到的 %@",resultStr);
    //使用JSON
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    //将json的Data转为字典
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",jsonDic);
}
@end

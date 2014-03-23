//
//  jsonxml.m
//  xml2json
//
//  Created by 神楽坂雅詩 on 14-3-22.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "jsonxml.h"
#import "XMLReader.h"
@implementation jsonxml
@synthesize mode=_mode, type=_type;
- (NSDictionary*)xml2dic:(NSString*)txt
{
    NSDictionary *data = nil;
    NSError *err = nil;
    data = [XMLReader dictionaryForXMLString:txt error:&err];
    if (err) {
        [self.delegate error:[err localizedDescription]];
        return nil;
    }
    return data;
}
- (NSString*)dic2json:(NSDictionary*)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (error) {
            [self.delegate error:[error localizedDescription]];
            return nil;
        }
        return json;
    }
    return nil;
}
- (NSString*)removeFirstReturnTable:(NSString*)str
{
    //    NSLog(@"str=%@",str);
    NSMutableString *oldChar = [NSMutableString string];
    int n = 3;
    int n0 = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        if ([nowChar isEqualToString:@"\n"]) {
            n0++;
        }
    }
    if (n0 > 3) {
        n--;
    }
    for (int i = 0; i < [str length]; i++) {
        NSString *nowChar = [str substringWithRange:NSMakeRange(i, 1)];
        BOOL okey = YES;
        if ([nowChar isEqualToString:@"\n"] && n > 0) {
            okey = NO;
            [oldChar setString:nowChar];
            n--;
        }
        if ([nowChar isEqualToString:@"\t"]) {
            okey = NO;
            [oldChar setString:nowChar];
        }
        if ([nowChar isEqualToString:@"	"]) {
            okey = NO;
            [oldChar setString:nowChar];
        }
        if (okey) {
            NSMutableString *rstr = [NSMutableString stringWithString:[str substringFromIndex:i]];
            return rstr;
        }
    }
    return @"";
}

- (NSString*)removeAllReturnTable:(NSString*)str
{
    //NSString *str0 = [self removeRedundancyReturnTable:str];
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str2;
}
- (NSString*)removeRedundancyReturnTable:(NSString*)str
{
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return str3;
}
@end

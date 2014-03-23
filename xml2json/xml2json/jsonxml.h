//
//  jsonxml.h
//  xml2json
//
//  Created by 神楽坂雅詩 on 14-3-22.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol jsonxmlDelegate <NSObject>
- (void)error:(NSString*)errinfo;
@end
@interface jsonxml : NSObject
{
    BOOL _mode;
    BOOL _type;
}
@property (nonatomic,assign) id<jsonxmlDelegate> delegate;
@property (nonatomic, assign) BOOL mode;
@property (nonatomic, assign) BOOL type;
- (NSDictionary*)xml2dic:(NSString*)txt;
- (NSString*)dic2json:(NSDictionary*)dic;
- (NSString*)removeRedundancyReturnTable:(NSString*)str;
- (NSString*)removeFirstReturnTable:(NSString*)str;
- (NSString*)removeAllReturnTable:(NSString*)str;
@end
//
//  MD5.m
//
//  Created by 陈霄驰 on 12-10-5.
//  Copyright (c) 2012年 陈霄驰. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

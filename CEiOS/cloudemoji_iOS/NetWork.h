//
//  NetWork.h
//  OC20120808A_FileNetwork
//
//  Created by Terence Chen on 12-8-8.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject <NSURLConnectionDelegate>
@property (nonatomic ,retain)NSMutableData *connData;
- (void)startConnection;
- (void)startAsyConnection;
@end

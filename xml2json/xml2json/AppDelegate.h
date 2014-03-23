//
//  AppDelegate.h
//  xml2json
//
//  Created by 神楽坂雅詩 on 14-3-22.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "jsonxml.h"
@interface AppDelegate : NSObject <NSApplicationDelegate,NSWindowDelegate,jsonxmlDelegate>
{
//    NSMutableDictionary *_dataDic;
//    NSMutableArray *_dataArr;
    jsonxml *_jx;
}
@property (weak) IBOutlet NSButton *btnStop;
@property (weak) IBOutlet NSSegmentedControl *btnType;
//@property (weak) IBOutlet NSScrollView *txtCmd;
//@property (weak) IBOutlet NSScrollView *txtTo;
//@property (weak) IBOutlet NSScrollView *txtFrom;
@property (unsafe_unretained) IBOutlet NSTextView *txtCmd;
@property (unsafe_unretained) IBOutlet NSTextView *txtTo;
@property (unsafe_unretained) IBOutlet NSTextView *txtFrom;

@property (weak) IBOutlet NSTextField *lblInfo;
@property (weak) IBOutlet NSSegmentedControl *btnMode;
@property (weak) IBOutlet NSButton *btnOpenFile;
@property (weak) IBOutlet NSButton *autoDelete;
@property (weak) IBOutlet NSButton *autoEdit;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *btnStart;

@end

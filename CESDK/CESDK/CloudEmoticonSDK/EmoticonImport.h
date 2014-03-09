//
//  EmoticonImport.h
//  CESDK
//
//  Created by 神楽坂雅詩 on 14-2-13.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmoticonImport : UIView <UITableViewDataSource,UITableViewDelegate>
{
    BOOL _enable;
    BOOL _server;
    BOOL _fav;
    BOOL _diy;
    UITableView *_tbA;
    NSMutableArray *_arrA;
    UITableView *_tbB;
    NSMutableArray *_arrB;
    NSDictionary *_dataDic;
    id<UITextInput> _tv;
}
- (id)initWithTextView:(id<UITextInput>)textView;
- (id)initWithURLscheme:(NSURL*)url;
@property (strong) id<UITextInput> tv;
@property (nonatomic,assign) BOOL enable;
@end

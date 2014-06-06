//
//  EmoticonImport.m
//  CESDK
//
//  Created by 神楽坂雅詩 on 14-2-13.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//⌨☺︎

#import "EmoticonImport.h"

@implementation EmoticonImport
@synthesize tv = _tv, enable = _enable;

- (NSDictionary*)defaultData
{
    return [NSDictionary dictionary];
}

- (id)initWithTextView:(id<UITextInput>)textView {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	CGRect frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(UIDeviceOrientationIsLandscape(orientation))
            frame = CGRectMake(0, 0, 1024, 352);
        else
            frame = CGRectMake(0, 0, 768, 264);
    } else {
        if(UIDeviceOrientationIsLandscape(orientation))
            frame = CGRectMake(0, 0, 480, 162);
        else
            frame = CGRectMake(0, 0, 320, 216);
    }
    self = [super initWithFrame:frame];
    if (self) {
        _server = NO;
        _arrA = [NSMutableArray array];
        _arrB = [NSMutableArray array];
        _tv = textView;
        
        [self ui];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"cloudemoticonsdk-loaddata" object:nil];
    }
    return self;
}
- (void)loadData:(NSNotification*)notification
{
    if (notification) {
        _dataDic = notification.object;
    } else {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"%@/CloudEmoticonSDK.cache",documentDirectory];
        if ([manager fileExistsAtPath:path]) {
            NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
            _dataDic = dic;
        } else {
            _dataDic = [self defaultData];
        }
    }
    [_arrA removeAllObjects];
    NSMutableArray *groupI = [NSMutableArray array];
//    NSString *favGroup = nil;
//    NSString *diyGroup = nil;
    _fav = NO;
    _diy = NO;
    for (NSString *nowKey in [_dataDic allKeys]) {
        NSArray *mode = [nowKey componentsSeparatedByString:@"<!#cedata#!>"];
        NSLog(@"mode=%@",mode);
        if ([[mode objectAtIndex:0] isEqualToString:@"e"]) {
            if ([[mode objectAtIndex:1] isEqualToString:@"fav"]) {
                _fav = YES;
            } else if ([[mode objectAtIndex:1] isEqualToString:@"diy"]) {
                _diy = YES;
            }
        } else if ([[mode objectAtIndex:0] isEqualToString:@"c"]) {
            [groupI addObject:[mode objectAtIndex:1]];
        }
    }
    if (_fav) [_arrA addObject:@"收藏夹"];
    if (_diy) [_arrA addObject:@"自定义"];
    [_arrA addObjectsFromArray:groupI];
    [_arrB removeAllObjects];
    if (_fav) {
        [_arrB addObjectsFromArray:[_dataDic objectForKey:@"e<!#cedata#!>fav"]];
    } else if (_diy) {
        [_arrB addObjectsFromArray:[_dataDic objectForKey:@"e<!#cedata#!>diy"]];
    } else {
        [_arrB addObjectsFromArray:[_dataDic objectForKey:[_arrA objectAtIndex:0]]];
    }
    [self reloadData];
}
- (void)reloadData
{
    [_tbA reloadData];
    [_tbB reloadData];
}
- (void)close
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_tbA removeFromSuperview];
    _tbA = nil;
    [_tbB removeFromSuperview];
    _tbB = nil;
    _dataDic = nil;
}
- (id)initWithURLscheme:(NSURL*)url
{
    self = [super init];
    if (self) {
        _server = YES;
        NSString *urlStr=[url absoluteString];
        NSArray *info = [urlStr componentsSeparatedByString:@":"];
        if ([info count] >= 2 && [[info objectAtIndex:1] isEqualToString:@"cloudemoticonsdk"]) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            NSData *jsonData = [pasteboard.string dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
            NSMutableDictionary *dataDic = [arr objectAtIndex:0];
            if ([arr count] >= 2) {
                NSString *oldPaseStr = [arr objectAtIndex:1];
                [pasteboard setString:oldPaseStr];
            } else {
                [pasteboard setString:@""];
            }
            NSFileManager *manager = [NSFileManager defaultManager];
            NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path = [NSString stringWithFormat:@"%@/CloudEmoticonSDK.cache",documentDirectory];
            if ([manager fileExistsAtPath:path]) {
                [manager removeItemAtPath:path error:nil];
            }
            [dataDic writeToFile:path atomically:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cloudemoticonsdk-loaddata" object:dataDic];
        }
    }
    return self;
}
- (void)setTextView:(id<UITextInput>)textView
{
	if ([textView isKindOfClass:[UITextView class]])
        [(UITextView *)textView setInputView:self];
    else if ([textView isKindOfClass:[UITextField class]])
        [(UITextField *)textView setInputView:self];
}
-(void)delTextView:(id<UITextInput>)textView
{
	if ([textView isKindOfClass:[UITextView class]])
        [(UITextView *)textView setInputView:nil];
    else if ([textView isKindOfClass:[UITextField class]])
        [(UITextField *)textView setInputView:nil];
}
-(id<UITextInput>)textView
{
	return _tv;
}
- (void)setEnable:(BOOL)enable
{
    if (enable) {
        [self setTextView:_tv];
    } else {
        [self delTextView:_tv];
    }
    _enable = enable;
}
- (BOOL)enableInputClicksWhenVisible {
    return YES;
}
- (void)deletePressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.textView deleteBackward];
	[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}
- (void)ui
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.frame.size.width - 120, 40)];
    title.backgroundColor = [UIColor whiteColor];
    title.textColor = [UIColor colorWithRed:97.0f/255.0f green:198.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    self.backgroundColor = title.textColor;
    title.font = [UIFont systemFontOfSize:15.0f];
    title.text = @"( っ*'ω'*c) Cloud Emoticon";
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, title.frame.size.height, title.frame.size.height);
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setTitleColor:title.textColor forState:UIControlStateNormal];
    [leftBtn setTitle:@"🔄" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:leftBtn];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.frame.size.width - title.frame.size.height, 0, title.frame.size.height, title.frame.size.height);
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitleColor:title.textColor forState:UIControlStateNormal];
    [rightBtn setTitle:@"🔽" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:rightBtn];
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(self.frame.size.width - title.frame.size.height * 2, 0, title.frame.size.height, title.frame.size.height);
    rightBtn2.backgroundColor = [UIColor whiteColor];
    [rightBtn2 setTitleColor:title.textColor forState:UIControlStateNormal];
    [rightBtn2 setTitle:@"◀️" forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(rightBtn2:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:rightBtn2];
    _tbA = [[UITableView alloc] initWithFrame:CGRectMake(0, title.frame.size.height + 0.5, self.frame.size.width * 0.4, self.frame.size.height - title.frame.size.height - 0.5) style:UITableViewStylePlain];
    _tbA.delegate = self;
    _tbA.dataSource = self;
    [self addSubview:_tbA];
    _tbB = [[UITableView alloc] initWithFrame:CGRectMake(_tbA.frame.size.width, _tbA.frame.origin.y, self.frame.size.width - _tbA.frame.size.width, _tbA.frame.size.height) style:UITableViewStylePlain];
    _tbB.delegate = self;
    _tbB.dataSource = self;
    [self addSubview:_tbB];
}
- (void)leftBtn:(id)sender
{
    NSString *launchURL = @"cloudemoticon:sdk:cloudemoticonsdk";
    //cloudemoticon://dl.dropboxusercontent.com/s/w85noarzzeabgr7/emoji.xml
    //cloudemoticon:sdk:cloudemoticonsdk
    NSURL *urlToOpen = [NSURL URLWithString:launchURL];
    if ([[UIApplication sharedApplication] canOpenURL:urlToOpen]) {
        [[UIApplication sharedApplication] openURL:urlToOpen];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更多颜文字" message:@"这个按钮将从“云颜文字”应用中同步内容，请先从AppStore安装“云颜文字”以获得更多的颜文字。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
}
- (void)rightBtn:(id)sender
{
    [self dismissPressed];
}
- (void)rightBtn2:(id)sender
{
    [self deletePressed:nil];
}
- (void)dismissPressed {
    [[UIDevice currentDevice] playInputClick];
	if ([self.textView isKindOfClass:[UITextView class]])
        [(UITextView *)self.textView resignFirstResponder];
    else if ([self.textView isKindOfClass:[UITextField class]])
        [(UITextField *)self.textView resignFirstResponder];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == _tbA) {
        cell.textLabel.text = [_arrA objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_arrB objectAtIndex:indexPath.row];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbA) {
        return [_arrA count];
    } else {
        return [_arrB count];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbA) {
        NSMutableString *cellStr = [NSMutableString stringWithString:[_arrA objectAtIndex:indexPath.row]];
        enum cellMode {
            cellModeITEM = 0,
            cellModeFAV = 1,
            cellModeHIS = 2,
            cellModeDIY = 3
        };
        int cellMode0 = cellModeITEM;
        int cellMode1 = cellModeITEM;
        if (_fav && _diy) {
            cellMode0 = cellModeFAV;
            cellMode1 = cellModeDIY;
        } else {
            if (_fav) {
                cellMode0 = cellModeFAV;
            } else if (_diy) {
                cellMode0 = cellModeDIY;
            }
        }
        if (indexPath.row == 0) {
            if (cellMode0 == cellModeFAV) {
                [cellStr setString:@"e<!#cedata#!>fav"];
            } else if (cellMode0 == cellModeDIY) {
                [cellStr setString:@"e<!#cedata#!>diy"];
            } else {
                [cellStr setString:[NSString stringWithFormat:@"c<!#cedata#!>%@",cellStr]];
            }
        } else if (indexPath.row == 1) {
            if (cellMode1 == cellModeFAV) {
                [cellStr setString:@"e<!#cedata#!>fav"];
            } else if (cellMode1 == cellModeDIY) {
                [cellStr setString:@"e<!#cedata#!>diy"];
            } else {
                [cellStr setString:[NSString stringWithFormat:@"c<!#cedata#!>%@",cellStr]];
            }
        } else {
            [cellStr setString:[NSString stringWithFormat:@"c<!#cedata#!>%@",cellStr]];
        }
        NSArray *dataKeys = [_dataDic allKeys];
        for (int i = 0; i < [dataKeys count]; i++) {
            NSString *nowKey = [dataKeys objectAtIndex:i];
            if ([nowKey isEqualToString:cellStr]) {
                NSArray *nowValue = [_dataDic objectForKey:nowKey];
                [_arrB removeAllObjects];
                [_arrB addObjectsFromArray:nowValue];
            }
        }
        [_tbB reloadData];
    } else {
        NSString *nowEmo = [_arrB objectAtIndex:indexPath.row];
        if ([_tv isKindOfClass:[UITextView class]]) {
            UITextView *nv = (UITextView *)_tv;
            nv.text = [NSString stringWithFormat:@"%@%@",nv.text,nowEmo];
        } else if ([_tv isKindOfClass:[UITextField class]]) {
            UITextField *nv = (UITextField *)_tv;
            nv.text = [NSString stringWithFormat:@"%@%@",nv.text,nowEmo];
        }
    }
}
- (void)dealloc
{
    [self close];
    //[super dealloc];
}
@end

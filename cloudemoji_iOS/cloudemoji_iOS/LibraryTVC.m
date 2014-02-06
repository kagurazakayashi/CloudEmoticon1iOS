//
//  LibraryTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "LibraryTVC.h"
#import "BackgroundImg.h"

@interface LibraryTVC ()

@end

@implementation LibraryTVC
@synthesize data, height, alertMode, editNow, storeWeb, addStoreURL, weburl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] init];
    height = [[NSMutableArray alloc] init];
    alertMode = 0;
    editNow = 99999999;
    
    data = [[NSMutableArray alloc] init];
    height = [[NSMutableArray alloc] init];
    
    float dstitle = [S s].correct.width;
    float dsfoot = [S s].correct.height;
    float bgy = 0;
    if ([S s].ios < 7.0) {
        dstitle = 0;
        dsfoot = 134;
        bgy = 0 - dstitle - dsfoot + 40;
    } else {
        dstitle = 84;
        dsfoot = 69;
    }
    data = [[NSMutableArray alloc] init];
    height = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, dstitle - 20, self.view.frame.size.width, self.view.frame.size.height - dstitle - dsfoot + 40) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    BackgroundImg *bg = [[BackgroundImg alloc] init];
    [bg changeFrame:CGRectMake(0, bgy, self.view.frame.size.width, self.view.frame.size.height)];
    [bg loadSetting:1];
    [bg loadSettingImg:1];
    
    [self.view addSubview:bg];
    [self.view addSubview:self.tableView];
    
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(r:) name:@"r" object:nil];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSArray *userdata = [setting objectForKey:@"sourcelist"];
    if (userdata) {
        for (NSArray *nowArray in userdata) {
            [data addObject:nowArray];
        }
    }
    
//    rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
//    self.navigationItem.rightBarButtonItem = rightbtn;
    
    //NSArray *d1 = [NSArray arrayWithObjects:@"KTachibanaTest",@"http://dl.dropboxusercontent.com/u/120725807/test.xml",@"e", nil];
    NSArray *d2 = [NSArray arrayWithObjects:@"KT Current",@"http://dl.dropboxusercontent.com/u/73985358/Emoji/_KT_Current.xml",@"e", nil];
    [data insertObject:d2 atIndex:0];
//    [data insertObject:d1 atIndex:0];
    
    for (NSArray *nowArr in data) {
        NSString *nowUrl = [nowArr objectAtIndex:1];
        //CGSize strSize0=[nowUrl sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - kBK *4, 99999) lineBreakMode:NSLineBreakByWordWrapping];
        float txtheight = [S txtHeightWithText:nowUrl MaxWidth:self.tableView.frame.size.width];
        [height addObject:[NSNumber numberWithFloat:txtheight]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conok:) name:@"conok" object:nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(BOOL)isShow
{
    if (isShow) {
        [self.delegate changeRightButton:YES];
        storeWeb = [[UIWebView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, -self.tableView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSString *server = [setting stringForKey:@"server"];
        NSString *urlString = nil;
        if ([server length] < 5) {
            urlString = @"http://cxchope.sites.my-card.in/soft/cloud_emoticon/source/index.html";
        } else {
            urlString = [NSString stringWithFormat:@"%@soft/cloud_emoticon/source/index.html",server];
        }
        weburl = [NSURL URLWithString:urlString];
        
        NSURL *url =[NSURL URLWithString:urlString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        storeWeb.delegate = self;
        [storeWeb loadRequest:request];
        [self.view addSubview:storeWeb];
        [UIView animateWithDuration:0.5 animations:^{
            storeWeb.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        }];
    } else {
        [self.delegate changeRightButton:NO];
        [UIView animateWithDuration:0.5 animations:^{
            storeWeb.frame = CGRectMake(self.tableView.frame.origin.x, -self.tableView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            [storeWeb removeFromSuperview];
            storeWeb = nil;
        }];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL = [request URL];
    NSString *urltype = [requestURL scheme];
    NSString *allurl = [requestURL relativeString];
    BOOL showAddWebURLAlert = NO;
    if ([allurl isEqualToString:@"http://cxchope.sites.my-card.in/soft/cloud_emoticon/index.html"] || [allurl isEqualToString:@"http://www.heartunlock.com/soft/cloud_emoticon/index.html"]) {
        [self webView:NO];
        return NO;
    } else if ([urltype isEqualToString:@"cloudemoticon"]) {
        NSString *notypeurl = [allurl substringFromIndex:[urltype length]];
        addStoreURL = [NSString stringWithFormat:@"http%@",notypeurl];
        showAddWebURLAlert = YES;
    } else if ([urltype isEqualToString:@"cloudemoticons"]) {
        NSString *notypeurl = [allurl substringFromIndex:[urltype length]];
        addStoreURL = [NSString stringWithFormat:@"https%@",notypeurl];
        showAddWebURLAlert = YES;
    }
    if (showAddWebURLAlert) {
        BOOL isReq = NO;
        for (NSArray *nowItem in data) {
            NSString *nowURL = [nowItem objectAtIndex:1];
            if ([addStoreURL isEqualToString:nowURL]) {
                isReq = YES;
                break;
            }
        }
        if (isReq) {
            [self webView:NO];
        } else {
            [self addWebURL];
        }
    }
    
    return YES;
}

- (void)addWebURL
{
    alertMode = 4;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AddStoreURL_title", nil) message:[NSString stringWithFormat:NSLocalizedString(@"AddStoreURL_message", nil),addStoreURL] delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"AddSource_save", nil),nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LibraryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LibraryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell loadFrame:tableView.frame.size.width];
    }
    //刷新显示内容
    NSArray *nowcell = [data objectAtIndex:indexPath.row];
    cell.name.text = [nowcell objectAtIndex:0];
    cell.info.text = [nowcell objectAtIndex:1];
    cell.info.frame = CGRectMake(kBK * 2, kBK * 2 + 30, tableView.frame.size.width - kBK * 3, [[height objectAtIndex:indexPath.row] floatValue] + kBK * 0.5);
    cell.cellBGView.frame = CGRectMake(kBK, kBK * 1.5, tableView.frame.size.width - kBK * 2, cell.name.frame.origin.x + cell.name.frame.size.height + cell.info.frame.origin.x + cell.info.frame.size.height - kBK * 3);
    NSString *nowURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"nowURL"];
    if ([cell.info.text isEqualToString:nowURL]) {
        [cell.btnFrv setHidden:YES];
        cell.cellBGView.backgroundColor = [UIColor redColor];
        cell.cellBGView.layer.shadowColor = [[UIColor redColor] CGColor];
    } else {
        [cell.btnFrv setHidden:NO];
        cell.cellBGView.backgroundColor = [UIColor whiteColor];
        cell.cellBGView.layer.shadowColor = [[UIColor whiteColor] CGColor];
    }
    //[cell loadFrame:tableView.frame.size.width];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *nowrow = [height objectAtIndex:indexPath.row];
    return [nowrow floatValue] + kBK * 4 + 30;
}

- (void)changeAV:(NSString*)defaultURL;
{
    alertMode = 1;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AddSource_title", nil) message:NSLocalizedString(@"AddSource_message", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"AddSource_save", nil),nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alert textFieldAtIndex:0];
    if ([defaultURL length] > 0) {
        tf.text = defaultURL;
    } else {
        editNow = 99999999;
    }
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertMode == 1) { //输入网址
        UITextField *tf = [alertView textFieldAtIndex:0];
        if (buttonIndex == 1) {
            [self.delegate showBlack:YES];
            [self.delegate reloadData:tf.text ModeTag:2 Local:YES];
        } else {
            editNow = 99999999;
        }
    } else if (alertMode == 2 && buttonIndex == 1) {
        [data removeObjectAtIndex:editNow];
        editNow = 99999999;
        [self saveToSetting];
        [self.tableView reloadData];
    } else if (alertMode == 3) { //主菜单
        if (buttonIndex == 1) {
            [self webView:YES];
        } else if (buttonIndex == 2) {
            alertMode = 1;
            [self addURL];
        }
    } else if (alertMode == 4) {
        [self webView:NO];
        if (buttonIndex == 1) {
            [self.delegate showBlack:YES];
            [self.delegate reloadData:addStoreURL ModeTag:2 Local:YES];
        } else {
            editNow = 99999999;
        }
    }
}
-(void)btnSelect:(NSString*)name
{
    for (int i = 0; i < [data count]; i++) {
        NSArray *nowarr = [data objectAtIndex:i];
        NSString *nowURL = [nowarr objectAtIndex:1];
        if ([nowURL isEqualToString:name]) {
            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            [setting setObject:nowURL forKey:@"nowURL"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ReplacementSource_title", nil),[nowarr objectAtIndex:0]] message:[NSString stringWithFormat:NSLocalizedString(@"ReplacementSource_message", nil),nowURL] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
            break;
        }
    }
    [self.tableView reloadData];
}
-(void)btnEdit:(NSString*)name
{
    for (int i = 0; i < [data count]; i++) {
        NSArray *nowarr = [data objectAtIndex:i];
        NSString *nowURL = [nowarr objectAtIndex:1];
        if ([nowURL isEqualToString:name]) {
            NSString *tName = [nowarr objectAtIndex:0];
            if ([[nowarr objectAtIndex:2] isEqualToString:@"e"]) {
                [self sysOnly:tName];
            } else {
                editNow = i;
                [self changeAV:name];
            }
        }
    }
}
-(void)btnDelete:(NSString*)name
{
    for (int i = 0; i < [data count]; i++) {
        NSArray *nowarr = [data objectAtIndex:i];
        NSString *nowURL = [nowarr objectAtIndex:1];
        if ([nowURL isEqualToString:name]) {
            NSString *tName = [nowarr objectAtIndex:0];
            if ([[nowarr objectAtIndex:2] isEqualToString:@"e"]) {
                [self sysOnly:tName];
            } else {
                alertMode = 2;
                editNow = i;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DeleteSource_title", nil) message:[NSString stringWithFormat:NSLocalizedString(@"DeleteSource_message", nil),tName] delegate:self cancelButtonTitle:NSLocalizedString(@"DeleteSource_cancel", nil) otherButtonTitles:NSLocalizedString(@"DeleteSource_delete", nil),nil];
                [alert show];
            }
            break;
        }
    }
}
- (void)sysOnly:(NSString*)name
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ReadOnlySource_title", nil) message:[NSString stringWithFormat:NSLocalizedString(@"ReadOnlySource_message", nil),name] delegate:nil cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:nil];
    [alert show];
}
- (void)conok:(NSNotification*)notification
{
    NSArray *cinf = [notification object];
    if (([cinf count] > 2) && ([[cinf objectAtIndex:0] unsignedIntegerValue] == 2)) {
        NSString *cURL = [cinf objectAtIndex:1];
        NSDictionary *info = [cinf objectAtIndex:2];
        NSDictionary *emoji = [info objectForKey:@"emoji"];
        NSDictionary *infoos = [emoji objectForKey:@"infoos"];
        NSArray *infoosKeys = [infoos allKeys];
        NSMutableString *cName = [[NSMutableString alloc] init];
//        NSLog(@"infoosKeys=%@",infoosKeys);
//        NSLog(@"[infoosKeys objectAtIndex:0]=%@",[infoosKeys objectAtIndex:0]);
        if ([infoosKeys count] == 2) {
            NSArray *kinfo = [infoos objectForKey:@"info"];
            NSDictionary *textarr = [kinfo objectAtIndex:0];
            [cName setString:[textarr objectForKey:@"text"]];
        } else if ([infoosKeys count] == 1) {
            //NSDictionary *kinfo = [infoos objectForKey:@"info"];
            [cName setString:[infoos objectForKey:@"text"]];
        }
        if (editNow < 99999999) {
            [data removeObjectAtIndex:editNow];
            editNow = 99999999;
        }
        
        
        for (int i = 0; i < [data count]; i++) {
            NSArray *nowArr = [data objectAtIndex:i];
            NSString *ourl = [nowArr objectAtIndex:1];
            if ([ourl isEqualToString:cURL]) {
                [data removeObjectAtIndex:i];
                break;
            }
        }
        
        NSMutableString *rName = [NSMutableString string];
        for (int i = 0; i < [cName length]; i++) {
            NSString *nowChar = [cName substringWithRange:NSMakeRange(i, 1)];
            if (![nowChar isEqualToString:@"\n"] && ![nowChar isEqualToString:@"\t"]) {
                [rName insertString:nowChar atIndex:[rName length]];
            }
        }
        [cName setString:rName];
        [data addObject:[NSArray arrayWithObjects:cName,cURL,@"u", nil]];
        [self saveToSetting];
        float txtheight = [S txtHeightWithText:cURL MaxWidth:self.tableView.frame.size.width];
        [height addObject:[NSNumber numberWithFloat:txtheight]];
        [self.tableView reloadData];
        
        [self.delegate showBlack:NO];
        
        /*
         infoos =         {
         info =             (
         
         
         infoos =         {
         text = "
         */
    }
}

- (void)saveToSetting
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSMutableArray *saveArr = [NSMutableArray array];
    for (NSArray *nowArr in data) {
        NSString *nowType = [nowArr objectAtIndex:2];
        if ([nowType isEqualToString:@"u"]) {
            [saveArr addObject:nowArr];
        }
    }
    NSArray *save = [NSArray arrayWithArray:saveArr];
//    NSLog(@"saveArr=%@",saveArr);
    [setting setObject:save forKey:@"sourcelist"];
    [setting synchronize];
}

- (void)rightbtn:(id)sender
{
    alertMode = 3;
    [self selectAddMode];
}

- (void)selectAddMode
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SourceAddress", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"SourceStore", nil),NSLocalizedString(@"AddSource_title", nil),nil];
    editNow = 99999999;
    [alert show];
}

- (void)addURL
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AddSource_title", nil) message:NSLocalizedString(@"AddSource_message", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"AddSource_save", nil),nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    //UITextField *tf = [alert textFieldAtIndex:0];
    //tf.text = @"https://dl.dropboxusercontent.com/s/w85noarzzeabgr7/emoji.xml";
    
    editNow = 99999999;
    [alert show];
}

- (void)r:(id)sender
{
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewUIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"正在验证源……" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
 [alert show];EditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

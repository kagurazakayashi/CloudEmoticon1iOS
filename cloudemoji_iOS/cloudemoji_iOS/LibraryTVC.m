//
//  LibraryTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "LibraryTVC.h"
#import "BackgroundImg.h"
#import "S.h"
#define kBK 10.0f
@interface LibraryTVC ()

@end

@implementation LibraryTVC
@synthesize data, height, alertMode, editNow;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    
    BackgroundImg *bg = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bg loadSetting:1];
    [bg loadSettingImg:1];
    self.tableView.backgroundView = bg;
    
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(r:) name:@"r" object:nil];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSArray *userdata = [setting objectForKey:@"sourcelist"];
    if (userdata) {
        for (NSArray *nowArray in userdata) {
            [data addObject:nowArray];
        }
    }
    
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightbtn;
    
    NSArray *d1 = [NSArray arrayWithObjects:@"KTachibanaTest",@"http://dl.dropboxusercontent.com/u/120725807/test.xml",@"e", nil];
    NSArray *d2 = [NSArray arrayWithObjects:@"_KT_Current",@"http://dl.dropboxusercontent.com/u/73985358/Emoji/_KT_Current.xml",@"e", nil];
    [data insertObject:d2 atIndex:0];
    [data insertObject:d1 atIndex:0];
    
    for (NSArray *nowArr in data) {
        NSString *nowUrl = [nowArr objectAtIndex:1];
        //CGSize strSize0=[nowUrl sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - kBK *4, 99999) lineBreakMode:NSLineBreakByWordWrapping];
        float txtheight = [S txtHeightWithText:nowUrl MaxWidth:self.tableView.frame.size.width];
        [height addObject:[NSNumber numberWithFloat:txtheight]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conok:) name:@"conok" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.cellBGView.layer.shadowColor = [[UIColor redColor] CGColor];
    } else {
        [cell.btnFrv setHidden:NO];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"源网址" message:@"请输入数据源网址，支持以XML和JSON为基础的专用数据源。\n源名称将被自动识别。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存源",nil];
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
    if (alertMode == 1) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        if (buttonIndex == 1) {
            [self.delegate reloadData:tf.text ModeTag:2 Local:YES];
        } else {
            editNow = 99999999;
        }
    } else if (alertMode == 2 && buttonIndex == 1) {
        [data removeObjectAtIndex:editNow];
        editNow = 99999999;
        [self saveToSetting];
        [self.tableView reloadData];
    }
    alertMode = 0;
}
-(void)btnSelect:(NSString*)name
{
    for (int i = 0; i < [data count]; i++) {
        NSArray *nowarr = [data objectAtIndex:i];
        NSString *nowURL = [nowarr objectAtIndex:1];
        if ([nowURL isEqualToString:name]) {
            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            [setting setObject:nowURL forKey:@"nowURL"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"已启用“%@”",[nowarr objectAtIndex:0]] message:[NSString stringWithFormat:@"下次自动或手动刷新源的时候，\n将从这个源下载数据：\n%@",nowURL] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除源" message:[NSString stringWithFormat:@"真的要删除源“%@”吗？",tName] delegate:self cancelButtonTitle:@"保留" otherButtonTitles:@"立即删除",nil];
                [alert show];
            }
            break;
        }
    }
}
- (void)sysOnly:(NSString*)name
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"这个源是只读的" message:[NSString stringWithFormat:@"“%@”是软件内置的源，\n不能被修改或删除。\n如果有系统源长期失效，\n请尝试检查软件更新。",name] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
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
        [data addObject:[NSArray arrayWithObjects:cName,cURL,@"u", nil]];
        [self saveToSetting];
        [self.tableView reloadData];
        
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
    [setting setObject:save forKey:@"sourcelist"];
    [setting synchronize];
}

- (void)rightbtn:(id)sender
{
    alertMode = 1;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"源网址" message:@"请输入数据源网址，支持以XML和JSON为基础的专用数据源。\n源名称将被自动识别。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存源",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
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

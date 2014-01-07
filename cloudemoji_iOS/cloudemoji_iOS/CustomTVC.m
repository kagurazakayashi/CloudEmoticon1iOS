//
//  CustomTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 13-12-31.
//  Copyright (c) 2013年 Yashi. All rights reserved.
//

#import "CustomTVC.h"
#import "BackgroundImg.h"
//#import "CXAlertView.h"

@interface CustomTVC ()

@end

@implementation CustomTVC
@synthesize data, height, mode;
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    BackgroundImg *bg = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bg loadSetting:1];
    [bg loadSettingImg:1];
    self.tableView.backgroundView = bg;
    
    [self loadInfo];
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightbtn;
}

- (void)addData:(NSArray*)arr
{
    BOOL isnew = YES;
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userdata = [setting mutableArrayValueForKey:@"diy"];
    NSString *tagStr = [arr objectAtIndex:3];
    for (int i = 0; i < [userdata count]; i++) {
        NSArray *nowArr = [userdata objectAtIndex:i];
        NSString *nowStr = [nowArr objectAtIndex:2];
        //NSString *thisStr = [arr objectAtIndex:2];
        if ([nowStr isEqualToString:tagStr]) {
            [userdata removeObjectAtIndex:i];
            isnew = NO;
        }
    }
    [userdata insertObject:[NSArray arrayWithObjects:[arr objectAtIndex:0],[arr objectAtIndex:1],[arr objectAtIndex:2], nil] atIndex:0];
    [setting setObject:[NSArray arrayWithArray:userdata] forKey:@"diy"];
    [setting synchronize];
    [self loadInfo];
    if (isnew) {
        [MobClick event:@"newDIY"];
    }
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能添加" message:@"这个颜文字已经存在了。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    //[alert show];
}

- (void)rightbtn:(id)sender
{
    mode = 1;
//    self.navigationController.navigationBar.translucent = NO;
    EditViewController *edit = [[EditViewController alloc] init];
    edit.tagStr = @"";
    edit.delegate = self;
    edit.title = NSLocalizedString(@"CustomText", nil);
    [self.navigationController pushViewController:edit animated:YES];
//    [alert show];
}
//- (void)willPresentAlertView:(UIAlertView *)alertView
//{
//    CGRect frame = alertView.frame;
//    UITextView *accoutName = [[UITextView alloc] initWithFrame: CGRectMake( 0, 0,160, 160 )];
////    [alertView addSubview:accoutName];
//    
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"SB=%@",[alertView subviews]);
//}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadInfo];
}

- (void)loadInfo
{
    [data removeAllObjects];
    [height removeAllObjects];
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [setting objectForKey:@"diy"];
    [data addObjectsFromArray:userdata];
    for (NSArray *nowArr in data) {
        NSString *nowUrl = [nowArr objectAtIndex:2];
        float txtheight = [S txtHeightWithText:nowUrl MaxWidth:self.tableView.frame.size.width];
        [height addObject:[NSNumber numberWithFloat:txtheight]];
    }
    [self.tableView reloadData];
}

-(void)btnSelect:(NSString*)name
{
    if ([name isEqualToString:@""]) {
        [self loadInfo];
    } else {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSMutableArray *userdata = [setting mutableArrayValueForKey:@"diy"];
        for (int i = 0; i < [userdata count]; i++) {
            NSArray *nowArr = [userdata objectAtIndex:i];
            NSString *nowStr = [nowArr objectAtIndex:2];
            if ([nowStr isEqualToString:name]) {
//                self.navigationController.navigationBar.translucent = NO;
                EditViewController *edit = [[EditViewController alloc] init];
                edit.tagStr = nowStr;
                edit.edit.text = nowStr;
                edit.ename.text = [nowArr objectAtIndex:1];
                edit.delegate = self;
                [self.navigationController pushViewController:edit animated:YES];
                edit.title = NSLocalizedString(@"CustomText", nil);
            }
        }
    }
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
    OnlineLibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OnlineLibraryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell startWithMode:4];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.delegate = self;
        [cell loadFrame:self.tableView.frame.size.width];
    }
    NSArray *nowcell = [data objectAtIndex:indexPath.row];
    cell.name.text = [nowcell objectAtIndex:1];
    cell.info.text = [nowcell objectAtIndex:2];
    float infoY = kLY1;
    if (cell.name.text.length == 0) {
        infoY = kLY0;
    }
    cell.info.frame = CGRectMake(kBK * 2, infoY, self.tableView.frame.size.width - kBK * 3, [[height objectAtIndex:indexPath.row] floatValue] + kBK * 0.5);
    cell.cellBGView.frame = CGRectMake(kBK, kBK * 1.5, self.tableView.frame.size.width - kBK * 2, cell.name.frame.origin.x + cell.name.frame.size.height + cell.info.frame.origin.x + cell.info.frame.size.height - kBK * 3);
    //[cell fav];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.delegate loadInfo:[data objectAtIndex:indexPath.row]];
    NSArray *selectArr = [data objectAtIndex:indexPath.row];
    NSString *selectStr = [selectArr objectAtIndex:2];
    NSNumber *num = [NSNumber numberWithInt:1];
    NSArray *arr = [NSArray arrayWithObjects:num,selectStr, nil];
    [MobClick event:@"copy_diy"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alt" object:arr];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *nowrow = [height objectAtIndex:indexPath.row];
    return [nowrow floatValue] + kBK * 4 + 30;
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
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

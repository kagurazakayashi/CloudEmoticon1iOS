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
#import "ADView.h"
@interface CustomTVC ()

@end

@implementation CustomTVC
@synthesize data, height, mode, noneview;
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
}
- (void)load
{
//    self.view.frame = [S s].viewFrame;
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
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    if ([S s].ios >= 7.0) {
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+50, self.view.frame.size.width, self.view.frame.size.height-100);
    } else {
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-15, self.view.frame.size.width, self.view.frame.size.height+15);
    }
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, dstitle - 20, self.view.frame.size.width, self.view.frame.size.height - dstitle - dsfoot + 40) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    BackgroundImg *bg = [[BackgroundImg alloc] init];
    if ([S s].ios < 7.0) {
        [bg changeFrame:self.tableView.frame];
    } else {
        [bg changeFrame:self.view.frame];
    }
    [bg loadSetting:1];
    [bg loadSettingImg:1];
    
    [self.view addSubview:bg];
    [self.view addSubview:self.tableView];
    noneview = [[NoneView alloc] initWithFrame:self.tableView.frame];
    noneview.info = NSLocalizedString(@"none_custom", nil);
    [self.view addSubview:noneview];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadInfo];
//    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightbtn:)];
//    self.navigationItem.rightBarButtonItem = rightbtn;
    ADView *ad = [[ADView alloc] initWithViewController:self ShowNow:NO FixHeight:YES];
    [self.view addSubview:ad];
}

- (void)addData:(NSArray*)arr
{
    if (arr) {
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
    [self.delegate reloadButton:NO];
}

- (void)rightbtn:(id)sender
{
    mode = 1;
//    self.navigationController.navigationBar.translucent = NO;
//    if (!self.edit) {
        self.edit = [[EditView alloc] initWithFrame:self.view.frame];
//    }
    self.edit.tagStr = @"";
    self.edit.delegate = self;
//    self.edit.title = NSLocalizedString(@"CustomText", nil);
    self.edit.ename.text = @"";
    self.edit.edit.text = @"";
//    [self.navigationController pushViewController:self.edit animated:YES];
    [self.delegate reloadButton:YES];
    [self.delegate openEditWindow:self.edit];
//    [self presentViewController:self.edit animated:YES completion:^{
//        [self.edit.edit becomeFirstResponder];
//    }];
    
//    [alert show];
    
}

- (void)EditViewClose
{
    
    [self.delegate closeEditWindow:self.edit];
    
//    [self.navigationController popViewControllerAnimated:YES];
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

//- (void)viewDidAppear:(BOOL)animated
//{
//    [self loadInfo];
//}

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
    [noneview hide:[data count]];
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
                if (!self.edit) {
                    self.edit = [[EditView alloc] initWithFrame:self.view.frame];
                }
                self.edit.tagStr = nowStr;
                self.edit.edit.text = nowStr;
                self.edit.ename.text = [nowArr objectAtIndex:1];
                self.edit.delegate = self;
//                self.edit.title = NSLocalizedString(@"CustomText", nil);
                [self.delegate reloadButton:YES];
                [self.delegate openEditWindow:self.edit];
//                [self presentViewController:self.edit animated:YES completion:^{
//                    [self.edit.edit becomeFirstResponder];
//                }];
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
        [cell loadColorSetting:1];
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

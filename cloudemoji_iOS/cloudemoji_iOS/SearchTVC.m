//
//  SearchTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "SearchTVC.h"
#import "BackgroundImg.h"
#define kBK 10.0f

@interface SearchTVC ()

@end

@implementation SearchTVC
@synthesize data, height, search;

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
    
    BackgroundImg *bg = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bg loadSetting:1];
    [bg loadSettingImg:1];
    self.tableView.backgroundView = bg;
    
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, 40)];
    search.placeholder = @"输入颜文字或颜文字名字中的字符";
    search.delegate = self;
    self.tableView.tableHeaderView = search;
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    search.keyboardType = UIKeyboardAppearanceLight;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadInfo];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [data removeAllObjects];
    [height removeAllObjects];
    for (int i = 0; i < [[S s].allinfo count]; i++) {
        NSArray *nowArr = [[S s].allinfo objectAtIndex:i];
        BOOL han = NO;
        for (NSString *txt in nowArr) {
            NSRange range = [txt rangeOfString:searchText];//判断字符串是否包含
            if (range.location != NSNotFound)//包含
            {
                han = YES;
            }
        }
        if (han) {
            [data addObject:nowArr];
            float txtheight = [S txtHeightWithText:[nowArr objectAtIndex:2] MaxWidth:self.tableView.frame.size.width];
            [height addObject:[NSNumber numberWithFloat:txtheight]];
        }
    }
    [self loadInfo];
}
- (void)loadInfo
{
    [self.tableView reloadData];
}

-(void)btnSelect:(NSString*)name
{
    [self.tableView reloadData];
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
        [cell startWithMode:5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.delegate = self;
        [cell loadFrame:self.tableView.frame.size.width];
    }
    NSArray *nowcell = [data objectAtIndex:indexPath.row];
    cell.name.text = [nowcell objectAtIndex:1];
    cell.info.text = [nowcell objectAtIndex:2];
    float infoY = kBK * 2;
    if (cell.name.text.length == 0) {
        infoY = kBK + 15;
    }
    cell.info.frame = CGRectMake(kBK * 2, infoY, self.tableView.frame.size.width - kBK * 3, [[height objectAtIndex:indexPath.row] floatValue] + kBK * 0.5);
    cell.cellBGView.frame = CGRectMake(kBK, kBK * 1.5, self.tableView.frame.size.width - kBK * 2, cell.name.frame.origin.x + cell.name.frame.size.height + cell.info.frame.origin.x + cell.info.frame.size.height - kBK * 3);
    [cell fav];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.delegate loadInfo:[data objectAtIndex:indexPath.row]];
    NSArray *selectArr = [data objectAtIndex:indexPath.row];
    NSString *selectStr = [selectArr objectAtIndex:2];
    NSNumber *num = [NSNumber numberWithInt:1];
    NSArray *arr = [NSArray arrayWithObjects:num,selectStr, nil];
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

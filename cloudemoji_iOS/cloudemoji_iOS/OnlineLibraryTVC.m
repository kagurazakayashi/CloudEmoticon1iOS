//
//  OnlineLibraryTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "OnlineLibraryTVC.h"
#import "S.h"
#define bl 0.7f
#define kBK 10.0f

@interface OnlineLibraryTVC ()

@end

@implementation OnlineLibraryTVC
@synthesize typemenu,tableView,typemenuD,tableViewD,data,height,alertMode,editNow,blackView,showTool;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    self.view.backgroundColor = [UIColor blackColor];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    showTool = [[setting objectForKey:@"showLib"] boolValue];
    BOOL css = [[setting objectForKey:@"css"] boolValue];
    
    typemenu = [[TypeMenuView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width * bl, self.view.frame.size.height)];
    typemenu.delegate = self;
    typemenuD = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * bl, self.view.frame.size.height)];
//    typemenuD.bg.backgroundColor = [UIColor blackColor];
    [typemenuD loadSetting:0];
    [typemenuD loadSettingImg:0];
    [self.view addSubview:typemenuD];
    [self.view addSubview:typemenu];
    
    blackView = [[UIView alloc] initWithFrame:self.tableView.frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5f;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    tableViewD = [[BackgroundImg alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableViewD loadSetting:1];
    [tableViewD loadSettingImg:1];
    if (css) {
        tableViewD.layer.shadowColor = [[UIColor blackColor] CGColor];
        tableViewD.layer.shadowOffset = CGSizeMake(-10,0);
        tableViewD.layer.shadowOpacity = 1;
        tableViewD.layer.shadowRadius = 10;
    }
    [self.view addSubview:tableViewD];
    [self.view addSubview:tableView];
    [self.view addSubview:blackView];
    
    if (!showTool) {
        UISwipeGestureRecognizer *swip0 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction0:)];
        swip0.direction = UISwipeGestureRecognizerDirectionRight;
        [self.tableView addGestureRecognizer:swip0];
        UISwipeGestureRecognizer *swip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction1:)];
        swip1.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.blackView addGestureRecognizer:swip1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction1:)];
        [self.blackView addGestureRecognizer:tap];
    }
    
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightbtn;
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftbtn:)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conok:) name:@"conok" object:nil];
    [self.delegate reloadData:[[NSUserDefaults standardUserDefaults] objectForKey:@"nowURL"] ModeTag:1 Local:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(r:) name:@"r" object:nil];
    
    [self swipAction0:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)loadInfo:(NSString*)type
{
    [data removeAllObjects];
    [height removeAllObjects];
    for (NSArray *itemArr in [S s].allinfo) {
        NSString *groupTitle = [itemArr objectAtIndex:0];
        if ([groupTitle isEqualToString:type]) {
            [data addObject:itemArr];
        }
    }
    for (NSArray *nowArr in data) {
        NSString *nowUrl = [nowArr objectAtIndex:2];
        //CGSize strSize0=[nowUrl sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - kBK *4, 99999) lineBreakMode:NSLineBreakByWordWrapping];
        float txtheight = [S txtHeightWithText:nowUrl MaxWidth:self.tableView.frame.size.width];
        [height addObject:[NSNumber numberWithFloat:txtheight]];
    }
    [tableView reloadData];
    if (tableView.frame.origin.x > 0 && !showTool) {
        [self swipAction1:nil];
    }
}

- (void)conok:(NSNotification*)notification
{
    
    [data removeAllObjects];
    [self.tableView reloadData];
}

- (void)leftbtn:(id)sender
{
    if (tableView.frame.origin.x > 0) {
        [self swipAction1:nil];
    } else {
        [self swipAction0:nil];
    }
}
- (void)rightbtn:(id)sender
{
    [self.delegate reloadData:[[NSUserDefaults standardUserDefaults] objectForKey:@"nowURL"] ModeTag:1 Local:NO];
}

- (void)swipAction0:(id)sender
{
    //UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)sender;
    //if (swipe.state == UISwipeGestureRecognizerDirectionRight) {  }
    [blackView setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^{
        typemenu.frame = CGRectMake(0, 0, self.view.frame.size.width * bl, self.view.frame.size.height);
        if (showTool) {
            tableView.frame = CGRectMake(self.view.frame.size.width * 0.3, 0, self.view.frame.size.width, self.view.frame.size.height);
        } else {
            tableView.frame = CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width, self.view.frame.size.height);
            blackView.alpha = 0.5;
        }
        blackView.frame = tableView.frame;
        tableViewD.img.alpha = tableView.alpha;
        [tableViewD changeFrame:tableView.frame];
    }];
}
- (void)swipAction1:(id)sender
{
    if (tableView.frame.origin.x > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            typemenu.frame = CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width * bl, self.view.frame.size.height);
            tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            blackView.frame = tableView.frame;
            blackView.alpha = 0;
//            tableViewD.img.alpha = 0.5;
            [tableViewD changeFrame:tableView.frame];
        } completion:^(BOOL finished) {
            [blackView setHidden:YES];
        }];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OnlineLibraryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OnlineLibraryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell startWithMode:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self;
        [cell loadFrame:self.tableView.frame.size.width];
    }
    // Configure the cell...
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *nowrow = [height objectAtIndex:indexPath.row];
    return [nowrow floatValue] + kBK * 4 + 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectArr = [data objectAtIndex:indexPath.row];
    NSString *selectStr = [selectArr objectAtIndex:2];
    NSNumber *num = [NSNumber numberWithInt:1];
    NSArray *arr = [NSArray arrayWithObjects:num,selectStr, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alt" object:arr];
}

- (void)r:(id)sender
{
    if (tableView.frame.origin.x == 0 && showTool) {
        [self swipAction1:nil];
    }
    float size = 0;
    if (showTool) {
        size = 0.3;
    } else {
        size = bl;
    }
    typemenu.frame = CGRectMake(self.view.frame.size.width * size, 0, self.view.frame.size.width * size, self.view.frame.size.height);
    [typemenuD changeFrame:CGRectMake(0, 0, self.view.frame.size.width * size, self.view.frame.size.height)];
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [tableViewD changeFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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

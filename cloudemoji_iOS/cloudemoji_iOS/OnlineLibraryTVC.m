//
//  OnlineLibraryTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "OnlineLibraryTVC.h"

#define bl 0.8f

@interface OnlineLibraryTVC ()

@end

@implementation OnlineLibraryTVC
@synthesize typemenu,tableView,typemenuD,tableViewD,tableViewD2;

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
    self.view.backgroundColor = [UIColor blackColor];
    typemenu = [[TypeMenuView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width * bl, self.view.frame.size.height)];
    typemenuD = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * bl, self.view.frame.size.height)];
    typemenuD.image = [UIImage imageNamed:@"yande.re 274096 machine-doll_wa_kizutsukanai pantsu tagme thighhighs yaya.jpg"];
    typemenuD.alpha = 0.5;
    [self.view addSubview:typemenuD];
    [self.view addSubview:typemenu];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    tableViewD = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableViewD.image = [UIImage imageNamed:@"38134429.jpg"];
    tableViewD2 = [[UIView alloc] initWithFrame:tableView.frame];
    tableViewD2.backgroundColor = [UIColor blackColor];
    tableViewD2.layer.shadowColor = [[UIColor blackColor] CGColor];
    tableViewD2.layer.shadowOffset = CGSizeMake(-10,0);
    tableViewD2.layer.shadowOpacity = 1;
    tableViewD2.layer.shadowRadius = 10;
    [self.view addSubview:tableViewD2];
    [self.view addSubview:tableViewD];
    [self.view addSubview:tableView];
    
    UISwipeGestureRecognizer *swip0 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction0:)];
    swip0.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swip0];
    UISwipeGestureRecognizer *swip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction1:)];
    swip1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:swip1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction1:)];
    [self.tableView addGestureRecognizer:tap];
    
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightbtn:)];
    self.navigationItem.rightBarButtonItem = rightbtn;
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftbtn:)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    
    [self swipAction0:nil];
    
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
- (void)reloadDataOK:(NSDictionary*)newData
{
    
}
- (void)swipAction0:(id)sender
{
    //UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)sender;
    //if (swipe.state == UISwipeGestureRecognizerDirectionRight) {  }
    [UIView animateWithDuration:0.5 animations:^{
        typemenu.frame = CGRectMake(0, 0, self.view.frame.size.width * bl, self.view.frame.size.height);
        tableView.frame = CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width, self.view.frame.size.height);
        tableView.alpha = 0.3;
        tableViewD.alpha = tableView.alpha;
        tableViewD.frame = tableView.frame;
        tableViewD2.frame = tableView.frame;
    }];
}
- (void)swipAction1:(id)sender
{
    if (tableView.frame.origin.x > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            typemenu.frame = CGRectMake(self.view.frame.size.width * bl, 0, self.view.frame.size.width * bl, self.view.frame.size.height);
            tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            tableView.alpha = 1;
            tableViewD.alpha = tableView.alpha;
            tableViewD.frame = tableView.frame;
            tableViewD2.frame = tableView.frame;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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

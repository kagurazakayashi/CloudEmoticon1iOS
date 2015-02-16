//
//  GameTVC.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-5-28.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "GameTVC.h"

@interface GameTVC ()

@end

@implementation GameTVC
<<<<<<< HEAD
@synthesize data;
=======

>>>>>>> FETCH_HEAD
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
    // Do any additional setup after loading the view.
}

<<<<<<< HEAD
- (void)load
{
    data = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    if ([S s].ios >= 7.0) {
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+50, self.view.frame.size.width, self.view.frame.size.height-100);
    } else {
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-15, self.view.frame.size.width, self.view.frame.size.height+15);
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self loadInfo];
}

- (void)loadInfo
{
    [data removeAllObjects];
    NSArray *soft1arr = [NSArray arrayWithObjects:@"射击！颜文字",@"举起你的设备,射击空中飞翔的颜文字~!",[UIImage imageNamed:@"faceatk.png"],@"com.jcyl.emoticonshoot:",@"https://itunes.apple.com/cn/app/she-ji!-yan-wen-zi/id879022389?l=zh&ls=1&mt=8", nil];
    [data addObject:soft1arr];
    [self.tableView reloadData];
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSArray *nowArr = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [nowArr objectAtIndex:0];
    cell.detailTextLabel.text = [nowArr objectAtIndex:1];
    cell.imageView.image = [nowArr objectAtIndex:2];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nowArr = [data objectAtIndex:indexPath.row];
    NSString *launchURL = [nowArr objectAtIndex:3];
    NSURL *urlToOpen = [NSURL URLWithString:launchURL];
    NSLog(@"urlToOpen=%@",urlToOpen);
    if ([[UIApplication sharedApplication] canOpenURL:urlToOpen]) {
        [MobClick event:@"openGameFaceAtk"];
        [[UIApplication sharedApplication] openURL:urlToOpen];
    } else {
        NSString *dlaunchURL = [nowArr objectAtIndex:4];
        NSURL *durlToOpen = [NSURL URLWithString:dlaunchURL];
        [MobClick event:@"lookGameFaceAtk"];
        [[UIApplication sharedApplication] openURL:durlToOpen];
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

=======
>>>>>>> FETCH_HEAD
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

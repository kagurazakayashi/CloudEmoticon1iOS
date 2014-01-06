//
//  TypeMenuView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-1.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "TypeMenuView.h"
#import "S.h"
@implementation TypeMenuView
@synthesize tableview,data;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        data = [[NSMutableArray alloc] init];
        
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
        self.tableview.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableview];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conok:) name:@"conok" object:nil];
    }
    return self;
}

- (void)conok:(NSNotification*)notification
{
    //NSArray *cinf = [notification object];
    NSMutableString *tmpStr = [NSMutableString string];
    [data removeAllObjects];
    for (NSArray *itemArr in [S s].allinfo) {
        NSString *groupTitle = [itemArr objectAtIndex:0];
        if (![groupTitle isEqualToString:tmpStr]) {
            [data addObject:groupTitle];
            [tmpStr setString:groupTitle];
        }
    }
    [tableview reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate loadInfo:[data objectAtIndex:indexPath.row]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

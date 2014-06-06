//
//  DetailViewController.h
//  cloudemoji_ios_mini
//
//  Created by 神楽坂雅詩 on 14-2-2.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

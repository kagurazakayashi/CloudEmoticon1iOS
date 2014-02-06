//
//  BackgroundImg.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "BackgroundImg.h"

@implementation BackgroundImg
@synthesize img, mode;//, bg;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
//        self.bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        self.bg.backgroundColor = [UIColor whiteColor];
//        self.img.alpha = 0.5;
        self.img.clipsToBounds = YES;
        self.img.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:bg];
        [self addSubview:img];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nimg:) name:@"bg" object:nil];
    }
    return self;
}

//- (void)viewDidUnload
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [super viewDidUnload];
//}

- (void)nimg:(NSNotification*)notification
{
    NSArray *cinf = [notification object];
    NSNumber *m = [cinf objectAtIndex:0];
    int md = [m intValue];
    if (md == mode) {
        UIImage *imgd = [cinf objectAtIndex:1];
        [self changeImage:imgd];
    }
}

- (void)changeFrame:(CGRect)newframe
{
//    bg.frame = CGRectMake(0, 0, newframe.size.width, newframe.size.height);
    img.frame = CGRectMake(0, 0, newframe.size.width, newframe.size.height);
    self.frame = newframe;
}

- (void)loadSettingImg:(NSInteger)imgID
{
    mode = imgID;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/bg%ld.cxc",documentDirectory,(long)imgID];
    if ([fileManager fileExistsAtPath:path]) {
        UIImage *i = [[UIImage alloc] initWithContentsOfFile:path];
        [self changeImage:i];
    } else {
        [img setImage:nil];
    }
}

- (void)saveSettingImg:(NSInteger)imgID
{
    mode = imgID;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/bg%ld.cxc",documentDirectory,(long)imgID];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
    if (img.image) {
        NSData *imgData = UIImageJPEGRepresentation(img.image, 0);
        [imgData writeToFile:path atomically:YES];
    }
}

- (void)loadSetting:(NSInteger)imgID
{
    mode = imgID;
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *settingName = [NSString stringWithFormat:@"psz%ld",(long)imgID];
    NSNumber *psz0n = [setting objectForKey:settingName];
    NSInteger psz0 = [psz0n integerValue];
    [img setContentMode:psz0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/bg%ld.cxc",documentDirectory,(long)imgID];
    if ([fileManager fileExistsAtPath:path]) {
        [img setImage:[UIImage imageWithContentsOfFile:path]];
    }
//    if (imgID == 0) {
//        self.backgroundColor = [UIColor lightGrayColor];
//    }
}

- (void)saveSetting:(NSInteger)imgID
{
    mode = imgID;
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *settingName = [NSString stringWithFormat:@"psz%ld",(long)imgID];
    NSNumber *psz = [NSNumber numberWithInteger:imgID];
    [setting setObject:psz forKey:settingName];
    [setting synchronize];
}

- (void)changeImage:(UIImage*)i
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL cpic = [[setting objectForKey:@"cpic"] boolValue];
    if (cpic) {
        [img setImage:nil];
        [img setImage:i];
    } else {
        if (img.image) {
            [img setImage:nil];
        }
    }
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

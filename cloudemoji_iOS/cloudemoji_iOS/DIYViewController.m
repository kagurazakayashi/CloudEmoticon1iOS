//
//  DIYViewController.m
//  cloudemoji_iOS
//
//  Created by 王 燚 on 14-1-4.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "DIYViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define kZNAME0 @"缩放拉伸",@"缩放居中",@"填充(推荐)",@"居中",@"底端对齐",@"顶端对齐",@"左对齐",@"右对齐",@"左上对齐",@"右上对齐",@"左下对齐",@"右下对齐", nil
#define kZNAME1 @"缩放拉伸",@"缩放居中",@"填充(推荐)",@"对齐裁剪 >", nil
#define kZNAME2 @"居中",@"底端对齐",@"顶端对齐",@"左对齐",@"右对齐",@"左上对齐",@"右上对齐",@"左下对齐",@"右下对齐", nil
@interface DIYViewController ()

@end

@implementation DIYViewController
@synthesize imgA, imgB, mode, zName, zoom1, zoom2, alertmode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mode = 0;
        self.zName = [NSArray arrayWithObjects:kZNAME0];
        [self didLoad];
        [self loadSetting];
    }
    return self;
}

- (void)didLoad
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    imgA = [[BackgroundImg alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width * 0.5 - 15, self.view.frame.size.height * 0.5 - 15)];
//    imgA.bg.backgroundColor = [UIColor blackColor];
    imgA.backgroundColor = [UIColor blackColor];
    [scroll addSubview:imgA];
    UIButton *btnA = [UIButton buttonWithType:UIButtonTypeCustom];
    btnA.backgroundColor = [UIColor blueColor];
    btnA.frame = CGRectMake(imgA.frame.origin.x, imgA.frame.origin.y + imgA.frame.size.height + 5, imgA.frame.size.width, 50);
    [btnA setTitle:@"更换背景底图" forState:UIControlStateNormal];
    [btnA addTarget:self action:@selector(btnA:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:btnA];
    zoom1 = [UIButton buttonWithType:UIButtonTypeCustom];
    zoom1.backgroundColor = [UIColor purpleColor];
    zoom1.frame = CGRectMake(imgA.frame.origin.x, imgA.frame.origin.y + imgA.frame.size.height + btnA.frame.size.height + 10, btnA.frame.size.width, btnA.frame.size.height);
    [zoom1 addTarget:self action:@selector(zoom1:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:zoom1];
    UIButton *delA = [UIButton buttonWithType:UIButtonTypeCustom];
    delA.backgroundColor = [UIColor grayColor];
    delA.frame = CGRectMake(imgA.frame.origin.x, zoom1.frame.origin.y + zoom1.frame.size.height + 5, btnA.frame.size.width, btnA.frame.size.height);
    [delA setTitle:@"背景底图恢复默认" forState:UIControlStateNormal];
    [delA addTarget:self action:@selector(delA:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:delA];
    
    imgB = [[BackgroundImg alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 + 5, 10, self.view.frame.size.width * 0.5 - 15, self.view.frame.size.height * 0.5 - 15)];
//    imgB.bg.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:imgB];
    UIButton *btnB = [UIButton buttonWithType:UIButtonTypeCustom];
    btnB.backgroundColor = [UIColor blueColor];
    btnB.frame = CGRectMake(imgB.frame.origin.x, imgB.frame.origin.y + imgA.frame.size.height + 5, imgB.frame.size.width, 50);
    [btnB setTitle:@"更换前景底图" forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(btnB:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:btnB];
    zoom2 = [UIButton buttonWithType:UIButtonTypeCustom];
    zoom2.backgroundColor = [UIColor purpleColor];
    zoom2.frame = CGRectMake(imgB.frame.origin.x, imgB.frame.origin.y + imgB.frame.size.height + btnB.frame.size.height + 10, btnB.frame.size.width, btnB.frame.size.height);
    [zoom2 addTarget:self action:@selector(zoom2:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:zoom2];
    UIButton *delB = [UIButton buttonWithType:UIButtonTypeCustom];
    delB.backgroundColor = [UIColor grayColor];
    delB.frame = CGRectMake(imgB.frame.origin.x, zoom2.frame.origin.y + zoom2.frame.size.height + 5, btnB.frame.size.width, btnB.frame.size.height);
    [delB setTitle:@"前景底图恢复默认" forState:UIControlStateNormal];
    [delB addTarget:self action:@selector(delB:) forControlEvents:UIControlEventTouchDown];
    [scroll addSubview:delB];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, delB.frame.origin.y + delB.frame.size.height + 60);
    [self.view addSubview:scroll];
    
}

- (void)loadSetting
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSNumber *psz0n = [setting objectForKey:@"psz0"];
    NSInteger psz0 = [psz0n integerValue];
    [imgA.img setContentMode:psz0];
    [imgA loadSettingImg:0];
    [zoom1 setTitle:[zName objectAtIndex:psz0] forState:UIControlStateNormal];
    NSNumber *psz1n = [setting objectForKey:@"psz1"];
    NSInteger psz1 = [psz1n integerValue];
    [imgB.img setContentMode:psz1];
    [imgB loadSettingImg:1];
    [zoom2 setTitle:[zName objectAtIndex:psz1] forState:UIControlStateNormal];
    
}

- (void)zoom1:(id)sender
{
    mode = 1;
    [self selectZoom];
}
- (void)zoom2:(id)sender
{
    mode = 2;
    [self selectZoom];
}
- (void)selectZoom
{
    if ([self canContinue]) {
        alertmode = 1;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选择图像缩放方式" message:nil delegate:self cancelButtonTitle:@"保持当前设置" otherButtonTitles:kZNAME1];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertmode == 2) {
        [self selectZoom];
    } else if (buttonIndex > 0) {
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        NSInteger idx = buttonIndex - 1;
        if (alertmode == 2) {
            idx += 3;
        }
        if (buttonIndex == 4 && alertmode == 1) {
            alertmode = 2;
            UIAlertView *more = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"< 上一步" otherButtonTitles:kZNAME2];
            [more show];
        } else {
            if (mode == 1) {
                [imgA.img setContentMode:idx];
                [zoom1 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz0"];
            } else if (mode == 2) {
                [imgB.img setContentMode:idx];
                [zoom1 setTitle:[zName objectAtIndex:idx] forState:UIControlStateNormal];
                [setting setObject:[NSNumber numberWithInteger:idx] forKey:@"psz1"];
            }
            [setting synchronize];
        }
    }
}

- (void)btnA:(id)sender
{
    mode = 1;
    [self selectPicture];
}
- (void)btnB:(id)sender
{
    mode = 2;
    [self selectPicture];
}
- (void)selectPicture
{
    if ([self canContinue]) {
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

- (void)delA:(id)sender
{
    mode = 1;
    UIImage *d = [UIImage imageNamed:@"psz0.jpg"];
    [self selectPic:d];
}
- (void)delB:(id)sender
{
    mode = 2;
    UIImage *d = [UIImage imageNamed:@"psz1.jpg"];
    [self selectPic:d];
}

- (BOOL)canContinue
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    BOOL cpic = [[setting objectForKey:@"cpic"] boolValue];
    if (!cpic) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"功能已被禁用" message:@"由于您在设置中不允许本程序载入背景图片，操作无法继续。\n要继续操作，请转至“iOS系统设置→云颜文字→允许使用自定义图片作为主题”，设置为“启用”，并重启本程序。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    return cpic;
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
}



- (void)selectPic:(UIImage*)image

{
    if (mode == 1) {
        [imgA changeImage:image];
        [imgA saveSettingImg:0];
    } else if (mode == 2) {
        [imgB changeImage:image];
        [imgB saveSettingImg:1];
    }
    NSNumber *nmode = [NSNumber numberWithInt:mode-1];
    NSArray *postinfo = [NSArray arrayWithObjects:nmode, image, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bg" object:postinfo];
    //[self performSelectorInBackground:@selector(detect:) withObject:nil];
}

-(void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker

{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

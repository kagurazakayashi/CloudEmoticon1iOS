//
//  Diy.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-9.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "Diy.h"

@interface Diy ()

@end

@implementation Diy

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isOpenPic = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.isOpenPic == NO) {
        self.vc = [[DIYVC alloc] init];
        self.vc.delegate = self;
        [self.view addSubview:self.vc.view];
        [super viewWillAppear:YES];
    }
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    if (self.isOpenPic == NO) {
        self.vc.delegate = nil;
        [self.vc.view removeFromSuperview];
        self.vc = nil;
        [super viewWillDisappear:YES];
    }
}

- (void)openPicID:(int)imgID
{
    self.imgMode = imgID;
    [self selectPicture];
}

- (void)selectPicture
{
    self.isOpenPic = YES;
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType=sourceType;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.isOpenPic = NO;
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
//    [self selectPic:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.isOpenPic = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)selectPic:(UIImage*)image
{
    //[self.vc selectPic:image];
    if (self.imgMode == 1) {
        [self.vc.imgA changeImage:image];
        [self.vc.imgA saveSettingImg:0];
//        [self.vc.imgB loadSetting:1];
    } else if (self.imgMode == 2) {
        [self.vc.imgB changeImage:image];
        [self.vc.imgB saveSettingImg:1];
//        [self.vc.imgA loadSetting:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

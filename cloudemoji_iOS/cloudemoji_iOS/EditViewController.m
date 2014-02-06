//
//  EditViewController.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 14-1-6.
//  Copyright (c) 2014年 Yashi. All rights reserved.
//

#import "EditViewController.h"
#import "BackgroundImg.h"
#import "Toast+UIView.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize edit,bga,title,ename,tagStr,rightbtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        float dstitle = [S s].correct.width;
        BackgroundImg *bg = [[BackgroundImg alloc] init];
        [bg changeFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [bg loadSetting:1];
        [bg loadSettingImg:1];
        [self.view addSubview:bg];
        
        //bga = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 140)];
        ename = [[UITextField alloc] initWithFrame:CGRectMake(10, 10 + dstitle, self.view.frame.size.width - 20, 20)];
        ename.backgroundColor = [UIColor whiteColor];
        ename.alpha = 0.9;
        ename.backgroundColor = [UIColor cyanColor];
        ename.placeholder = NSLocalizedString(@"Untitled", nil);
        ename.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        bga = [[UIView alloc] initWithFrame:CGRectMake(10, 35 + dstitle, self.view.frame.size.width - 20, self.view.frame.size.height * 0.37 - 20)];
        bga.backgroundColor = [UIColor whiteColor];
        bga.alpha = 0.5;
        edit = [[UITextView alloc] initWithFrame:bga.frame];
        edit.backgroundColor = [UIColor clearColor];
//        edit.delegate = self;
        [self.view addSubview:ename];
        [self.view addSubview:bga];
        [self.view addSubview:edit];
        
        rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightbtn:)];
        self.navigationItem.rightBarButtonItem = rightbtn;
        UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftbtn:)];
        //[self.rightbtn setEnabled:NO];
        self.navigationItem.leftBarButtonItem = leftbtn;
        
        self.navigationItem.leftBarButtonItem.title = NSLocalizedString(@"Save", nil);
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
            [customKeyboard setTextView:edit];
        }
        else {
            PKCustomKeyboard *customKeyboard = [[PKCustomKeyboard alloc] init];
            [customKeyboard setTextView:edit];
        }
        
        [edit becomeFirstResponder];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString *tmpStr = @"" ;
//    tmpStr = edit.text;
//    tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"tmpStr=%@",tmpStr);
    
//    NSString *nowTxt = [NSString stringWithFormat:@"%@%@",edit.text,text];
//    if ([tmpStr length] == 0) {
//        [self.rightbtn setEnabled:NO];
//    } else {
//        [self.rightbtn setEnabled:YES];
//    }
    return YES;
}

//- (void)keyboardWillChangeFrame:(NSNotification *)notification
//{
//    NSDictionary *info = [notification userInfo];
//    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y + 50;
//    CGRect inputFieldRect = bga.frame;
//    inputFieldRect.size.height += yOffset;
//    [UIView animateWithDuration:duration animations:^{
//        edit.frame = inputFieldRect;
//        bga.frame = inputFieldRect;
//    }];
//}

- (void)close
{
//    self.navigationController.navigationBar.translucent = YES;
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
}

- (void)leftbtn:(id)sender
{
    [self.delegate addData:nil];
    [self close];
}

- (void)rightbtn:(id)sender
{
    if (!edit || edit.text.length == 0) {
        [self.view makeToast:NSLocalizedString(@"Blank", nil)];
        [UIView animateWithDuration:1000 animations:^{
            edit.alpha = 0;
        } completion:^(BOOL finished) {
            edit.alpha = 1;
        }];
    } else {
        NSString *sname = nil;
        NSString *sedit = nil;
        NSString *stag = nil;
        if (ename && ename.text.length > 0) {
            sname = [NSString stringWithString:ename.text];
        } else {
            sname = @"";
        }
        if (edit && edit.text.length > 0) {
            sedit = [NSString stringWithString:edit.text];
        } else {
            sedit = @"";
        }
        if (tagStr && tagStr.length > 0) {
            stag = [NSString stringWithString:tagStr];
        } else {
            stag = @"";
        }
        NSArray *item = [NSArray arrayWithObjects:@"<USER>",sname,sedit,stag, nil];
        [self.delegate addData:item];
        [self close];
    }
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

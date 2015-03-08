//
//  EditView.m
//  cloudemoji_iOS
//
//  Created by 神楽坂雅詩 on 15/3/4.
//  Copyright (c) 2015年 Yashi. All rights reserved.
//

#import "EditView.h"
#import "BackgroundImg.h"
#import "Toast+UIView.h"

@implementation EditView
@synthesize edit,bga,ename,tagStr,rightbtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float dstitle = [S s].correct.width;
        BackgroundImg *bg = [[BackgroundImg alloc] init];
        [bg changeFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [bg loadSetting:1];
        [bg loadSettingImg:1];
        [self addSubview:bg];
        
        //bga = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 140)];
        ename = [[UITextField alloc] initWithFrame:CGRectMake(10, 10 + dstitle, self.frame.size.width - 20, 20)];
        ename.backgroundColor = [UIColor whiteColor];
        ename.alpha = 0.9;
        ename.backgroundColor = [UIColor cyanColor];
        ename.placeholder = NSLocalizedString(@"Untitled", nil);
        ename.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        bga = [[UIView alloc] initWithFrame:CGRectMake(10, 35 + dstitle, self.frame.size.width - 20, self.frame.size.height * 0.37 - 20)];
        bga.backgroundColor = [UIColor whiteColor];
        bga.alpha = 0.5;
        edit = [[UITextView alloc] initWithFrame:bga.frame];
        edit.backgroundColor = [UIColor clearColor];
        //        edit.delegate = self;
        [self addSubview:ename];
        [self addSubview:bga];
        [self addSubview:edit];
        
        //        self.tmpRightBtn = self.navigationItem.rightBarButtonItem;
        
        //右上
        //        rightbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightbtn:)];
        //        self.navigationItem.rightBarButtonItem = rightbtn;
        //        UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftbtn:)];
        //        //[self.rightbtn setEnabled:NO];
        //        self.navigationItem.leftBarButtonItem = leftbtn;
        //        self.navigationItem.leftBarButtonItem.title = NSLocalizedString(@"Save", nil);
        UIButton *left = [UIButton buttonWithType:UIButtonTypeSystem];
        left.frame = CGRectMake(0, 20, self.frame.size.width, 20);
        [left setTitle:@"< Back" forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left];
        
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        //开启自定义键盘
        //        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        //        {
        //            PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
        //            [customKeyboard setTextView:edit];
        //        }
        //        else {
        //            PKCustomKeyboard *customKeyboard = [[PKCustomKeyboard alloc] init];
        //            [customKeyboard setTextView:edit];
        //        }
        
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
    //    self.navigationItem.rightBarButtonItem = self.tmpRightBtn;
    //    self.navigationController.navigationBar.translucent = YES;
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    self.navigationItem.leftBarButtonItem = nil;
    [self.delegate EditViewClose];
    self.delegate = nil;
    
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
        [self makeToast:NSLocalizedString(@"Blank", nil)];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  PMCustomKeyboard.h
//  PunjabiKeyboard
//
//  Created by Kulpreet Chilana on 7/31/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kFont [UIFont fontWithName:@"GurmukhiMN" size:20]
#define kAltLabel @"叠加符"
#define kReturnLabel @"换行"
#define kSpaceLabel @"雅诗颜文字符输入法"
#define kChar @[ @"ლ", @"╹", @"◡", @"൬", @"▽", @"￣", @"♡", @"๑", @"ㄟ", @"∀", @"ω", @"3", @"」", @"┐", @"｢", @"∠", @"Ծ", @"ю", @"♪", @"✄", @"ひ", @"ڡ", @"₃", @"Σ", @"Д", @"□", @"⊙", @"༎ຶ", @"σ", @"｡" ]
#define kChar_shift @[ @"(", @")", @"<", @">", @"╮", @"╭", @"△", @"▽", @"↑", @"↓", @"←", @"→", @"↖", @"↗", @"↙", @"↘", @"´", @"｀", @"っ", @"c", @"/", @"＼", @"•́", @"•̀", @"=", @"≡", @"Ò", @"Ó", @"≧" ,@"≦" ]
#define kChar_alt @[ @"◌ੌ", @"◌ੈ", @"◌ਾ", @"◌ੀ", @"◌ੂ", @"◌ੋ", @"◌ੇ", @"◌੍", @"ਿ◌", @"◌ੁ", @"◌ੰ", @"◌ੱ", @"◌ਂ", @"!", @"@", @"#", @"$", @"%", @"^", @"&", @"*", @"〜", @":", @"─", @"+", @"॥", @"|", @",", @".", @"?" ]

@interface PMCustomKeyboard : UIView <UIInputViewAudioFeedback>

@property (strong, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@property (strong, nonatomic) IBOutlet UIButton *shiftButton;
@property (strong, nonatomic) IBOutlet UIButton *altButton;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong) id<UITextInput> textView;
@property (strong, nonatomic) IBOutlet UIButton *spaceButton;

- (IBAction)returnPressed:(id)sender;
- (IBAction)characterPressed:(id)sender;
- (IBAction)shiftPressed:(id)sender;
- (IBAction)altPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)unShift;
- (IBAction)spacePressed:(id)sender;

@end

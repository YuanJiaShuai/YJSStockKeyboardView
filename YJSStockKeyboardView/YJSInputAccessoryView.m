/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSInputAccessoryView.m
 # 创建时间   : 2021/5/8
 # 开发人员   : yjs
 # 摘要说明   : 设置输入框InputAccessoryView
 ****************************************************************
 ### Change Logs   **********************************************
 ****************************************************************
 ----------------------------------------------------------------
 # 更新日期   : <#更新日期#>
 # 开发人员   : <#开发者#>
 # 摘要说明   : <#摘要说明#>
 #
 ****************************************************************
 */

#import "YJSInputAccessoryView.h"

@interface YJSInputAccessoryView()

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *numberButton;
@property (strong, nonatomic) UIButton *abcButton;
@property (strong, nonatomic) UIButton *chineseButton;

@property (strong, nonatomic) UIButton *downButton;

@end

@implementation YJSInputAccessoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame withTextField:(UITextField *)textField{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
        self.textField = textField;
        
        [self addSubview:self.numberButton];
        [self addSubview:self.abcButton];
        [self addSubview:self.chineseButton];
        
        [self addSubview:self.downButton];
    }
    return self;
}

- (void)setKeyboardType:(YJSKeyboardViewType)keyboardType{
    if(self.numberButton.tag == keyboardType){
        self.numberButton.selected = YES;
        return;
    }
    
    if(self.abcButton.tag == keyboardType){
        self.abcButton.selected = YES;
        return;
    }
    
    if(self.chineseButton.tag == keyboardType){
        self.chineseButton.selected = YES;
        return;
    }
}

- (UIButton *)numberButton{
    if(!_numberButton){
        _numberButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 12, 57, 27)];
        _numberButton.tag = YJSKeyboardViewType_Custom_Number;
        _numberButton.backgroundColor = UIColor.whiteColor;
        _numberButton.layer.cornerRadius = 13.5;
        _numberButton.layer.masksToBounds = YES;
        [_numberButton setTitle:@"123" forState:UIControlStateNormal];
        _numberButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        [_numberButton setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
        [_numberButton setTitleColor:[UIColor colorWithRed:239.0/255 green:64.0/255 blue:52.0/255 alpha:1] forState:UIControlStateSelected];
        [_numberButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _numberButton;
}

- (UIButton *)abcButton{
    if(!_abcButton){
        _abcButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.numberButton.frame) + 13, 12, 57, 27)];
        _abcButton.tag = YJSKeyboardViewType_Custom_Abc;
        _abcButton.backgroundColor = UIColor.whiteColor;
        _abcButton.layer.cornerRadius = 13.5;
        _abcButton.layer.masksToBounds = YES;
        [_abcButton setTitle:@"ABC" forState:UIControlStateNormal];
        _abcButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        [_abcButton setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
        [_abcButton setTitleColor:[UIColor colorWithRed:239.0/255 green:64.0/255 blue:52.0/255 alpha:1] forState:UIControlStateSelected];
        [_abcButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _abcButton;
}

- (UIButton *)chineseButton{
    if(!_chineseButton){
        _chineseButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.abcButton.frame) + 13, 12, 57, 27)];
        _chineseButton.tag = YJSKeyboardViewType_System_Default;
        _chineseButton.backgroundColor = UIColor.whiteColor;
        _chineseButton.layer.cornerRadius = 13.5;
        _chineseButton.layer.masksToBounds = YES;
        [_chineseButton setTitle:@"中文" forState:UIControlStateNormal];
        _chineseButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        [_chineseButton setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
        [_chineseButton setTitleColor:[UIColor colorWithRed:239.0/255 green:64.0/255 blue:52.0/255 alpha:1] forState:UIControlStateSelected];
        [_chineseButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chineseButton;
}

- (UIButton *)downButton{
    if(!_downButton){
        _downButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 15, 20, 29)];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"YJSStockKeyboardView" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        [_downButton setImage:[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"down@2x" ofType:@"png"]] forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(downButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downButton;
}

- (void)buttonClickEvent:(UIButton *)sender{
    if(sender.tag == self.numberButton.tag){
        self.abcButton.selected = NO;
        self.chineseButton.selected = NO;
        self.numberButton.selected = YES;
        
    }else if(sender.tag == self.abcButton.tag){
        self.abcButton.selected = YES;
        self.chineseButton.selected = NO;
        self.numberButton.selected = NO;
        
    }else if(sender.tag == self.chineseButton.tag){
        self.abcButton.selected = NO;
        self.chineseButton.selected = YES;
        self.numberButton.selected = NO;
    }
    
    self.clickButtonHandle(sender.tag);
}

- (void)downButtonClickEvent:(UIButton *)sender{
    [self.nextResponder resignFirstResponder];
}

- (void)initiativeButtonClickEventWithKeyboardViewType:(YJSKeyboardViewType)keyboardType{
    if(keyboardType == self.numberButton.tag){
        [self.numberButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        return;
    }
    
    if(keyboardType == self.abcButton.tag){
        [self.abcButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        return;
    }
    
    if(keyboardType == self.chineseButton.tag){
        [self.chineseButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        return;
    }
}
@end

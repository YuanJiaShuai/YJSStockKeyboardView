/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardView.m
 # 创建时间   : 2021/5/8
 # 开发人员   : yjs
 # 摘要说明   : <#摘要说明#>
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

#import "YJSKeyboardView.h"
#import "YJSInputAccessoryView.h"
#import "YJSKeyboardNumberView.h"
#import "YJSKeyboardABCView.h"

static CGFloat YJSKeyboardViewHeight = 214;

@interface UITextField(YJSExtensin)

/**
 *  修改textField中的文字
 */
- (void)changeTextFieldText:(NSString *)text;

@end

@implementation UITextField (YJSExtensin)

/**
 *  修改textField中的文字
 */
- (void)changeTextFieldText:(NSString *)text {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    NSInteger startIndex = [self offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = self.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) { // 只删除一个字符
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            part1 = [part1 substringToIndex:(part1.length - 1)];
        } else {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    self.text = newText;
    
    // 重置光标位置
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
}

@end

@interface YJSKeyboardView()

@property (assign, nonatomic) YJSKeyboardViewType keyboardType;
@property (strong, nonatomic) YJSKeyboardNumberView *numberKeyboardView;
@property (strong, nonatomic) YJSKeyboardABCView *abcKeyboardView;
@property (strong, nonatomic) YJSInputAccessoryView *inputAccessoryView;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation YJSKeyboardView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
/**
 默认是加载数字键盘
 */
- (instancetype)initWithFrame:(CGRect)frame withTextField:(UITextField *)textField keyboardViewType:(YJSKeyboardViewType)keyboardViewType{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
        
        self.textField = textField;
        self.textField.returnKeyType = UIReturnKeySearch;
        self.keyboardType = keyboardViewType;
        
        self.numberKeyboardView = [YJSKeyboardNumberView keyboardWithFrame:CGRectMake(0, 0, frame.size.width, YJSKeyboardViewHeight)];
        
        self.abcKeyboardView = [YJSKeyboardABCView keyboardWithFrame:CGRectMake(0, 0, frame.size.width, YJSKeyboardViewHeight)];
        
        __weak __typeof(&*self)weakSelf = self;
        [self.numberKeyboardView setYJSKeyboardBlock:^(YJSCustomKeyboardButtonType buttonType, NSString * _Nonnull buttonText) {
            [weakSelf changeTextField:buttonType Text:buttonText];
        }];
        
        [self.abcKeyboardView setYJSKeyboardBlock:^(YJSCustomKeyboardButtonType buttonType, NSString * _Nonnull buttonText) {
            [weakSelf changeTextField:buttonType Text:buttonText];
        }];
        
        YJSKeyboardViewType keyboardType = [[NSUserDefaults standardUserDefaults] integerForKey:DefaultKeyboardTypeKey];
        
        if(keyboardType == YJSKeyboardViewType_Custom_Number){
            [self addSubview:self.numberKeyboardView];
            self.textField.inputView = self;
        }else if(keyboardType == YJSKeyboardViewType_Custom_Abc){
            [self addSubview:self.abcKeyboardView];
            self.textField.inputView = self;
        }else if(keyboardType == YJSKeyboardViewType_System_Default){
            self.textField.keyboardType = UIKeyboardTypeDefault;
        }
        
        YJSInputAccessoryView *inputAccessoryView = [[YJSInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 50) withTextField:textField];
        inputAccessoryView.keyboardType = keyboardType;
        inputAccessoryView.cacheCustomKeyboard = @{};
        inputAccessoryView.clickButtonHandle = ^(YJSKeyboardViewType type) {
            [[NSUserDefaults standardUserDefaults] setInteger:type forKey:DefaultKeyboardTypeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            switch (type) {
                case YJSKeyboardViewType_Custom_Number:{
                    if(![self.numberKeyboardView isDescendantOfView:self]){
                        [self addSubview:self.numberKeyboardView];
                        self.textField.inputView = self;
                        [self.textField reloadInputViews];
                    }
                    break;
                }
                case YJSKeyboardViewType_Custom_Abc:{
                    if([self.numberKeyboardView isDescendantOfView:self]){
                        [self.numberKeyboardView removeFromSuperview];
                        [self addSubview:self.abcKeyboardView];
                        if(self.textField.inputView == nil){
                            self.textField.inputView = self;
                        }
                        [self.textField reloadInputViews];
                    }else{
                        [self addSubview:self.abcKeyboardView];
                        if(self.textField.inputView == nil){
                            self.textField.inputView = self;
                            [self.textField reloadInputViews];
                        }
                    }
                    break;
                }
                case YJSKeyboardViewType_System_Default:{
                    if([self.numberKeyboardView isDescendantOfView:self]){
                        [self.numberKeyboardView removeFromSuperview];
                        self.textField.inputView = nil;
                        [self.textField reloadInputViews];
                    }else if([self.abcKeyboardView isDescendantOfView:self]){
                        [self.abcKeyboardView removeFromSuperview];
                        self.textField.inputView = nil;
                        [self.textField reloadInputViews];
                    }
                    
                    self.textField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                default:
                    break;
            }
        };
        self.inputAccessoryView = inputAccessoryView;
        self.textField.inputAccessoryView = inputAccessoryView;
    }
    return self;
}

+ (YJSKeyboardView *)directToReverseTextFiledInputView:(UITextField *)textField keyboardViewType:(YJSKeyboardViewType)keyboardViewType{
    YJSKeyboardView *keyboardView = [[YJSKeyboardView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, YJSKeyboardViewHeight + [YJSKeyboardView safeAreaInsetsForDeviceWithNotch].bottom) withTextField:textField keyboardViewType:keyboardViewType];
    return keyboardView;
}

- (void)changeTextField:(YJSCustomKeyboardButtonType)type Text:(NSString *)text {
    switch (type) {
        case YJSCustomKeyboardButtonType_Del:
        case YJSCustomKeyboardButtonType_Other:
            [self.textField changeTextFieldText:text];
            break;
        case YJSCustomKeyboardButtonType_Done:
        case YJSCustomKeyboardButtonType_Hidden:
            [self.nextResponder resignFirstResponder];
            break;
        case YJSCustomKeyboardButtonType_Clear:
            self.textField.text = @"";
            break;
        case YJSCustomKeyboardButtonType_Earth:
            break;
        case YJSCustomKeyboardButtonType_Switch:{
            [self.inputAccessoryView initiativeButtonClickEventWithKeyboardViewType:YJSKeyboardViewType_Custom_Number];
            break;
        }
        case YJSCustomKeyboardButtonType_Space:
            [self.textField changeTextFieldText:@" "];
            break;
    }
}

/// 返回安全区域高度
+ (UIEdgeInsets)safeAreaInsetsForDeviceWithNotch{
    if (@available(iOS 11.0, *)) {
        CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        if(height > 0){
            UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
            
            switch (orientation) {
                case UIInterfaceOrientationPortrait:
                    return UIEdgeInsetsMake(44, 0, 34, 0);
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                    return UIEdgeInsetsMake(34, 0, 44, 0);
                    
                case UIInterfaceOrientationLandscapeLeft:
                case UIInterfaceOrientationLandscapeRight:
                    return UIEdgeInsetsMake(0, 44, 21, 44);
                    
                case UIInterfaceOrientationUnknown:
                default:
                    return UIEdgeInsetsMake(44, 0, 34, 0);
            }
        }else{
            return UIEdgeInsetsZero;
        }
    } else {
        return UIEdgeInsetsZero;
    }
}

@end

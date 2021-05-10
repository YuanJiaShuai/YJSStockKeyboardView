/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardNumberView.m
 # 创建时间   : 2021/5/8
 # 开发人员   : yjs
 # 摘要说明   : 自定义数字键盘
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

#import "YJSKeyboardNumberView.h"
#import "YJSKeyboardButton.h"

static NSInteger const YJSKeyboardNumberDelIndex = 4;
static NSInteger const YJSKeyboardNumberHidden = 9;
static NSInteger const YJSKeyboardNumberClear = 14;
static NSInteger const YJSKeyboardNumberDoneIndex = 19;

@interface YJSKeyboardNumberView()

@property (copy, nonatomic) YJSKeyboardBlock block;

@property (strong, nonatomic) NSTimer *delTimer;

@end

@implementation YJSKeyboardNumberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    NSArray *numbers = @[@"600", @"1", @"2", @"3", @"删除", @"601", @"4", @"5", @"6", @"隐藏", @"000", @"7", @"8", @"9", @"清空", @"300", @"002", @"603", @"0", @"确定"];
    
    //4行
    int row = 4;
    //5列
    int column = 5;
    //间距
    int spacing = 6;
    //上下边距
    int vMargin = 15;
    //左右边距
    int hMargin = 10;
    
    CGFloat width = (frame.size.width - hMargin * 2 - spacing * 4)/column;
    CGFloat height = (frame.size.height - vMargin * 2 - spacing * 3)/row;
    
    int x = 0;
    int y = 0;
    for(int i = 0; i < numbers.count; i++){
        YJSKeyboardButton *button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(hMargin + x * (width + spacing), vMargin + y * (height + spacing), width, height)];
        __weak __typeof(&*self)weakSelf = self;
        [button setButtonClickBlock:^(YJSCustomKeyboardButtonType buttonType, NSString * _Nonnull text) {
            weakSelf.block(buttonType, text);
        }];
        [button setTitle:numbers[i] forState:UIControlStateNormal];
        if([@"0123456789" rangeOfString:numbers[i]].location != NSNotFound){
            button.backgroundColor = UIColor.whiteColor;
        }else{
            button.backgroundColor = [UIColor colorWithRed:192.0/255 green:195.0/255 blue:195.0/255 alpha:201.0/255];
        }
        
        if (i == YJSKeyboardNumberDelIndex) {
            button.type = YJSCustomKeyboardButtonType_Del;
            [button setTitle:@"" forState:UIControlStateNormal];
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSURL *url = [bundle URLForResource:@"YJSStockKeyboardView" withExtension:@"bundle"];
            NSBundle *imageBundle = [NSBundle bundleWithURL:url];
            
            [button setImage:[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"keyboard_delete@2x" ofType:@"png"]] forState:UIControlStateNormal];
            
            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureEvent:)];
            longPressGesture.minimumPressDuration = 0.4;
            [button addGestureRecognizer:longPressGesture];
        } else if (i == YJSKeyboardNumberHidden) {
            button.type = YJSCustomKeyboardButtonType_Hidden;
        }else if (i == YJSKeyboardNumberClear){
            button.type = YJSCustomKeyboardButtonType_Clear;
        }else if (i == YJSKeyboardNumberDoneIndex){
            button.type = YJSCustomKeyboardButtonType_Done;
        }else{
            button.type = YJSCustomKeyboardButtonType_Other;
        }
        [self addSubview:button];
        
        x++;
        if ((i + 1) % column == 0) {
            x = 0;
            y++;
        }
    }
}

- (void)longPressGestureEvent:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        self.delTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(delTimerEvent:) userInfo:nil repeats:YES];
        [self.delTimer fire];
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        if(self.delTimer){
            [self.delTimer invalidate];
            self.delTimer = nil;
        }
    }
}

- (void)delTimerEvent:(NSTimer *)sender{
    self.block(YJSCustomKeyboardButtonType_Del, @"");
}

@end

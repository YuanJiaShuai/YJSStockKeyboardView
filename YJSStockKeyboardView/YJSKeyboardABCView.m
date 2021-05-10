/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardABCView.m
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

#import "YJSKeyboardABCView.h"
#import "YJSKeyboardButton.h"

static NSInteger const YJSKeyboardNumberEarthIndex = 19;
static NSInteger const YJSKeyboardNumberDelIndex = 27;
static NSInteger const YJSKeyboardNumberSwitch = 28;
static NSInteger const YJSKeyboardNumberSpace = 29;
static NSInteger const YJSKeyboardNumberDoneIndex = 30;

@interface YJSKeyboardABCView()

@property (copy, nonatomic) YJSKeyboardBlock block;

@property (strong, nonatomic) NSTimer *delTimer;

@end

@implementation YJSKeyboardABCView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    NSArray *numbers = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P",
    @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L",
    @"🌍", @"Z", @"X", @"C", @"V", @"B", @"N", @"M", @"删除",
    @"123", @"空格", @"确定"];
    
    //4行
    int row = 4;
    //水平间距
    int spacing = 6;
    //垂直间距
    int vSpacing = 10;
    //上下边距
    int vMargin = 10;
    
    CGFloat abcWidth = (self.frame.size.width - spacing * 11)/10;
    CGFloat height = (self.frame.size.height - vMargin * 2 - vSpacing * 3)/row;
    CGFloat downWidth = 85;
    CGFloat delWidth = height;
    
    int x = 0;
    int y = 0;
    for(int i = 0; i < numbers.count; i++){
        YJSKeyboardButton *button;
        if(i <= 9){
            button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(spacing + x * abcWidth + x * spacing, vMargin, abcWidth, height)];
            button.backgroundColor = UIColor.whiteColor;
            x++;
            
        }else if(i <= 18 && i > 9){
            if(i == 10){
                x = 0;
                y++;
            }
            
            button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(25 + x * abcWidth + x * spacing, height * y + y * vSpacing + spacing, abcWidth, height)];
            button.backgroundColor = UIColor.whiteColor;
            x++;
            
        }else if(i <= 27 && i > 18){
            if(i == 19){
                x = 0;
                y++;
                //地球按钮
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(spacing + x * height + x * spacing, height * y + y * vSpacing + spacing, delWidth, height)];
                button.backgroundColor = [UIColor colorWithRed:192.0/255 green:195.0/255 blue:195.0/255 alpha:201.0/255];
            }else if(i == 27){
                //删除按钮
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(self.frame.size.width - spacing - height, height * y + y * vSpacing + spacing, delWidth, height)];
                button.backgroundColor = [UIColor colorWithRed:192.0/255 green:195.0/255 blue:195.0/255 alpha:201.0/255];
            }else{
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(spacing + height + 15 + (x - 1) * (abcWidth + spacing), height * y + y * vSpacing + spacing, abcWidth, height)];
                button.backgroundColor = UIColor.whiteColor;
            }
            x++;
        }else{
            if(i == 28){
                x = 0;
                y++;
                
                //123 按钮
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(spacing + x * height + x * spacing, height * y + y * vSpacing + spacing, downWidth, height)];
                button.backgroundColor = [UIColor colorWithRed:192.0/255 green:195.0/255 blue:195.0/255 alpha:201.0/255];
            }else if(i == 29){
                //空格按钮
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(spacing + x * downWidth + x * spacing, height * y + y * vSpacing + spacing, self.frame.size.width - 2 * downWidth - 4 * spacing, height)];
                button.backgroundColor = UIColor.whiteColor;
            }else{
                //确定按钮
                button = [[YJSKeyboardButton alloc]initKeyButtonWithFrame:CGRectMake(self.frame.size.width - spacing - downWidth, height * y + y * vSpacing + spacing, downWidth, height)];
                button.backgroundColor = [UIColor colorWithRed:192.0/255 green:195.0/255 blue:195.0/255 alpha:201.0/255];
            }
            x++;
        }
        [button setTitle:numbers[i] forState:UIControlStateNormal];
        __weak __typeof(&*self)weakSelf = self;
        [button setButtonClickBlock:^(YJSCustomKeyboardButtonType buttonType, NSString * _Nonnull text) {
            weakSelf.block(buttonType, text);
        }];
        
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
        } else if (i == YJSKeyboardNumberEarthIndex) {
            button.type = YJSCustomKeyboardButtonType_Earth;
            [button setTitle:@"" forState:UIControlStateNormal];
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSURL *url = [bundle URLForResource:@"YJSStockKeyboardView" withExtension:@"bundle"];
            NSBundle *imageBundle = [NSBundle bundleWithURL:url];
            
            [button setImage:[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"shift@2x" ofType:@"png"]] forState:UIControlStateNormal];
        }else if (i == YJSKeyboardNumberSwitch){
            button.type = YJSCustomKeyboardButtonType_Switch;
        }else if (i == YJSKeyboardNumberDoneIndex){
            button.type = YJSCustomKeyboardButtonType_Done;
        }else if(i == YJSKeyboardNumberSpace){
            button.type = YJSCustomKeyboardButtonType_Space;
        }else{
            button.type = YJSCustomKeyboardButtonType_Other;
        }
        [self addSubview:button];
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

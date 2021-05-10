/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardBaseView.m
 # 创建时间   : 2021/5/8
 # 开发人员   : yjs
 # 摘要说明   : 自定义键盘基础试图
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

#import "YJSKeyboardBaseView.h"

@interface YJSKeyboardBaseView()

@property (copy, nonatomic) YJSKeyboardBlock block;

@end

@implementation YJSKeyboardBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initKeyboardWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    }
    return self;
}

+ (instancetype)keyboardWithFrame:(CGRect)frame{
    return [[self alloc] initKeyboardWithFrame:frame];
}

- (void)setYJSKeyboardBlock:(YJSKeyboardBlock)block{
    self.block = block;
}

@end

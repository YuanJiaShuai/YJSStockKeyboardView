/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardButton.m
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

#import "YJSKeyboardButton.h"

@interface UIImage(YJSExtension)

/// 颜色转图片
/// @param color color
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end

@implementation UIImage (YJSExtensin)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

@interface YJSKeyboardButton()

@property (copy, nonatomic) buttonClickBlock block;

@end

@implementation YJSKeyboardButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+ (instancetype)keyButtonWithFrame:(CGRect)frame {
    return [[self alloc] initKeyButtonWithFrame:frame];
}

- (instancetype)initKeyButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        [self setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        
        [self setBackgroundImage:[UIImage createImageWithColor:[UIColor.blackColor colorWithAlphaComponent:0.5]] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(keyClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setButtonClickBlock:(buttonClickBlock)block {
    self.block = block;
}

- (void)keyClicked:(YJSKeyboardButton *)button {
    NSString *text = @"";
    if (self.type == YJSCustomKeyboardButtonType_Other) {
        text = button.titleLabel.text;
    }
    self.block(self.type, text);
}

@end

/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardButton.h
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

#import <UIKit/UIKit.h>
#import "YJSKeyboardDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^buttonClickBlock)(YJSCustomKeyboardButtonType buttonType, NSString *text);

@interface YJSKeyboardButton : UIButton

@property (assign, nonatomic) YJSCustomKeyboardButtonType type;

+ (instancetype)keyButtonWithFrame:(CGRect)frame;

- (instancetype)initKeyButtonWithFrame:(CGRect)frame;

- (void)setButtonClickBlock:(buttonClickBlock)block;

@end

NS_ASSUME_NONNULL_END

/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardBaseView.h
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

/**
 按钮点击回掉
 */
typedef void (^YJSKeyboardBlock)(YJSCustomKeyboardButtonType buttonType, NSString *buttonText);

@interface YJSKeyboardBaseView : UIView

/// 初始化
/// @param frame frame
- (instancetype)initKeyboardWithFrame:(CGRect)frame;

/// 初始化
/// @param frame frame
+ (instancetype)keyboardWithFrame:(CGRect)frame;

/// 设置回掉
/// @param block block
- (void)setYJSKeyboardBlock:(YJSKeyboardBlock)block;

@end

NS_ASSUME_NONNULL_END

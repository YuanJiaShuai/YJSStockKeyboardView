/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSKeyboardView.h
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

@interface YJSKeyboardView : UIView

/// 键盘注入
/// @param textField textField
+ (YJSKeyboardView *)directToReverseTextFiledInputView:(UITextField *)textField keyboardViewType:(YJSKeyboardViewType)keyboardViewType;

@end

NS_ASSUME_NONNULL_END

/*
 ****************************************************************
 # Copyright © 2021年 ___ORGANIZATIONNAME___. All rights reserved.
 #
 # 文件名称   : YJSInputAccessoryView.h
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

@interface YJSInputAccessoryView : UIView

/// 初始化键盘选择试图
/// @param frame frame
/// @param textField textField
- (instancetype)initWithFrame:(CGRect)frame withTextField:(UITextField *)textField;

/// 存储自定义键盘
@property (strong, nonatomic) NSDictionary *cacheCustomKeyboard;

/// 当前键盘类型
@property (assign, nonatomic) YJSKeyboardViewType keyboardType;

/// 点击切换键盘按钮回掉
@property (copy, nonatomic) void(^clickButtonHandle)(YJSKeyboardViewType type);

/// 主动促发按钮点击世界
/// @param keyboardType 键盘类型
- (void)initiativeButtonClickEventWithKeyboardViewType:(YJSKeyboardViewType)keyboardType;

@end

NS_ASSUME_NONNULL_END

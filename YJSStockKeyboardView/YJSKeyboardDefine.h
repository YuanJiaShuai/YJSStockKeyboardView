//
//  YJSKeyboardDefine.h
//  KeyBoardDemo
//
//  Created by yjs on 2021/5/8.
//

#ifndef YJSKeyboardDefine_h
#define YJSKeyboardDefine_h

/**
 键盘类型
 */
typedef NS_ENUM (NSInteger, YJSKeyboardViewType){
    /**
     自定义数字键盘「默认显示」
     */
    YJSKeyboardViewType_Custom_Number = 0,
    /**
     自定义字母键盘
     */
    YJSKeyboardViewType_Custom_Abc = 1,
    /**
     系统键盘 默认
     */
    YJSKeyboardViewType_System_Default = 2
};

/**
 自定义键盘按钮类型
 */
typedef NS_ENUM (NSInteger, YJSCustomKeyboardButtonType){
    /**
     删除
     */
    YJSCustomKeyboardButtonType_Del,
    /**
     完成
     */
    YJSCustomKeyboardButtonType_Done,
    /**
     正常类型
     */
    YJSCustomKeyboardButtonType_Other,
    /**
     清空
     */
    YJSCustomKeyboardButtonType_Clear,
    /**
     隐藏
     */
    YJSCustomKeyboardButtonType_Hidden,
    /**
     地球
     */
    YJSCustomKeyboardButtonType_Earth,
    /**
     转换
     */
    YJSCustomKeyboardButtonType_Switch,
    /**
     空格
     */
    YJSCustomKeyboardButtonType_Space,
};

/**
 缓存当前显示的键盘类型Key
 */
static NSString * const DefaultKeyboardTypeKey = @"DefaultKeyboardTypeKey";
#endif /* YJSKeyboardDefine_h */


//
//  CYExtension.h
//  JustJokes
//
//  Created by cy on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#ifndef __CYCategoriesMacro_h
#define __CYCategoriesMacro_h

#import "CYKit.h"

#ifndef CY_SWAP
#define CY_SWap(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif



#ifdef DEBUG
#    define kDebugLog(...)   NSLog(__VA_ARGS__)
#    define kDebugMethod(...)   NSLog(@"%s", __func__) // 打印当前所在func
#else
#    define kDebugLog(...)
#    define kDebugMethod(...)
#endif

#ifdef DEBUG
#define CYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define CYLog(...)
#endif

#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#define EMPTY_STRING        @""
#define STR(key)            NSLocalizedString(key, nil)

#define CYWeakSelf(type)    __weak typeof(type) weak##type = type;
#define CYStrongSelf(type)  __strong typeof(type) type = weak##type;

/** 文件路径 */
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/// App名称
#define AppName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
/// App版本号 e.g. 1.1.0
#define AppVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
/// App build版本号 e.g. 1.1.0
#define AppBuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
/// App BundleIdentifier e.g. com.baidu.test
#define AppBundleIdentifier [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]

/** 屏幕宽高 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define kScreenW ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kScreenH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kScreenS ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
#define kScreenS [UIScreen mainScreen].bounds.size
#endif

#define kUnTranslucentFrame CGRectMake(0, 0, kScreenW, kScreenH-64)

/** 提示框 */
#define ShowMsg(_msg) [[[CYKit alloc] init] ToastMessage:_msg]

//是否为iPad界面
#define kIsIpad [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad
//是否为iPhone界面
#define kIsIphone [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone

/** 判断系统版本 */
#define kIsIos5 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 5.0)

#define kIsPriorIos6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)

#define kIsIos7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define kIsIos8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kIsIos9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define kIsIos10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/** 判断屏幕尺寸 */
#define kIsScreen3_5 ([[UIScreen mainScreen] bounds].size.height == 480.0 && [[UIScreen mainScreen] bounds].size.width == 320.0)

#define kIsScreen4 ([[UIScreen mainScreen] bounds].size.height == 568.0 && [[UIScreen mainScreen] bounds].size.width == 320.0)

#define kIsScreen4_7 ([[UIScreen mainScreen] bounds].size.height == 667.0 && [[UIScreen mainScreen] bounds].size.width == 375.0)

#define kIsScreen5_5 ([[UIScreen mainScreen] bounds].size.height == 736.0 && [[UIScreen mainScreen] bounds].size.width == 414.0)

/** 是不是Retina */
#define kIsRetina ([[UIScreen mainScreen] scale] >= 2.0)


#define kDEVICE_LATER_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0f, 1136.0f), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDEVICE_LATER_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750.0f, 1334.0f), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDEVICE_LATER_IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242.0f, 2208.0f), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDEVICE_5_DIFFERENCE (88.0f)

// 这里是弱引用强引用
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __weak_##x##__; \\
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __block_##x##__; \\
_Pragma("clang diagnostic pop")

#endif
#endif

#endif

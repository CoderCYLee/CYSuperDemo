//
//  UIDevice+CY.h
//  JustJokes
//
//  Created by 李春阳 on 15/4/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CY)

/**
 返回设备的mac地址
 */
+ (NSString*)macAddress;

/**
 *  判断设备是否越狱
 *
 *  @return 是否越狱
 */
+ (BOOL)deviceIsJailBreak;

@end

//
//  UIImage+Extension.h
//  WeiFantasy
//
//  Created by 李春阳 on 15/3/27.
//  Copyright (c) 2015年 Coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CY)

/**
 *  用颜色生成图片
 *
 *  @param color 颜色
 *
 *  @return  UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)resizedImage:(NSString *)name;

// 虚线边框
+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

/** 旋转图片 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end

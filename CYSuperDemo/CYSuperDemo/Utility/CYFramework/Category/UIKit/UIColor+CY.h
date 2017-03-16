//
//  UIColor+CY.h
//  JustJokes
//
//  Created by 李春阳 on 15/4/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kRGBColor16Bit(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (CY)

/**
 *  HexColor
 *
 *  hexString
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString: (NSString *) hexString;
/**
 *  已知颜色，返回 [r,g,b,a]
 */
+ (NSString*)stringWithColor:(UIColor*)color;
/**
 *  随机色
 *
 *  @return UIcolor
 */
+ (UIColor *)randomColor;

@end

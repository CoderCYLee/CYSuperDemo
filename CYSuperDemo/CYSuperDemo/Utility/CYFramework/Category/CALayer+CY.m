//
//  CALayer+CY.m
//  YinJi
//
//  Created by 李春阳 on 15/12/4.
//  Copyright © 2015年 FutureStar. All rights reserved.
//

#import "CALayer+CY.h"

@implementation CALayer (CY)

- (void)cy_setShadowWithOffSet:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity
{
    self.shadowOffset = shadowOffset; //设置阴影的偏移量
    self.shadowRadius = shadowRadius;  //设置阴影的半径
    self.shadowColor = shadowColor.CGColor; //设置阴影的颜色为黑色
    self.shadowOpacity = shadowOpacity;
}

@end

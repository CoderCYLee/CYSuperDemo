//
//  UILabel+CY.m
//  YinJi
//
//  Created by cy on 15/12/31.
//  Copyright © 2015年 FutureStar. All rights reserved.
//

#import "UILabel+CY.h"

@implementation UILabel (CY)

- (void)cy_setText:(NSString *)text textColor:(UIColor *)color
{
    self.text = text;
    self.textColor = color;
}

- (void)cy_setBoderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

@end

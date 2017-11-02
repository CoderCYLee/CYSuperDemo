//
//  CALayer+CY.h
//  YinJi
//
//  Created by cy on 15/12/4.
//  Copyright © 2015年 FutureStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (CY)

/** 设置阴影 */
- (void)cy_setShadowWithOffSet:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOpacity:(float)shadowOpacity;

@end

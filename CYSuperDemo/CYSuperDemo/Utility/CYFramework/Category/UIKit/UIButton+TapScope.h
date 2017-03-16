//
//  UIButton+TapScope.h
//  SuningSummer
//
//  Created by CY on 15-8-15.
//  Copyright (c) 2014年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TapScope)

/**
 *  扩大按钮的点击范围（insets必须不被button的superview给挡住）
 */
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

@end

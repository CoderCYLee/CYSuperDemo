//
//  UIButton+CYRoundTouch.m
//  mkmy
//
//  Created by Cyrill on 2016/4/14.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "UIButton+CYRoundTouch.h"
#import <objc/runtime.h>

const void *CYRoundTouchEnableKey = &CYRoundTouchEnableKey;

@implementation UIButton (CYRoundTouch)

- (BOOL)roundTouchEnable {
    return [objc_getAssociatedObject(self, CYRoundTouchEnableKey) boolValue];
}

- (void)setRoundTouchEnable:(BOOL)roundTouchEnable {
    objc_setAssociatedObject(self, CYRoundTouchEnableKey, @(roundTouchEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)replacePointInside: (CGPoint)point withEvent: (UIEvent *)event {
    if (CGRectGetWidth(self.frame) != CGRectGetHeight(self.frame)
        || !self.roundTouchEnable)
    {
        return [super pointInside: point withEvent: event];
    }
    CGFloat radius = CGRectGetWidth(self.frame) / 2;
    CGPoint offset = CGPointMake(point.x - radius, point.y - radius);
    return sqrt(offset.x * offset.x + offset.y * offset.y) <= radius;
}

// 替换方法实现
+ (void)initialize {
    [super initialize];
    Method replaceMethod = class_getInstanceMethod([self class], @selector(replacePointInside:withEvent:));
    Method originMethod = class_getInstanceMethod([self class], @selector(pointInside:withEvent:));
    method_setImplementation(originMethod, method_getImplementation(replaceMethod));
}

@end

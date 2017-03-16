//
//  UIButton+TapScope.m
//  SuningSummer
//
//  Created by CY on 15-8-15.
//  Copyright (c) 2014年 Cyrill. All rights reserved.
//

#import "UIButton+TapScope.h"
#import <objc/runtime.h>

static void * kHitEdgeInsetsKey = &kHitEdgeInsetsKey;

@implementation UIButton (TapScope)

- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:hitEdgeInsets];
    objc_setAssociatedObject(self, kHitEdgeInsetsKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitEdgeInsets
{
    NSValue * value = objc_getAssociatedObject(self, kHitEdgeInsetsKey);
    if(value) {
        return [value UIEdgeInsetsValue];
    }
    
    return UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.hitEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}


@end

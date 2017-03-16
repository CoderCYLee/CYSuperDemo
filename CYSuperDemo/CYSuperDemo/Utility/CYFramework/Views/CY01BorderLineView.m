//
//  CY01BorderLineView.m
//  CY01BorderLineView
//
//  Created by Cyrill on 2015/10/21.
//  Copyright © 2015年 Cyrill. All rights reserved.
//

#import "CY01BorderLineView.h"

@implementation CY01BorderLineView


- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLayoutAttribute layoutAttribute = self.isHorizontal ? NSLayoutAttributeHeight : NSLayoutAttributeWidth;
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        
        if (constraint.firstItem == self && constraint.firstAttribute == layoutAttribute) {
            [self removeConstraint:constraint];
            constraint.constant = 1 / [UIScreen mainScreen].scale;
            [self addConstraint:constraint];
        }
    }
    
}

@end

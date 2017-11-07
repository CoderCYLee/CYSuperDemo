//
//  UIView+CYBoom.h
//  CYSuperDemo
//
//  Created by Cyrill on 2017/11/7.
//  Copyright © 2017年 Cyrill. All rights reserved.
//
// 爆炸动画
// 来自： https://github.com/afantree/BoomAnimation
// 使用起来类似这样
/*
 - (IBAction)boomAction:(UIButton *)sender {
     [sender boomWithTileSize:CGSizeMake(2, 2) inDiameter:300];
     sender.hidden = YES;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     sender.hidden = NO;
     });
 }
 */

#import <UIKit/UIKit.h>

@interface UIView (CYBoom) <CAAnimationDelegate>

- (void)boomWithTileSize:(CGSize)size inDiameter:(CGFloat)diameter;

@end

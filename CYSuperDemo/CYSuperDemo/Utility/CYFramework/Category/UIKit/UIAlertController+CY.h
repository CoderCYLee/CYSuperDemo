//
//  UIAlertController+CY.h
//  YinJi
//
//  Created by Cyrill on 16/4/20.
//  Copyright © 2016年 FutureStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CY)

+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction *action))cancelBlock submitTitle:(NSString *)submitTitle submitBlock:(void (^)(UIAlertAction *action))submitBlock completedBlock:(void (^)(void))completedBlock;

+ (void)defaultAlert:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void (^)(UIAlertAction * ))cancelBlock completedBlock:(void (^)(void))completedBlock;

+ (UIViewController*)lastPresentedViewController;


@end

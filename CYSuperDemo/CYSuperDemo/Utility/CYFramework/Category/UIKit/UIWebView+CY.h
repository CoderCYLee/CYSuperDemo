//
//  UIWebView+CY.h
//  CYSuperDemo
//
//  Created by Cyrill on 2017/11/2.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (CY)

- (NSString *)documentTitle;
- (void)fixViewPort;    //网页content自适应
- (void)cleanBackground;    //清除默认的背景高光

@end

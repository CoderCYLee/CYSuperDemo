//
//  UIWebView+CY.m
//  CYSuperDemo
//
//  Created by Cyrill on 2017/11/2.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "UIWebView+CY.h"
#import "NSArray+CY.h"

@implementation UIWebView (CY)

- (NSString *)documentTitle
{
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)fixViewPort
{
    //适应客户端页面
    NSString* js =
    @"var meta = document.createElement('meta'); "
    "meta.setAttribute( 'name', 'viewport' ); "
    "meta.setAttribute( 'content', 'width = device-width' ); "
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    
    [self stringByEvaluatingJavaScriptFromString: js];
}

- (void)cleanBackground
{
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in [[[self subviews] safeObjectAtIndex:0] subviews])
    {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}

@end

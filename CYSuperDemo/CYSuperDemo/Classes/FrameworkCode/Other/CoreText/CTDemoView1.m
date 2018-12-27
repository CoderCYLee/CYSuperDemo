//
//  CTDemoView1.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CTDemoView1.h"
#import <CoreText/CoreText.h>

@implementation CTDemoView1


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    
}

- (void)test1:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    // 设置绘制内容
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:
                                     @"CoreText是用于处理文字和字体的底层技术。"
                                     "它直接和Core Graphics(又被称为Quartz)打交道。"
                                     "Quartz是一个2D图形渲染引擎，能够处理OSX和iOS中图形显示问题。"
                                     "Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。"
                                     "因此CoreText为了排版，需要将显示的文字内容、位置、字体、字形直接传递给Quartz。"
                                     "与其他UI组件相比，由于CoreText直接和Quartz来交互，所以它具有更高效的排版功能。"];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, NULL);
    
    // 开始绘制
    CTFrameDraw(frame, context);
    
    // 释放
    CFRelease(frame);
    CFRelease(frameSetter);
    CFRelease(path);
}

@end

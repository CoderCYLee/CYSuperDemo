//
//  CTFrameParserConfig.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//
//  用于配置绘制的参数，例如文字颜色、大小、行间距等
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParserConfig : NSObject

//配置属性
@property (nonatomic ,assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;

@end

NS_ASSUME_NONNULL_END

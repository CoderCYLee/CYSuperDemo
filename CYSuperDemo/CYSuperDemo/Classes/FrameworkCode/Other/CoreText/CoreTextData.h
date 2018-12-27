//
//  CoreTextData.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//
//  用于保存由CTFrameParser类生成的CTFrameRef实例，以及CTFrameRef实际绘制需要的高度
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;

//新增加的成员
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *linkArray;

@end

NS_ASSUME_NONNULL_END

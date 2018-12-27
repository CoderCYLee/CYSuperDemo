//
//  CTFrameParser.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//
//  用于生成最后绘制界面需要的CTFrameRef实例
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"

@class CTFrameParserConfig;

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParser : NSObject

/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 *
 */
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

/**
 *  配置信息格式化
 *
 *  @param config 配置信息
 */
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;


//=======================================================================================================//


/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 */
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;

/**
 *  给内容设置配置信息
 *
 *  @param path   模板文件路径
 *  @param config 配置信息
 */
+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;

@end

NS_ASSUME_NONNULL_END

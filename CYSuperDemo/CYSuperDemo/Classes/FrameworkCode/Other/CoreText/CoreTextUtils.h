//
//  CoreTextUtils.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextUtils : NSObject

/**
 *  检测点击位置是否在链接上
 *
 *  @param view  点击区域
 *  @param point 点击坐标
 *  @param data  数据源
 */
+(CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end

NS_ASSUME_NONNULL_END

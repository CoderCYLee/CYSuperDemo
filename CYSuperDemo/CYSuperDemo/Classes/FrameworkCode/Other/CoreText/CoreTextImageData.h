//
//  CoreTextImageData.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextImageData : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat position;
@property (nonatomic, assign) CGRect imagePostion;

@end

NS_ASSUME_NONNULL_END

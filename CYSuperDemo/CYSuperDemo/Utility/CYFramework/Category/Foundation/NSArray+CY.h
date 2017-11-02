//
//  NSArray+CY.h
//  JustJokes
//
//  Created by cy on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CY)

/**
 *  比较字符串 相同返回YES,不同返回NO
 */
- (BOOL)containsString:(NSString*)string;

/**
 *  安全数组中的元素
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)deepCopy;
- (id)mutableDeepCopy;

- (id)trueDeepCopy;
- (id)trueDeepMutableCopy;

@end

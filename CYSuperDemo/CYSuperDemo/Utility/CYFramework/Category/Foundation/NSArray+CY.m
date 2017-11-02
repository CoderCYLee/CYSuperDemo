//
//  NSArray+CY.m
//  JustJokes
//
//  Created by cy on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import "NSArray+CY.h"

@implementation NSArray (CY)

/**
 *  比较字符串 相同返回YES,不同返回NO
 */
- (BOOL)containsString:(NSString *)string
{
    for (NSString *str in self) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

/**
 *  安全数组中的元素
 */
- (id)safeObjectAtIndex:(NSUInteger)index
{
    if ( index >= self.count ) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

- (id)deepCopy
{
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

- (id)mutableDeepCopy
{
    return [[NSMutableArray alloc] initWithArray:self copyItems:YES];
}

- (id)trueDeepCopy
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

- (id)trueDeepMutableCopy
{
    return [[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]] mutableCopy];
}

@end

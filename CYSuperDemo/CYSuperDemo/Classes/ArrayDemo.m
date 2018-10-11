//
//  ArrayDemo.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/10/8.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ArrayDemo.h"

@implementation ArrayDemo

- (void)test {
    NSArray *array = @[@"John Appleseed", @"Tim Cook", @"Hair Force One", @"Michael Jurewitz"];
    NSArray *reverseArray = [[array reverseObjectEnumerator] allObjects];
    NSArray *sortArray = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSArray *numbers = @[@9, @5, @11, @3, @1];
    NSArray *sortedNumbers = [numbers sortedArrayUsingSelector:@selector(compare:)];
}

@end

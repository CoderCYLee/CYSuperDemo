//
//  NSData+CY.h
//  YinJi
//
//  Created by 李春阳 on 15/12/15.
//  Copyright © 2015年 FutureStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CY)

+ (NSData *)returnDataWithObjc:(id)objv forKey:(NSString *)key;

- (NSString *)SHA256String;

@end

//
//  NSData+CY.m
//  YinJi
//
//  Created by cy on 15/12/15.
//  Copyright © 2015年 FutureStar. All rights reserved.
//

#import "NSData+CY.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (CY)

+ (NSData*)returnDataWithObjc:(nullable id)objv forKey:(NSString *)key
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:objv forKey:key];
    [archiver finishEncoding];
    return data;
}

- (NSString *)SHA256String
{
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(self.bytes, (unsigned int)self.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSString *)hexString
{
    NSUInteger len = [self length];
    
    if (len == 0)
    {
        return nil;
    }
    
    const Byte *p = [self bytes];
    
    NSMutableString *hexString = [[NSMutableString alloc] initWithCapacity:len*2];
    
    for (int i=0; i < len; i++)
    {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString uppercaseString];
}

@end

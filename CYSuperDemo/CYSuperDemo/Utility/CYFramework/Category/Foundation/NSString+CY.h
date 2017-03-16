//
//  UIImage+Extension.h
//  WeiFantasy
//
//  Created by 李春阳 on 14/9/27.
//  Copyright (c) 2014年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]

// 判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil || [(str) isEqual:[NSNull null]] ||[str isEqualToString:@""])
// 判断字符串不为空并且不为空字符串
#define StringNotNullAndEmpty(str) (str!=nil && ![(str) isEqual:[NSNull null]] &&![str isEqualToString:@""])
// 快速格式化一个字符串
#define _S(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]


@class MREntitiesConverter;
@interface NSString (CY)

+ (NSString *) getOffRubbishWithString:(NSString *)str;

/** 得到CGAffineTransformWithAffine */
+ (CGAffineTransform)getCGAffineTransformWithAffine:(NSString *)affine;

+ (NSString *)cy_getAppVersion;

/** encodeURL 转码 */
- (NSString *)encodeURL;

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/** 判断字符串是否包含指定字符串 */
//-(BOOL)isContainString:(NSString*)str;

/** 去除字符串中收尾空格和换行 */
- (NSString *)trimString;

/** 匹配字符串里面的url并返回第一个找到的 */
- (NSString *)checkAndReturnUrlString;

/** SHA256 WithData */
+ (NSString *)getSHA_256StringWithData:(NSData *)data;

/** SHA256 String */
- (NSString *)getSHA_256String;

/** MD5 加密 */
+ (NSString *)md5:(NSString *)str;

/** 时间戳转制 */
+ (NSString *)timestampString;

+ (NSString *)timestampStringWithDateFormart:(NSString *)dateFormart;

/** 时间转时间戳 yyyy-MM-dd HH:mm:ss 格式 */
+ (NSString *)timestampStringWithDateStr:(NSString *)timeStr;

/** Checking if String is Empty */
-(BOOL)isEmpty;
/** Checking if String is Empty or nil */
-(BOOL)isValid;
/** Remove white spaces from String */
- (NSString *)removeWhiteSpacesFromString;

- (NSInteger)countOfString_CC;

/** Counts number of Words in String */
- (NSUInteger)countNumberOfWords;
/** Counts number of Bytes in String */
- (NSUInteger)countNumberOfBytes;
/** If string contains substring */
- (BOOL)containsString:(NSString *)subString;
/** If my string starts with given string */
- (BOOL)isBeginsWith:(NSString *)string;
/** If my string ends with given string */
- (BOOL)isEndssWith:(NSString *)string;

/** Replace particular characters in my string with new character */
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
/** Get Substring from particular location to given lenght */
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
/** Add substring to main String */
- (NSString *)addString:(NSString *)string;
/** Remove particular sub string from main string */
- (NSString *)removeSubString:(NSString *)subString;

/** If my string contains ony letters */
- (BOOL)containsOnlyLetters;
/** If my string contains only numbers */
- (BOOL)containsOnlyNumbers;
/** If my string contains only numbers and letters */
- (BOOL)containsOnlyNumbersAndLetters;
/** If my string contains only 中文 英文 下划线 数字 */
- (BOOL)isIncludeOnlyNumbersAndLettersAndChinese;
/** 判断是否emoji */
+ (BOOL)stringContainsEmoji:(NSString *)string;

// 干掉表情
+ (NSString *)stringByDeleteEmoji:(NSString *)string;

/** If my string is available in particular array */
- (BOOL)isInThisArray:(NSArray*)array;

/** 是否包含中文 */
-(BOOL)IsChinese;

/** Get String from array */
+ (NSString *)getStringFromArray:(NSArray *)array;
/** Convert Array from my String */
- (NSArray *)getArray;

/** Get My Application Version number */
+ (NSString *)getMyApplicationVersion;
/** Get My Application name */
+ (NSString *)getMyApplicationName;

/** Convert string to NSData */
- (NSData *)convertToData;
/** Get String from NSData */
+ (NSString *)getStringFromData:(NSData *)data;

/** Is Valid Email */
- (BOOL)isValidEmail;
/** Is Valid Phone */
- (BOOL)isValidPhoneNumber;
/** Is Valid URL */
- (BOOL)isValidUrl;

@end

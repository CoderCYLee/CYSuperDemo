//
//  UIImage+Extension.m
//  WeiFantasy
//
//  Created by 李春阳 on 14/9/27.
//  Copyright (c) 2014年 Coder. All rights reserved.
//

#import "NSString+CY.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#include <sys/stat.h>
#include <dirent.h>

@implementation NSString (CY)

// 得到CGAffineTransformWithAffine
+ (CGAffineTransform)getCGAffineTransformWithAffine:(NSString *)affine
{
    NSString *matrix = affine;
    NSString *firstStr = [matrix removeSubString:@";"];
    NSString *secondStr = [firstStr removeSubString:@";"];
    
    NSArray *array = [secondStr getArray];
    
    return CGAffineTransformMake([array[0] doubleValue], [array[3] doubleValue], [array[1] doubleValue], [array[4] doubleValue], [array[2] doubleValue], [array[5] doubleValue]);
    
}

+ (NSString *)cy_getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

- (NSString *)encodeURL
{
//    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`."), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}

/**
 *  计算文本占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

// 判断字符串是否包含指定字符串
//- (BOOL)isContainString:(NSString*)str
//{
//    return [self isMatchedByRegex:[NSString stringWithFormat:@"%@+",str]];
//}

// 去掉首尾空格
- (NSString *)trimString
{
    NSString *newString = nil;
    
    if (StringNotNullAndEmpty(self)) {
        newString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //        newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //        newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    if (StringIsNullOrEmpty(newString)) {
        newString = nil;
    }
    
    return newString;
}

- (NSString *)checkAndReturnUrlString{
    if (!self || [self length] == 0) {
        return nil;
    }
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *resultArray = [regular matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (resultArray && [resultArray count] != 0) {
        NSTextCheckingResult *result = resultArray[0];
        NSString *text = [self substringWithRange:result.range];
        return text;
    }
    //    for (NSTextCheckingResult *result in resultArray) {
    //
    //    }
    return nil;
}

+ (NSString*)tokenString:(NSData *)devToken
{
    NSString *token=devToken.description;//[[deviceToken description] stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    token=[token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return token;
}

// sha256
+ (NSString *)getSHA_256StringWithData:(NSData *)data
{
    //    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSString *)getSHA_256String
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSData *)hexStringToData
{
    if (!self.length) {
        return nil;
    }
    
    const char *ch = [[self lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [[NSMutableData alloc] initWithCapacity:strlen(ch)/2];
    while (*ch)
    {
        char byte = 0;
        if ('0' <= *ch && *ch <= '9')
        {
            byte = *ch - '0';
        }
        else if ('a' <= *ch && *ch <= 'f')
        {
            byte = *ch - 'a' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch)
        {
            if ('0' <= *ch && *ch <= '9')
            {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f')
            {
                byte += *ch - 'a' + 10;
            }
            ch++;
        }
        
        [data appendBytes:&byte length:1];
    }
    
    return data;
}


// md5
+ (NSString *)md5:(NSString *)str {
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    };
    return [hash lowercaseString];
}

/** 时间戳转制 秒*/
+ (NSString *)timestampString
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    double t = time;
    NSString *timestampString = [NSString stringWithFormat:@"%ld", (long)t];
    return timestampString;
}

/** 时间戳转制 */
+ (NSString *)timestampStringWithDateFormart:(NSString *)dateFormart
{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
//    NSLog(@"%@", localeDate);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormart];
    NSString *timeString = [formatter stringFromDate:datenow];
    
    return timeString;
}

+ (NSString *)timestampStringWithDateStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)getOffRubbishWithString:(NSString *)str
{
    NSMutableString *responseString = [NSMutableString stringWithString:str];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    
    [responseString stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    
    return responseString;
}

// Checking if String is Empty
-(BOOL)isEmpty
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}
//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
	NSString *trimmedString = [self stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
	
    return count;
}

-(BOOL)IsChinese
{
    for(int i=0; i< [self length];i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)countOfString_CC
{
    int chinese=0;
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff)
            chinese++;
    }
    // [self length]+chinese;
    NSInteger length = [self length];
//    NSLog(@"length===%d",length);
    return length;
}

// Counts number of Bytes in String
- (NSUInteger)countNumberOfBytes {
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}

// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
	NSRange r;
	r.location = begin;
	r.length = end - begin;
	return [self substringWithRange:r];
}

// Add substring to main String 
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;

    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// If my string contains only letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string contains 字母，数字，中文，下划线
- (BOOL)isIncludeOnlyNumbersAndLettersAndChinese
{
    NSString *regex = @"^[\u4E00-\u9FA5A-Za-z0-9_]+$";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [urlTest evaluateWithObject:self];
}

// 判断是否emoji
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
    }];
    return returnValue;
}

+ (NSString *)stringByDeleteEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    NSMutableString *str = [NSMutableString stringWithString:@""];
    
    
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                } else {
                    returnValue = NO;
                }
            } else {
                returnValue = NO;
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            } else {
                returnValue = NO;
            }
            
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            } else {
                returnValue = NO;
            }
        }
        
        if (returnValue == NO) {
            [str appendString:substring];
        }
        
    }];
    return str;
}


// If my string is available in particular array
- (BOOL)isInThisArray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSString *version = [info objectForKey:@"CFBundleVersion"];
	return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
	NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
	NSString *name = [info objectForKey:@"CFBundleDisplayName"];
	return name;
}

// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}

// Is Valid Email
- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone
- (BOOL)isValidPhoneNumber
{
    NSString *regex = @"^(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
//     NSString *regex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
//    NSString *regex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// Is Valid URL
- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}


- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width {
    
    CGFloat height = 0;
    
    if (self.length == 0) {
        
        height = 0;
        
    } else {
        
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        height = retSize.height;
    }
    
    return height;
}

- (CGFloat)widthWithLabelFont:(UIFont *)font {
    
    CGFloat retHeight = 0;
    
    if (self.length == 0) {
        
        retHeight = 0;
        
    } else {
        
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        retHeight = retSize.width;
    }
    
    return retHeight;
}

@end

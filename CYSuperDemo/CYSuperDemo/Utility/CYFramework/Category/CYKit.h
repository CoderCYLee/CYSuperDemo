//
//  CYKit.h
//  AFNDownloadZipFile
//
//  Created by 李春阳 on 15/10/22.
//  Copyright © 2015年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SystemTypeOther = 0,
    SystemTypeIOS7,
    SystemTypeIOS8,
    SystemTypeIOS9,
    SystemTypeIOS10
}SystemType;

typedef enum{
    DeviceTypeUnknow = 0,
    DeviceTypeOther,
    DeviceTypeIPad,
    DeviceTypeIPhone4,
    DeviceTypeIPhone5,
    DeviceTypeIPhone6,
    DeviceTypeIPhone6plus
}DeviceType;

@interface CYKit : NSObject

+ (SystemType)systemType;
+ (DeviceType)deviceType;

/** 显示提示信息 */
- (void)ToastMessage:(NSString *)message;

#pragma mark - Cache
+ (void)saveData:(NSObject *)object forKey:(NSString *)key;
+ (id)readCacheDataForKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;

+ (NSString *)getIpAddress;
+ (NSString *)getAppVersion;

//+ (BOOL)isFirstOpen;

+ (NSString *)getCacheResourcePathByName:(NSString *)name;
+ (BOOL)createDirectorysAtPath:(NSString *)path;

@end

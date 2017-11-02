//
//  CYKit.m
//  AFNDownloadZipFile
//
//  Created by cy on 15/10/22.
//  Copyright © 2015年 Cyrill. All rights reserved.
//

#import "CYKit.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>

@implementation CYKit

+ (DeviceType)deviceType
{
    static DeviceType deviceType = DeviceTypeUnknow;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    CGFloat winWidth = window.bounds.size.width;
    CGFloat winHeight = window.bounds.size.height;
    if (deviceType == DeviceTypeUnknow) {
        NSString *deviceStr = [[UIDevice currentDevice] model];
        if ([deviceStr isEqualToString:@"iPad"] || [deviceStr isEqualToString:@"iPad Simulator"]) {
            deviceType = DeviceTypeIPad;
        }else if (winHeight < 500 ) {
            deviceType = DeviceTypeIPhone4;
        }else {
            deviceType = DeviceTypeOther;
        }
    }
    return deviceType;
}

+ (SystemType)systemType
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        return SystemTypeIOS7;
    } else if (systemVersion >= 8.0) {
        return SystemTypeIOS8;
    } else if (systemVersion >= 9.0) {
        return SystemTypeIOS9;
    } else if (systemVersion >= 10.0) {
        return SystemTypeIOS10;
    }
    return SystemTypeOther;
}

/*
 * 显示提示信息
 */
- (void)ToastMessage:(NSString *)message {
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
    CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 30, textSize.height + 20)];
//    msg.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height * 8.0 / 9.0);
    
    msg.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 2.0);
    
    msg.text = message;
    msg.font = [UIFont systemFontOfSize:15.0];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.backgroundColor = [UIColor blackColor];
    msg.textColor = [UIColor whiteColor];
    msg.layer.masksToBounds = YES;
    msg.layer.cornerRadius = (textSize.height + 20) / 2;
    [[UIApplication sharedApplication].keyWindow addSubview:msg];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:msg];
    [UIView animateWithDuration:1.0 delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        msg.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismissMsg:) withObject:msg afterDelay:0.5];
    }];
}

- (void)dismissMsg:(UIView *)msg {
    [UIView animateWithDuration:0.3 animations:^{
        msg.alpha = 0.f;
    } completion:^(BOOL finished) {
        [msg removeFromSuperview];
    }];
}

+ (void)setStatusBarHide:(BOOL)hide{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (hide) {
        [UIApplication sharedApplication].statusBarHidden = YES;
        window.windowLevel = UIWindowLevelAlert;
        
        if ([self systemType] == SystemTypeIOS7 || [CYKit systemType] == SystemTypeIOS8) {
            UIView *view = window.rootViewController.view;
            view.frame = CGRectMake(0, 0, view.bounds.size.width, window.bounds.size.height);
        }
    }else{
        [UIApplication sharedApplication].statusBarHidden = NO;
        window.windowLevel = UIWindowLevelNormal;
        
        if ([self systemType] == SystemTypeIOS7 || [CYKit systemType] == SystemTypeIOS8) {
            UIView *view = window.rootViewController.view;
            view.frame = CGRectMake(0, 20, view.bounds.size.width, window.bounds.size.height-20);
        }
    }
}

+ (NSString *)getIpAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

//+ (BOOL)isFirstOpen{
//    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:KeyIsFirstOpen];
//    if (number) {
//        return NO;
//    }else{
//        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:KeyIsFirstOpen];
//        return YES;
//    }
//}

#pragma mark - Cache
+ (void)saveData:(NSObject *)object forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)readCacheDataForKey:(NSString *)key
{
    NSData *cache = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (cache) {
        @try {
            NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:cache];
            return object;
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
    }
    return Nil;
}

+ (void)deleteObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getCacheResourcePathByName:(NSString *)name
{
    NSString *cachePath = nil;
//    if (nil == cachePath) {
        NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachePath = dirs[0];
//    }
//    NSString *folderPath = cachePath;
    if (name) {
        cachePath = [cachePath stringByAppendingPathComponent:name];
    }
    return cachePath;
}

+ (BOOL)createDirectorysAtPath:(NSString *)path
{
    @synchronized(self) {
        NSFileManager *magamer = [NSFileManager defaultManager];
        if (![magamer fileExistsAtPath:path]) {
            NSError *error = nil;
            if (![magamer createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
                return NO;
            }
        }
    }
    return YES;
}

@end

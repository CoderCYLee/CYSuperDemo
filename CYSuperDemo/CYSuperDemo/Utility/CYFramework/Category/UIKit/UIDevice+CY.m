//
//  UIDevice+CY.m
//  JustJokes
//
//  Created by cy on 15/4/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import "UIDevice+CY.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/utsname.h>

@implementation UIDevice (CY)

+ (NSString *)macAddress
{
    int                     mib[6];
    size_t                  len;
    char                    *buf;
    unsigned char           *ptr;
    struct if_msghdr        *ifm;
    struct sockaddr_dl      *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL)
    {
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return outstring;
}

+ (BOOL)deviceIsJailBreak
{
    BOOL jailbroken = NO;
    /**
     *  判断越狱文件路径、判断越狱
     */
    //    NSString *cydiaPath = @"/Applications/Cydia.app";
    //    NSString *substratePath = @"/Library/MobileSubstrate/MobileSubstrate.dylib";
    //    NSString *bashPath = @"/bin/bash";
    //    NSString *sshdPath = @"/usr/sbin/sshd";
    //    NSString *aptPath = @"/etc/apt";
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]     ||
    //        [[NSFileManager defaultManager] fileExistsAtPath:substratePath] ||
    //        [[NSFileManager defaultManager] fileExistsAtPath:bashPath]      ||
    //        [[NSFileManager defaultManager] fileExistsAtPath:sshdPath]      ||
    //        [[NSFileManager defaultManager] fileExistsAtPath:aptPath])
    //    {
    //        jailbroken = YES;
    //    }
    /**
     *  判断是否有权限获取设备应用列表
     */
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        NSLog(@"Device is jailbroken");
        jailbroken = YES;
        //        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
        //                                                                               error:nil];
        //        NSLog(@"applist = %@",applist);
    }
    return jailbroken;  
    
}

+ (NSString *)deviceModel
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    /* ========== iPhone ========== */
    //  iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone";
    
    //  iPhone 3G
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    //  iPhone 3GS
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    //  iPhone 4
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    //  iPhone 4S
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    //  iPhone 5
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    //  iPhone 5c
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    //  iPhone 5s
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    //  iPhone 6 Plus
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    //  iPhone 6
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    //  iPhone 6s
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    //  iPhone 6s Plus
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    //  iPhone SE
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    //  iPhone 7
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    
    //  iPhone 7 Plus
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    
    //  iPhone 8
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    //  iPhone 8 Plus
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    //  iPhone X
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    //  iPhone XR
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    //  iPhone XS
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    
    //  iPhone XS Max
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    
    /* ========== iPod ========== */
    //  iPod
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    /* ========== iPad ========== */
    //  iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad6,11"])   return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"])   return @"iPad 5";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro";
    if ([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro";
    if ([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro";
    
    if ([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 2";
    if ([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 2";
    
    if ([platform isEqualToString:@"iPad7,5"])   return @"iPad";
    if ([platform isEqualToString:@"iPad7,6"])   return @"iPad";
    
    // iPad Mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4";
    
    /* ========== iPhone Simulator ========== */
    // iPhone Simulator
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

@end

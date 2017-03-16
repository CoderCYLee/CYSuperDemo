//
//  UIDevice+CY.m
//  JustJokes
//
//  Created by 李春阳 on 15/4/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import "UIDevice+CY.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

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

@end

//
//  CYWifiManager.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/10/9.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CYWifiManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation CYWifiManager

+ (NSDictionary *)info {
    NSDictionary *info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        /*
         like this
         
         Printing description of info:
         {
         BSSID = "a8:57:4e:a6:2:92";
         SSID = KFBI;
         SSIDDATA = <4b464249>;
         }
         */
    }
    return info;
}

+ (NSString *)ssid {
    NSString *ssid = nil;
    NSDictionary *info = [self info];
    if (info[@"SSID"]) {
        ssid = info[@"SSID"];
    }
    return ssid;
}

@end

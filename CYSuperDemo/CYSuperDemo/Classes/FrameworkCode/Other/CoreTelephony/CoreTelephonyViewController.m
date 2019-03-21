//
//  CoreTelephonyViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2019/3/21.
//  Copyright © 2019 Cyrill. All rights reserved.
//

#import "CoreTelephonyViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTCellularData.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTSubscriberInfo.h>

@interface CoreTelephonyViewController () <CTSubscriberDelegate>

@end

@implementation CoreTelephonyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     //获取所有运营商信息  iOS 12 后支持
     @property(readonly, retain, nullable) NSDictionary<NSString *, CTCarrier *> *serviceSubscriberCellularProviders;
     //当前获取运营商信息
     @property(readonly, retain, nullable) CTCarrier *subscriberCellularProvider;
     //无线网络提供信息
     @property (nonatomic, readonly, retain, nullable) NSDictionary<NSString *, NSString *> * serviceCurrentRadioAccessTechnology;
     //当前无线网络信息
     CTRadioAccessTechnologyGPRS      //2.5g
     CTRadioAccessTechnologyEdge      //2.7G
     CTRadioAccessTechnologyWCDMA     //3G
     CTRadioAccessTechnologyHSDPA     //3.5G
     CTRadioAccessTechnologyHSUPA     //3G与4G之间的过度技术
     CTRadioAccessTechnologyCDMA1x    //3G
     CTRadioAccessTechnologyCDMAEVDORev0
     CTRadioAccessTechnologyCDMAEVDORevA
     CTRadioAccessTechnologyCDMAEVDORevB
     CTRadioAccessTechnologyeHRPD
     CTRadioAccessTechnologyLTE       //4G
     
     @property (nonatomic, readonly, retain, nullable) NSString* currentRadioAccessTechnology __OSX_AVAILABLE_BUT_DEPRECATED_MSG(__MAC_NA, __MAC_NA, __IPHONE_7_0, __IPHONE_12_0,
     "Replaced by serviceCurrentRadioAccessTechnology");
     */
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    if (@available(iOS 12.0, *)) {
        NSDictionary<NSString *, NSString *> * serviceCurrentRadioAccessTechnology = info.serviceCurrentRadioAccessTechnology;
        
        NSLog(@"%@", serviceCurrentRadioAccessTechnology);
    } else {
        // Fallback on earlier versions
        NSString *serviceCurrentRadioAccessTechnology = info.currentRadioAccessTechnology;
        NSLog(@"%@", serviceCurrentRadioAccessTechnology);
    }
    
    
    if (@available(iOS 12.0, *)) {
        NSDictionary<NSString *, CTCarrier *> *serviceSubscriberCellularProviders = info.serviceSubscriberCellularProviders;
        CTCarrier *carrier = serviceSubscriberCellularProviders.allValues.firstObject;
        NSLog(@"carrier:%@", [carrier description]);
    } else {
        // Fallback on earlier versions
        
        // 获取运营商信息
        /*
         //运营商名字
         @property (nonatomic, readonly, retain, nullable) NSString *carrierName;
         //国家编码
         @property (nonatomic, readonly, retain, nullable) NSString *mobileCountryCode;
         //网络编码
         @property (nonatomic, readonly, retain, nullable) NSString *mobileNetworkCode;
         //ISO编码
         @property (nonatomic, readonly, retain, nullable) NSString* isoCountryCode;
         //是否允许VOIP
         @property (nonatomic, readonly, assign) BOOL allowsVOIP;
         */
        CTCarrier *carrier = info.subscriberCellularProvider;
        NSLog(@"carrier:%@", [carrier description]);
    }
    
    
    CTCellularData *cellularData = [[CTCellularData alloc] init];
#ifdef __IPHONE_9_0

    // 状态发生变化时调用
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState restrictedState) {
        switch (restrictedState) {
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"蜂窝移动网络状态：未知");
                break;
            case kCTCellularDataRestricted:
                NSLog(@"蜂窝移动网络状态：关闭");
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"蜂窝移动网络状态：开启");
                break;
            default:
                break;
        }
    };
#else
    
    
#endif
    // after ios10.0 use callkit
//    CTCallCenter *center = [[CTCallCenter alloc] init];
    
    if (@available(iOS 12.1, *)) {
        NSArray *subscribers = [CTSubscriberInfo subscribers];
        CTSubscriber *subscriber = subscribers.firstObject;
        subscriber.delegate = self;
    } else {
        // Fallback on earlier versions
        CTSubscriber *subscriber = [CTSubscriberInfo subscriber];
        NSLog(@"subscriber:%@", subscriber.description);
    }
    
}

#pragma mark - Delegate
#pragma mark CTSubscriberDelegate
- (void)subscriberTokenRefreshed:(CTSubscriber *)subscriber {
    NSLog(@"subscriber:%@", subscriber.description);
}

#pragma mark - event response

#pragma mark - reuseable methods

#pragma mark - private methods

#pragma mark - getters and setters

@end

//
//  CYWifiManager.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/10/9.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYWifiManager : NSObject

+ (NSDictionary *)info;
+ (NSString *)ssid;

@end

NS_ASSUME_NONNULL_END

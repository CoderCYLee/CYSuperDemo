//
//  CYNetworkUtility.h
//  CYNetworkUtility
//
//  Created by Cyrill on 2016/6/16.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYNetworkUtility : NSObject

/** 功能：检测网络连接状态 */
+ (BOOL)connectedToNetwork;

/** 检测一个网址是否可以正常访问 */
+ (BOOL)hostAvailable:(NSString *)theHost;

@end

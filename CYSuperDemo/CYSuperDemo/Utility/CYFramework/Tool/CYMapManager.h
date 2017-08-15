//
//  CYMapManager.h
//  CYSuperDemo
//
//  Created by Cyrill on 2017/8/15.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@class CYMapManager;

@protocol CYMapManagerLocationDelegate <NSObject>

@optional

- (void)mapManager:(CYMapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location;
- (void)mapManager:(CYMapManager *)manager didFailed:(NSError *)error;
- (void)mapManagerServerClosed:(CYMapManager *)manager;

@end

@interface CYMapManager : NSObject

@property (nonatomic, weak)     id<CYMapManagerLocationDelegate> delegate;

@property (nonatomic, readonly) CLAuthorizationStatus          authorizationStatus;

- (void)start;

@end

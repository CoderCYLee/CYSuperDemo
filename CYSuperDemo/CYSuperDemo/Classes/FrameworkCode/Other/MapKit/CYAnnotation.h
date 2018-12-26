//
//  CYAnnotation.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/25.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYAnnotation : NSObject<MKAnnotation>

// 控制大头针扎在地图上哪个位置
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// 控制大头针弹框显示的标题
@property (nonatomic, copy, nullable) NSString *title;
// 控制大头针弹框显示的子标题
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END

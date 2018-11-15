//
//  MapKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/8.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "MapKitViewController.h"
#import <MapKit/MapKit.h>

@interface MapKitViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MapKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    
    // 1.设置地图类型
    _mapView.mapType = MKMapTypeStandard; //标准地图
    
    _mapView.mapType = MKMapTypeSatellite;//卫星云图
    
    _mapView.mapType = MKMapTypeHybrid; //混合模式
    
    _mapView.mapType = MKMapTypeSatelliteFlyover; //3D立体卫星
    
    _mapView.mapType = MKMapTypeHybridFlyover; //3D立体混合
    
    // 2.设置跟踪模式(MKUserTrackingModeFollow == 跟踪)
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 3.设置代理（监控地图的相关行为：比如显示的区域发生了改变）
    self.mapView.delegate = self;
    
    
}

#pragma mark - MKMapViewDelegate
/**
 *  更新到用户的位置时就会调用(显示的位置、显示范围改变)
 *  userLocation : 大头针模型数据， 对大头针位置的一个封装（这里的userLocation描述的是用来显示用户位置的蓝色大头针）
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"天朝帝都";
    userLocation.subtitle = @"帝都是个牛逼的地方";
    
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2509, 0.2256);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}

/**
 *  地图显示的区域改变了就会调用(显示的位置、显示范围改变)
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D center = mapView.region.center;
    MKCoordinateSpan span = mapView.region.span;
    
    NSLog(@"中心点=(%f, %f), 区域跨度=(%f, %f)", center.longitude, center.latitude, span.longitudeDelta, span.latitudeDelta);
    
    
}

/**
 *  地图显示的区域即将改变了就会调用
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    //    NSLog(@"regionWillChangeAnimated");
}

@end

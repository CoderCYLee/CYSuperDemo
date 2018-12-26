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
@property (nonatomic, strong) CLLocationManager *locaationManager;

@end

@implementation MapKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _locaationManager = [[CLLocationManager alloc] init];
    
    [_locaationManager requestAlwaysAuthorization];
    
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    
    // 设置地图类型
//    MKMapTypeStandard = 0, // 标准地图
//    MKMapTypeSatellite, // 卫星云图
//    MKMapTypeHybrid, // 混合(在卫星云图上加了标准地图的覆盖层)
//    MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D立体
//    MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D混合
    _mapView.mapType = MKMapTypeStandard;

    
    // 设置地图控制项
    _mapView.zoomEnabled = YES;
    _mapView.scrollEnabled = YES;
    _mapView.zoomEnabled = YES;
    _mapView.rotateEnabled = YES;
    _mapView.pitchEnabled = YES; // 是否显示3DView
    
    // 设置地图显示项
    if (@available(iOS 9.0, *)) {
        _mapView.showsCompass = YES; // 指南针
        _mapView.showsScale = YES; // 比例尺
        _mapView.showsTraffic = YES; // 交通
    }
    
    _mapView.showsBuildings = YES; // 建筑物
    _mapView.showsPointsOfInterest = YES; // 兴趣点
//    _mapView.showsUserLocation = YES; // 显示位置, 但是地图并不会自动放大到合适比例
    
    // 设置跟踪模式
    /*
     设置MKMapView的userTrackingMode属性可以跟踪显示用户的当前位置
     MKUserTrackingModeNone :不跟踪用户的位置
     MKUserTrackingModeFollow :跟踪并在地图上显示用户的当前位置
     MKUserTrackingModeFollowWithHeading :跟踪并在地图上显示用户的当前位置,地图会跟随用户的前进方向进行旋转
     */
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 3.设置代理（监控地图的相关行为：比如显示的区域发生了改变）
    self.mapView.delegate = self;
    
}

- (void)dealloc {
    
}

#pragma mark - MKMapViewDelegate
/**
 *  更新到用户的位置时就会调用(显示的位置、显示范围改变)
 *  userLocation : 大头针模型数据， 对大头针位置的一个封装（这里的userLocation描述的是用来显示用户位置的蓝色大头针）
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    /**
     *  MKUserLocation : 专业术语: 大头针模型 其实喊什么都行, 只不过这个类遵循了大头针数据模型必须遵循的一个协议 MKAnnotation
     // title : 标注的标题
     // subtitle : 标注的子标题
     */
    userLocation.title = @"1111";
    userLocation.subtitle = @"大三123";
//
//    // 移动地图的中心,显示用户的当前位置
//    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//
//
//    // 显示地图的显示区域
//
//    // 控制区域中心
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    // 设置区域跨度
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.077919, 0.044529);
//
//    // 创建一个区域
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//    // 设置地图显示区域
//    [mapView setRegion:region animated:YES];
    
}

/**
 *  地图显示的区域改变了就会调用(显示的位置、显示范围改变)
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D center = mapView.region.center;
    MKCoordinateSpan span = mapView.region.span;
    
    NSLog(@"中心点=(%f, %f), 区域跨度=(%f, %f)", center.longitude, center.latitude, span.longitudeDelta, span.latitudeDelta);
    
}

/**
 *  地图显示的区域即将改变了就会调用
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"regionWillChangeAnimated");
}

@end

//
//  GyroscopeViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "GyroscopeViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface GyroscopeViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation GyroscopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [[CMMotionManager alloc] init];
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [_manager startGyroUpdatesToQueue:q withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        NSLog(@"x = %f", gyroData.rotationRate.x);
        NSLog(@"y = %f", gyroData.rotationRate.y);
        NSLog(@"z = %f", gyroData.rotationRate.z);
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 不用时要关掉加速仪
    [_manager stopGyroUpdates];
}

@end

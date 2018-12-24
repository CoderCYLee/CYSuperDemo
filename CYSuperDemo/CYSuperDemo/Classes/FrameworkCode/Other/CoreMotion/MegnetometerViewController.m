//
//  MegnetometerViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "MegnetometerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface MegnetometerViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation MegnetometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [[CMMotionManager alloc] init];
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [_manager startMagnetometerUpdatesToQueue:q withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        NSLog(@"x = %f", magnetometerData.magneticField.x);
        NSLog(@"y = %f", magnetometerData.magneticField.y);
        NSLog(@"z = %f", magnetometerData.magneticField.z);
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 不用时要关掉加速仪
    [_manager stopMagnetometerUpdates];
}

@end

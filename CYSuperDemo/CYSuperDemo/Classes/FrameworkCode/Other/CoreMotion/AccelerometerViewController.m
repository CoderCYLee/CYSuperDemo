//
//  AccelerometerViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AccelerometerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface AccelerometerViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation AccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [[CMMotionManager alloc] init];
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [_manager startAccelerometerUpdatesToQueue:q withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        NSLog(@"x = %f", accelerometerData.acceleration.x);
        NSLog(@"y = %f", accelerometerData.acceleration.y);
        NSLog(@"z = %f", accelerometerData.acceleration.z);
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    // 不用时要关掉加速仪
    [_manager stopAccelerometerUpdates];
}

@end

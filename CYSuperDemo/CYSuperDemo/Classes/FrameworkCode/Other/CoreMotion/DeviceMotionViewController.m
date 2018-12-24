//
//  DeviceMotionViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "DeviceMotionViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceMotionViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation DeviceMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [[CMMotionManager alloc] init];
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [_manager startDeviceMotionUpdatesToQueue:q withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float pitch = motion.attitude.pitch;
            float roll = motion.attitude.roll;
            float yaw = motion.attitude.yaw;
            
            NSString *str1 = [[NSString alloc] initWithFormat:@"%2.0f", pitch * 180 / M_PI];
            NSString *str2  = [[NSString alloc] initWithFormat:@"%2.0f", roll * 180 / M_PI];
            NSString *str3  = [[NSString alloc] initWithFormat:@"%2.0f", yaw * 180 / M_PI];
            
            NSLog(@"%@\n%@\n%@\n", str1, str2, str3);
        });
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 不用时要关掉加速仪
    [_manager stopDeviceMotionUpdates];
}

@end

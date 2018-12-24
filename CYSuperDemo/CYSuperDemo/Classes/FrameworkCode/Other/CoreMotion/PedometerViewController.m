

//
//  PedometerViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PedometerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface PedometerViewController ()
@property (nonatomic, strong) CMPedometer *pedometer;
@end

@implementation PedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pedometer = [[CMPedometer alloc]init];
    
    //判断记步功能
    if ([CMPedometer isStepCountingAvailable]) {
        [_pedometer queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*2] toDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*1] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error====%@",error);
            }else {
                NSLog(@"步数====%@",pedometerData.numberOfSteps);
                NSLog(@"距离====%@",pedometerData.distance);
            }
        }];
    }else{
        NSLog(@"记步功能不可用");
    }
    
}


@end

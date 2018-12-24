

//
//  ProximityViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ProximityViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ProximityViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation ProximityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwitch *s = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [s addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:s];
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [self proximitySensorOn];
    }
    else{
        [self proximitySensorOff];
    }
}

- (void)proximitySensorOn {
    // 启动距离传感器
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    if ([UIDevice currentDevice].proximityMonitoringEnabled == YES) {
        NSNotificationCenter *notice = [NSNotificationCenter defaultCenter];
        [notice addObserver:self selector:@selector(proximitySensorChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
}

- (void)proximitySensorOff {
    // 关闭距离传感器
    if ([UIDevice currentDevice].proximityMonitoringEnabled == YES) {
        NSNotificationCenter *notice = [NSNotificationCenter defaultCenter];
        [notice removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
}

- (void)proximitySensorChange:(id)notification{
    static BOOL flag;
    
    flag = !flag;
    if (flag) {
        // 当物体接近感应器要做的事情写在这里
        NSLog(@"接近");
    }
    else{
        // 当物体离开传感器要做的事情写在这里
        NSLog(@"离开");
    }
}

@end

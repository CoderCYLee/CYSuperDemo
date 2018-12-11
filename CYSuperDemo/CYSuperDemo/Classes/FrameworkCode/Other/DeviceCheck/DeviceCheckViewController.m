//
//  DeviceCheckViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/15.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "DeviceCheckViewController.h"
#import <DeviceCheck/DeviceCheck.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceCheckViewController ()

@end

@implementation DeviceCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self deviceCheck];
}

- (void)deviceCheck {
    if (@available(iOS 11.0, *)) {
        [[DCDevice currentDevice] generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
            if (error) {
                // Do what you want
                
            } else {
                // Upload token to App server
                NSLog(@"%@", token ?: @"No Data");
                
                //                [token ]
            }
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

@end

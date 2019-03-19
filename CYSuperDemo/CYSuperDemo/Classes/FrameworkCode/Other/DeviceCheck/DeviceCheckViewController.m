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
            
            NSString *string = @"";
            
            if (error) {
                // Do what you want
                string = [NSString stringWithFormat:@"error: %@", error.localizedDescription];
                
            } else {
                // Upload token to App server
                NSLog(@"%@", token ?: @"No Data");
                string = [NSString stringWithFormat:@"token: %@", token];
            }
            
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [vc addAction:action];
            [self presentViewController:vc animated:YES completion:nil];
            
        }];
    } else {
        // Fallback on earlier versions
        ShowMsg(@"iOS 11.0 以上才能使用");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

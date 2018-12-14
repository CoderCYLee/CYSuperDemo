//
//  ViewController.m
//  CYSuperDemo
//
//  Created by Cyrill on 2017/3/15.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "ViewController.h"
#import "CYAudioUtility.h"
#import <HealthKit/HealthKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[[CYAudioUtility alloc] init] playAduio:@"8436" ext:@"wav"];
    
//    NSString *url = @"taobao://https://item.taobao.com/item.htm?id=577359137670";
//    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//        
//    } else {
//        NSLog(@"本地没有该软件");
//    }
    
    // cloud
    
//    NSUbiquitousKeyValueStore *keyStore = [NSUbiquitousKeyValueStore defaultStore];
////    [keyStore setString:@"test" forKey:@"test"];
////    [keyStore synchronize];
//    [keyStore removeObjectForKey:@"test"];
//    NSLog(@"%@", [keyStore stringForKey:@"test"]);
//
    
    // healthkit
//    if(!(NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable]))
//    {
//        // Add your HealthKit code here
//        BOOL a = [HKHealthStore isHealthDataAvailable];
//        NSLog(@"该设备不支持HealthKit");
//    }
//
//    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
//
//    // Share body mass, height and body mass index
//    NSSet *shareObjectTypes = [NSSet setWithObjects:
//                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
//                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
//                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
//                               nil];
//
//    // Read date of birth, biological sex and step count
//    NSSet *readObjectTypes  = [NSSet setWithObjects:
//                               [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
//                               [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
//                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
//                               nil];
//
//    // Request access
//    [healthStore requestAuthorizationToShareTypes:shareObjectTypes readTypes:readObjectTypes completion:^(BOOL success, NSError *error) {
//
//        if(success == YES)
//        {
//           // ...
//        }
//        else
//        {
//           // Determine if it was an error or if the
//           // user just canceld the authorization request
//        }
//
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  HealthKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/11.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "HealthKitViewController.h"
#import <HealthKit/HealthKit.h>

@interface HealthKitViewController ()

@end

@implementation HealthKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    // healthkit
    if(!(NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable]))
    {
        // Add your HealthKit code here
//        BOOL a = [HKHealthStore isHealthDataAvailable];
        NSLog(@"该设备不支持HealthKit");
    }

    HKHealthStore *healthStore = [[HKHealthStore alloc] init];

    // Share body mass, height and body mass index
    NSSet *shareObjectTypes = [NSSet setWithObjects:
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
                               nil];

    // Read date of birth, biological sex and step count
    NSSet *readObjectTypes  = [NSSet setWithObjects:
                               [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
                               [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                               nil];

    // Request access
    [healthStore requestAuthorizationToShareTypes:shareObjectTypes readTypes:readObjectTypes completion:^(BOOL success, NSError *error) {

        if(success == YES)
        {
           // ...
        }
        else
        {
           // Determine if it was an error or if the
           // user just canceld the authorization request
        }

    }];

}


@end

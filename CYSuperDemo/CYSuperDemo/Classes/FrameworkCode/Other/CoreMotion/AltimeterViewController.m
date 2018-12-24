


//
//  AltimeterViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AltimeterViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface AltimeterViewController ()

@property (nonatomic, strong) CMAltimeter *altimeter;

@end

@implementation AltimeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _altimeter = [[CMAltimeter alloc] init];
    
    if ([CMAltimeter isRelativeAltitudeAvailable]) {
        [self.altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error====%@",error);
            }else{
                NSLog(@"Relative Altimeter:%@",altitudeData.relativeAltitude);
            }
        }];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

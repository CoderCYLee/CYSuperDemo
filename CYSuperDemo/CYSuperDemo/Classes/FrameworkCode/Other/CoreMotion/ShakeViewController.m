

//
//  ShakeViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ShakeViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ShakeViewController ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake){
        NSLog(@"摇晃中");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

@end

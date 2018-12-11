//
//  HomeViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/5.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "HomeViewController.h"
#import <DeviceUtil.h>
#import "ThirdViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)init {
    if (self = [super init]) {
        DeviceUtil *util = [[DeviceUtil alloc] init];
        self.title = [NSString stringWithFormat:@"%@ (%@)",[util hardwareDescription], [util hardwareString]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Third" bundle:nil];
    
    ThirdViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

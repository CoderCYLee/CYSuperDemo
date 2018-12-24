//
//  HomeViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/5.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "HomeViewController.h"
#import <DeviceUtil.h>
#import "CYAudioUtility.h"

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
    
//    [[[CYAudioUtility alloc] init] playAduio:@"8436" ext:@"wav"];

//    NSString *url = @"taobao://https://item.taobao.com/item.htm?id=577359137670";
//    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//
//    } else {
//        NSLog(@"本地没有该软件");
//    }


}

@end

//
//  AdSupportViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2019/3/21.
//  Copyright © 2019 Cyrill. All rights reserved.
//

#import "AdSupportViewController.h"
#import <AdSupport/AdSupport.h>

@interface AdSupportViewController ()

@end

@implementation AdSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    //获取广告标识符
    NSUUID *advertisingIdentifier = manager.advertisingIdentifier;
    //用户是否同意跟踪广告标识符
    BOOL isAdvertisingTrackingEnabled = manager.isAdvertisingTrackingEnabled;
    
    NSLog(@"advertisingIdentifier:%@\nisAdvertisingTrackingEnabled:%@", advertisingIdentifier, isAdvertisingTrackingEnabled?@"YES":@"NO");
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

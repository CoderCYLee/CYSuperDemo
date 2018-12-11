//
//  StoreKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/21.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "StoreKitViewController.h"
#import <StoreKit/StoreKit.h>

@interface StoreKitViewController ()

@end

@implementation StoreKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
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

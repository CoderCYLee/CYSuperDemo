//
//  UIKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/20.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "UIKitViewController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"

@interface UIKitViewController () <UISplitViewControllerDelegate>

@end

@implementation UIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UISplitViewController *vc = [[UISplitViewController alloc] init];
//    HomeViewController *v1 = [[HomeViewController alloc] init];
//    SecondViewController *v2 = [[SecondViewController new] init];
//    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:v1];
//    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:v2];
//    vc.viewControllers = @[nav1, nav2];
////    self.navigationController.topViewController.navigationItem.leftBarButtonItem = vc.displayModeButtonItem;
//    
//    vc.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
//    
//    vc.delegate = self;
//    vc.presentsWithGesture = YES;
//    
//    [self presentViewController:vc animated:YES completion:nil];
}

@end

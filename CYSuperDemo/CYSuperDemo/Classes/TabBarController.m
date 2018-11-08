
//
//  TabBarController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/10/25.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initTabBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initTabBar {
//    [self.tabBar setBarTintColor:[UIColor yellowColor]];
    
    
//    [self.tabBar setBackgroundColor:[UIColor redColor]];
//
//    [self.tabBar setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]];
////        [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"bottomSelect_bg.png"]];//item选中时的背景
//    self.tabBar.layer.masksToBounds = YES;
//    self.tabBar.tintColor = [UIColor colorWithRed:1 green:0.4 blue:0.02 alpha:1];
//    self.tabBar.shadowImage = [[UIImage alloc] init];
//
    
    
    
    UIColor *titleNormalColor = [UIColor blackColor];
    UIColor *titleSelectedColor = [UIColor orangeColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleNormalColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleSelectedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"Icon_Home"] tag:1];
    homeVc.tabBarItem = item1;
    
    
//    ViewController *vc = [[ViewController alloc] init];
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    SecondViewController *secondVC = [sb instantiateInitialViewController];
    
//    vc.title = @"fdafd";
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:2];
    secondVC.tabBarItem = item2;
    
    
    
    
    
    self.navigationController1 = [[UINavigationController alloc] initWithRootViewController:homeVc];
    self.navigationController2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    
    //iOS 隐藏/去掉 导航栏返回按钮中的文字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    //导航栏标题样式
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    
    //组装
    self.viewControllers = [NSArray arrayWithObjects:self.navigationController1, self.navigationController2, nil];
    
    self.selectedIndex = 0;//设置启动时第一次显示的UI
    
}

@end

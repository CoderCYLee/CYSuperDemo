
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
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTranslucent:NO];
    
    UIColor *titleNormalColor = [UIColor lightGrayColor];
    UIColor *titleSelectedColor = [UIColor blackColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleNormalColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleSelectedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
//    [self.tabBar setBarTintColor:[UIColor yellowColor]];
//    [self.tabBar setBackgroundColor:[UIColor redColor]];

//    [self.tabBar setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]];
////        [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"bottomSelect_bg.png"]];//item选中时的背景
//    self.tabBar.layer.masksToBounds = YES;
//    self.tabBar.tintColor = [UIColor colorWithRed:1 green:0.4 blue:0.02 alpha:1];
//    self.tabBar.shadowImage = [[UIImage alloc] init];



//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -200) forBarMetrics:UIBarMetricsDefault];
    
//    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
//
//    UIOffset offset;
//
//    offset.horizontal = - 500;
//
//    offset.vertical =  - 500;
//
//    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    // 设置backButton的位置
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
//
//    UIImage *backButtonImage = [[UIImage imageNamed:@"Icon_Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;
  
    
//    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"Icon_Home"];
//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Icon_Home"];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -10) forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance].backItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"Icon_Home"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -20) forBarMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"Icon_Home"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"shouye"] tag:1];
    homeVc.tabBarItem = item1;

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    SecondViewController *secondVC = [sb instantiateInitialViewController];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"系统" image:[UIImage imageNamed:@"xitong"] tag:2];
    secondVC.tabBarItem = item2;
    
    
    self.navigationController1 = [[BaseNavigationController alloc] initWithRootViewController:homeVc];
    
    self.navigationController2 = [[BaseNavigationController alloc] initWithRootViewController:secondVC];
    
    
//    self.navigationController2.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //iOS 隐藏/去掉 导航栏返回按钮中的文字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    //导航栏标题样式
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    
    //组装
    self.viewControllers = [NSArray arrayWithObjects:self.navigationController1, self.navigationController2, nil];
    
    self.selectedIndex = 0;//设置启动时第一次显示的UI
    
}

@end

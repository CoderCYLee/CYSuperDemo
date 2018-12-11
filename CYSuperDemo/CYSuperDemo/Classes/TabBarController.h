//
//  TabBarController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/10/25.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface TabBarController : UITabBarController

@property (nonatomic, strong) BaseNavigationController *navigationController1;
@property (nonatomic, strong) BaseNavigationController *navigationController2;
@property (nonatomic, strong) BaseNavigationController *navigationController3;
@property (nonatomic, strong) BaseNavigationController *navigationController4;

@end



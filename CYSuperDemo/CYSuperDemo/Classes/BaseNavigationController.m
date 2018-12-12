//
//  BaseNavigationController.m
//  ExamApp
//
//  Created by cyrill on 2018/11/20.
//  Copyright © 2018 Fibrlink. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGestureRecognizer;

@end

@implementation BaseNavigationController

+ (void)initialize {
    UINavigationBar *barAppearance = [UINavigationBar appearance];
    barAppearance.barTintColor = [UIColor whiteColor];
    [barAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    barAppearance.tintColor = [UIColor blackColor];
    
    // 设置返回的图标样式 默认渲染成系统样式，渲染原图样式 UIImageRenderingModeAlwaysOriginal
//    UIImage *backButtonImage = [[UIImage imageNamed:@"qiuzhi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
//    [UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;
    
    if (@available(iOS 11.2, *)) {
        
    } else {
        //设置title与 back indicator image 的间距
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.canDragBack = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.canDragBack = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.canDragBack = YES;
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.canDragBack = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIViewController *backVC = [self.viewControllers lastObject];
        
        UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"";
        backVC.navigationItem.backBarButtonItem = backButtonItem;
    }
    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 只有非根视图控制器才能有滑动返回功能。
    // 如果导航控制器只有一个视图控制器，那么这个视图控制器一定是根视图控制器
    if (self.viewControllers.count == 1) {
        // 表示此时处于根视图控制器
        return NO;
    }
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if ([self.viewControllers count] > 1 && self.canDragBack) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - private
/**
 *  设置导航控制器的全屏右滑pop视图
 */
- (void)setupPanGestureForPop
{
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    self.popPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    
    // 设置手势代理，拦截手势触发
    self.popPanGestureRecognizer.delegate = self;
    
    // 添加到导航控制器的view中
    [self.view addGestureRecognizer:self.popPanGestureRecognizer];
    
    // 禁用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)dealloc {
    self.popPanGestureRecognizer = nil;
}

@end

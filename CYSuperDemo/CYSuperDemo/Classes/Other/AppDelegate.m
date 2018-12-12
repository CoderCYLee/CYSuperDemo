//
//  AppDelegate.m
//  CYSuperDemo
//
//  Created by Cyrill on 2017/3/15.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TabBarController.h"
#import "LaunchView.h"

@interface AppDelegate ()
@property (nonatomic, strong) LaunchView *launchView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
    } else {
        
    }
    
    TabBarController *tabbarVC = [[TabBarController alloc] init];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    // 获取LaunchScreen.storyborad
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
//    //通过使用storyborardID去获取启动页viewcontroller
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    self.window.rootViewController = viewController;
    
    
    // 获取自定义LaunchView
    self.launchView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchView" owner:self options:nil] firstObject];
    self.launchView.frame = self.window.bounds;
    [self.window addSubview:self.launchView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.launchView showAnimation];
        
        //设置3秒定时触发
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeLaunchScreen) userInfo:nil repeats:NO];
        
    });
    
    
    return YES;
}

- (void)closeLaunchScreen {
    [self.launchView hideAnimation];
//    [UIView animateWithDuration:2 animations:^{
//
//    } completion:^(BOOL finished) {
//
//    }];
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    // 从通用链接过来
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL*)url
{
    // url schemes
    // 接受传过来的参数
    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦"
                                                        message:text
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

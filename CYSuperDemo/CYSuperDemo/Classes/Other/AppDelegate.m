//
//  AppDelegate.m
//  CYSuperDemo
//
//  Created by Cyrill on 2017/3/15.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "AppDelegate.h"

#ifdef __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#endif

#import "TabBarController.h"
#import "LaunchView.h"

@interface AppDelegate ()
@property (nonatomic, strong) LaunchView *launchView;
@end

@implementation AppDelegate

#pragma mark - life cycle
// 此方法基本已经弃用,改用下面两个方法
- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSLog(@"1");
}

// will 当应用程序启动时 launchOptions 假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
// NS_AVAILABLE_IOS(6_0)
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    // 3
    
    return YES;
}

// did 当应用程序启动时 launchOptions 假如用户通过点击push通知启动的应用，这个参数里会存储一些push通知的信息。
// NS_AVAILABLE_IOS(3_0)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 6
    
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

#pragma mark - URL 回调
/*
 下面3个方法的功能基本一样，都是在别人通过URL Schemes打开应用的时候会执行的。
 不同之处：
 A 是iOS9.0的时候推出的，参数有url options。options有下面几个key
 B 是在iOS4.2的时候推出的，参数有url sourceApplication annotation.
 C 是在iOS2.0的时候推出的，参数只有url。
 
 这几个是有优先级的。A>B>C。也就是说，如果你3个方法都实现了，那么在iOS9.0以上程序只会执行A。其他是不会执行的。iOS9以下的时候不会调用A，会优先调用B。
 */
// iOS 9.0 later
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    // no equiv. notification. return NO if the application can't open for some reason
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

// iOS 4.2 - iOS 9.0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
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

// iOS 2.0 - iOS 9.0
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

#pragma mark - 后台 前台
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
    
    NSLog(@"6");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"5");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"7");
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {      // try to clean up as much memory as possible. next step is to terminate app
    
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {        // midnight, carrier time update, daylight savings time change
    
}

#pragma mark -
- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    // 1
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    // 2
}

#pragma mark -

#ifndef __IPHONE_10_0

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
}
#pragma clang diagnostic pop
#endif


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}



/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

#ifdef __IPHONE_9_0
// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    
}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    
}

#endif

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    
}

#ifdef __IPHONE_8_2
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply {
    
}

#endif

#ifdef __IPHONE_11_0
- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    
}

#endif


- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    
}


// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    
    return YES;
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    return nil;
}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    // 4
    return YES;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    
}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    // 5
    
}

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --


#ifdef __IPHONE_8_0
// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    return YES;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    // 从通用链接过来
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    return YES;
}


// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    
}

// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    
}

#endif

#pragma mark -- CloudKit Sharing Invitation Handling --
// This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
// You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
// the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
#ifdef __IPHONE_10_0
- (void)application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata {
    
}

#endif

#pragma mark - event response
- (void)closeLaunchScreen {
    [self.launchView hideAnimation];
}

#pragma mark - reuseable methods

#pragma mark - private methods

#pragma mark - getters and setters

@end

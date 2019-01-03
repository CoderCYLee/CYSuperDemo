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

@interface AppDelegate () <UNUserNotificationCenterDelegate>
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.launchView showAnimation];
        
        //设置3秒定时触发
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(closeLaunchScreen) userInfo:nil repeats:NO];
        
    });
    
//    if ([self.window respondsToSelector:@selector(traitCollection)]) {
//        if ([self.window.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
//            if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//                NSMutableArray *arrShortcutItem = [NSMutableArray array];
//                
//                UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.damon.DM3DTouchDemo.openSearch" localizedTitle:@"搜索" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
//                [arrShortcutItem addObject:shoreItem1];
//                
//                UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.damon.DM3DTouchDemo.openCompose" localizedTitle:@"新消息" localizedSubtitle:@"123" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
//                [arrShortcutItem addObject:shoreItem2];
//                
//                [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
//            }
//        }
//    }
    
    
    if (@available(iOS 9.0, *)) {
        
//        NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
        
//        NSMutableArray *arrShortcutItem = [NSMutableArray array];
//
//        UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.damon.DM3DTouchDemo.openSearch" localizedTitle:@"搜索" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
//        [arrShortcutItem addObject:shoreItem1];
//
//        UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"cn.damon.DM3DTouchDemo.openCompose" localizedTitle:@"新消息" localizedSubtitle:@"123" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
//        [arrShortcutItem addObject:shoreItem2];
//
//        [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
        
    } else {
        
    }
    
    
    if (@available(iOS 10.0, *)) {

        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        //2.通知中心设置分类
        [center setNotificationCategories:[NSSet setWithObjects:[self createCatrgory], nil]];
        
        //监听回调事件
        center.delegate = self;
        
        //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
        /*
         UNAuthorizationOptionBadge   = (1 << 0), 红色圆圈
         UNAuthorizationOptionSound   = (1 << 1), 声音
         UNAuthorizationOptionAlert   = (1 << 2), 内容
         UNAuthorizationOptionCarPlay = (1 << 3), 车载通知
         UNAuthorizationOptionCriticalAlert __IOS_AVAILABLE(12.0) __TVOS_AVAILABLE(12.0) __OSX_AVAILABLE(10.14) __WATCHOS_AVAILABLE(5.0) = (1 << 4),
         UNAuthorizationOptionProvidesAppNotificationSettings __IOS_AVAILABLE(12.0) __TVOS_AVAILABLE(12.0) __OSX_AVAILABLE(10.14) __WATCHOS_AVAILABLE(5.0) = (1 << 5),
         UNAuthorizationOptionProvisional
         */
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge + UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                NSLog(@"授权成功");
            }
            
        }];
        
        //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
        }];
        
        
//        // action
//        //文本交互(iOS10之后支持对通知的文本交互)
//
//        /**options
//         UNNotificationActionOptionAuthenticationRequired  用于文本
//         UNNotificationActionOptionForeground  前台模式，进入APP
//         UNNotificationActionOptionDestructive  销毁模式，不进入APP
//         */
//        UNTextInputNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:@"textInputAction" title:@"请输入信息" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"输入" textInputPlaceholder:@"还有多少话要说……"];
//
//        //打开应用按钮
//        UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"foreGround" title:@"打开" options:UNNotificationActionOptionForeground];
//
//        //不打开应用按钮
//        UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"backGround" title:@"关闭" options:UNNotificationActionOptionDestructive];
//
//        //创建分类
//        /**
//         Identifier:分类的标识符，通知可以添加不同类型的分类交互按钮
//         actions：交互按钮
//         intentIdentifiers：分类内部标识符  没什么用 一般为空就行
//         options:通知的参数   UNNotificationCategoryOptionCustomDismissAction:自定义交互按钮   UNNotificationCategoryOptionAllowInCarPlay:车载交互
//         */
//
//
//        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[textInputAction,action1,action2] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//
//        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
//

        
    } else {
        
    }
    
    
    return YES;
}


#pragma mark - 创建通知分类（交互按钮）

- (UNNotificationCategory *)createCatrgory
{
    //文本交互(iOS10之后支持对通知的文本交互)
    
    /**options
     UNNotificationActionOptionAuthenticationRequired  用于文本
     UNNotificationActionOptionForeground  前台模式，进入APP
     UNNotificationActionOptionDestructive  销毁模式，不进入APP
     */
    UNTextInputNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:@"textInputAction" title:@"请输入信息" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"输入" textInputPlaceholder:@"还有多少话要说……"];
    
    //打开应用按钮
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"foreGround" title:@"打开" options:UNNotificationActionOptionForeground];
    
    //不打开应用按钮
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"backGround" title:@"关闭" options:UNNotificationActionOptionDestructive];
    
    //创建分类
    /**
     Identifier:分类的标识符，通知可以添加不同类型的分类交互按钮
     actions：交互按钮
     intentIdentifiers：分类内部标识符  没什么用 一般为空就行
     options:通知的参数   UNNotificationCategoryOptionCustomDismissAction:自定义交互按钮   UNNotificationCategoryOptionAllowInCarPlay:车载交互
     */
    
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[textInputAction,action1,action2] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    return category;
}


#pragma mark - iOS10 UNUserNotificationCenterDelegate
// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
// iOS 10.0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // 前台收到通知
    
    //弹出一个网页
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 400, 500)];
    webview.center = self.window.center;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.window addSubview:webview];
    
    //弹出动画
    webview.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        webview.alpha = 1;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [webview removeFromSuperview];
    });
    
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSLog(@"iOS10 前台收到远程通知:%@", body);
//
//    } else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
//
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
   
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
// iOS 10.0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    //按钮点击事件
    
    
    //根据identifer判断按钮类型，如果是textInput则获取输入的文字
    if ([response.actionIdentifier isEqualToString:@"textInputAction"]) {
        
        //获取文本响应
        UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
        
        NSLog(@"输入的内容为：%@",textResponse.userText);
    }
    
    //处理其他时间
    NSLog(@"%@",response.actionIdentifier);
    
    completionHandler();
}

// The method will be called on the delegate when the application is launched in response to the user's request to view in-app notification settings. Add UNAuthorizationOptionProvidesAppNotificationSettings as an option in requestAuthorizationWithOptions:completionHandler: to add a button to inline notification settings view and the notification settings view in Settings. The notification will be nil when opened from Settings.
// iOS 12.0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
    
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
/*
*  当应用从活动状态主动到非活动状态的应用程序时会调用这个方法。
*  这可导致产生某些类型的临时中断（如传入电话呼叫或SMS消息）。
*  或者当用户退出应用程 序，它开始过渡到的背景状态。
*  使用此方法可以暂停正在进行的任务，禁用定时器，降低OpenGL ES的帧速率。
*  游戏应该使用这种方法来暂停游戏。
*  调用时机可能有以下几种：锁屏，按HOME键，下接状态栏，双击HOME键弹出低栏，等情况。
*/
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

/**
 *  进入后台
 *  当用户从台前状态转入后台时，调用此方法。使用此方法来释放资源共享，保存用户数据，无效计时器，
 *  并储存足够的应用程序状态信息的情况下被终止后，将应用 程序恢复到目前的状态。如果您的应用程序支持后台运行，
 *  这种方法被调用，否则调用applicationWillTerminate：用户退出。
 *
 *  @param application 应用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

/**
 *  程序将要进入前台台
 *
 *  @param application 应用
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"6");
}


// 当应用程序全新启动，或者在后台转到前台，完全激活时，都会调用这个方法。
// 如果应用程序是以前运行在后台，这时可以选择刷新用户界面
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"5");
}

// 当应用退出，并且进程即将结束时会调到这个方法，一般很少主动调到，更多是内存不足时是被迫调到的，我们应该在这个方法里做一些数据存储操作。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"7");
}


/*
 *  当应用可用内存不足时，会调用此方法，在这个方法中
 *  应该尽量去清理可能释放的内存。如果实在不行，可能会被强行退出应用
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {      // try to clean up as much memory as possible. next step is to terminate app
    
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {        // midnight, carrier time update, daylight savings time change
    
}

#pragma mark - StatusBar
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

#pragma mark - notifi

//#ifndef __IPHONE_10_0

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
/**
 *  调用完registerUserNotificationSettings:方法之后执行
 *  即调用startToGetPushToken获取权限后调用
 *
 *  @param application          应用
 *  @param notificationSettings 通知方式
 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

}

/**
 *  接收远程通知的时候调用此方法
 *  当应用在前台运行中，收到远程通知时，会回调这个方法。
 *   当应用在后台状态时，点击push消息启动应用，也会回调这个方法。
 *
 *  @param application 应用
 *  @param userInfo    通知信息
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

/**
 *  接收本地通知的时候调用此方法
 *  当应用收到本地通知时会调这个方法，同上面一个方法类似。
 *  如果在前台运行状态直接调用，如果在后台状态，点击通知启动时，也会回调这个方法
 *
 *  @param application  应用
 *  @param notification 本地通知
 */
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
//#endif

/**
 *  客户端注册远程通知时，成功后回调这个方法。
 *  客户端把deviceToken取出来发给服务端，push消息的时候要用。
 *
 *  @param application 应用
 *  @param deviceToken 设备token
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

/**
 当客户端注册远程通知时,如果失败了，会回调这个方法。可以从error参数中看一下失败原因。

 @param application 应用
 @param error 错误
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}



/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

#pragma mark - force touch
#ifdef __IPHONE_9_0
// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
/**
 *  3D Touch 如果App是从快速入口启动的，则会执行这个方法。该方法的shortcutItem参数携带了。
 *
 *  @param application       应用
 *  @param shortcutItem      从快速入口进入app时的标签参数
 *  @param completionHandler completionHandler
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    
}

#endif

#pragma mark -
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
    
    TabBarController *tabBarVC = (TabBarController *)self.window.rootViewController;
    [tabBarVC.navigationController2.topViewController restoreUserActivityState:userActivity];
    
    
    
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

//
//  HomeViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/5.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "HomeViewController.h"
#import <DeviceUtil.h>
#import "ThirdViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)init {
    if (self = [super init]) {
        DeviceUtil *util = [[DeviceUtil alloc] init];
        self.title = [NSString stringWithFormat:@"%@ (%@)",[util hardwareDescription], [util hardwareString]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Title" arguments:nil];
    content.subtitle = [NSString localizedUserNotificationStringForKey:@"SubTitle" arguments:nil];
//    content.subtitle = @"SubTitle";
    content.body = [NSString localizedUserNotificationStringForKey:@"Body fja;dlsjflk;adl;fkjkdlsajlfdajlsjl\nfadksjhjkfdsakfgadsfdags\nfdaskfdsagfgasdgjhfgdjsahk\n\n\n\n\n\nfhdasjfk\nBody fja;dlsjflk;adl;fkjkdlsajlfdajlsjl\nfadksjhjkfdsakfgadsfdags\nfdaskfdsagfgasdgjhfgdjsahk\na\nb\nc\nd\ne\nfhdasjfk" arguments:nil];
    content.badge = @1;
    
    NSError *error = nil;
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"jpg1" ofType:@"jpg"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"png1" ofType:@"png"];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"gif1" ofType:@"gif"];
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"video1" ofType:@"mp4"];
    
//    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
//
//    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    // 附件
    UNNotificationAttachment *jpgAtt = [UNNotificationAttachment attachmentWithIdentifier:@"jpg" URL:[NSURL fileURLWithPath:path1] options:nil error:&error];
    
    UNNotificationAttachment *pngAtt = [UNNotificationAttachment attachmentWithIdentifier:@"png" URL:[NSURL fileURLWithPath:path2] options:nil error:&error];
    
    UNNotificationAttachment *gifAtt = [UNNotificationAttachment attachmentWithIdentifier:@"gif" URL:[NSURL fileURLWithPath:path3] options:nil error:&error];
    
    UNNotificationAttachment *videoAtt = [UNNotificationAttachment attachmentWithIdentifier:@"video" URL:[NSURL fileURLWithPath:path4] options:nil error:&error];
    
    if (error) {
        
        NSLog(@"attachment error %@", error);
        
    }
    
    content.attachments = @[
//                            jpgAtt,
//                            pngAtt,
//                            gifAtt,
                            videoAtt
                            ];
    
    content.launchImageName = @"test1";
    content.categoryIdentifier = @"category";
    
    // action
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

    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
//
    // 声音
    content.sound = [UNNotificationSound defaultSound];
    
    // 触发模式
    // 在 alertTime 后推送本地推送
    // UNTimeIntervalNotificationTrigger 一段时间后触发
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    // UNCalendarNotificationTrigger ：调用triggerWithDateMatchingComponents:repeats: 进行注册；时间点信息用 NSDateComponents
    //每周日早上 8：00 提醒
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    components.weekday = 1;
//    components.hour = 8;
//    UNCalendarNotificationTrigger *trigger2 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];

    //NSDateComponets的注意点，有了时间并不能得到weekday
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    dateComponents.day = 11;
//    dateComponents.month = 7;
//    dateComponents.year = 2016;
//    //输出结果是NSDateComponentUndefined = NSIntegerMax
//    NSLog(@"%td", dateComponents.weekday);
//    //根据calendar计算出当天是周几
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *date = [gregorianCalendar dateFromComponents:dateComponents];
//    NSInteger weekday = [gregorianCalendar component:NSCalendarUnitWeekday fromDate:date];
//    NSLog(@"%td", weekday);
//
//    dateComponents.weekday = weekday;
//    NSLog(@"%@", dateComponents);
//
    
    // UNLocationNotificationTrigger：调用triggerWithRegion:repeats:进行注册，地区信息使用CLRegion，可以配置region属性 notifyOnEntry和notifyOnExit，是在进入地区、从地区出来或者两者都要的时候进行通知
//    //圆形区域，进入时候进行通知
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.335400, -122.009201);
//    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center
//                                                                 radius:2000.0 identifier:@"Headquarters"];
//    region.notifyOnEntry = YES;
//    region.notifyOnExit = NO;
//    UNLocationNotificationTrigger* trigger = [UNLocationNotificationTrigger
//                                              triggerWithRegion:region repeats:NO];

    // 设置UNNotificationRequest
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"CYNotification" content:content trigger:trigger];
    
    // add
    [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
        NSLog(@"成功添加推送");
    }];

    
}


@end

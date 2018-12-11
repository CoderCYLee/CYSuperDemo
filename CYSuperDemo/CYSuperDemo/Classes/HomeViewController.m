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
#import <MobileCoreServices/MobileCoreServices.h>

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

    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[@"myfhadjhfkda"] applicationActivities:nil];
    [vc setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        // 接收
        NSExtensionItem *item = [returnedItems firstObject];
        NSItemProvider *itemProvider = [item.attachments firstObject];
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSString *text, NSError * _Null_unspecified error) {
            NSLog(@"%@", text);
        }];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

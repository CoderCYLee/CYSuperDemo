//
//  BusinessChatViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "BusinessChatViewController.h"
#import <BusinessChat/BusinessChat.h>

@interface BusinessChatViewController ()

@end

@implementation BusinessChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.3, *)) {
        BCChatButton * btn = [[BCChatButton alloc]initWithStyle:BCChatButtonStyleDark];
       
        btn.frame = CGRectMake(50, 100, 200,100);
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)click{
    NSLog(@"message");
    if (@available(iOS 11.3, *)) {
        /*
         businessIdentifier为商户ID
         intentParameters为意图参数字典，其中可定义键值如下：
         BCParameterNameIntent 定义意图 用户发送消息时可以让商户更清楚用户的问题领域
         BCParameterNameGroup 定义组 帮助商户将问题分发明确的组
         BCParameterNameBody 信息内容
         */
        // 8d7f4b79-bf77-45ab-86b5-b74f56d47737 为网络上的测试id
        [BCChatAction openTranscript:@"8d7f4b79-bf77-45ab-86b5-b74f56d47737" intentParameters:@{BCParameterNameIntent:@"buy",BCParameterNameGroup:@"custom",BCParameterNameBody:@"Hello World"}];
    } else {
        // Fallback on earlier versions
    }
}

@end

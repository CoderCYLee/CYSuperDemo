//
//  ExtensionActionViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ExtensionActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ExtensionActionViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ExtensionActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 50);
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.textColor = [UIColor blackColor];
    self.textField.placeholder = @"请输入something";
    [self.view addSubview:self.textField];
    
    self.label = [[UILabel alloc] init];
    self.label.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 50);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    [self.view addSubview:self.label];
    
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(0, 250, CGRectGetWidth(self.view.frame), 50);
    [self.button setTitle:@"Action" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
}

- (void)action {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[self.textField.text] applicationActivities:nil];
    [vc setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        // 接收
        NSExtensionItem *item = [returnedItems firstObject];
        NSItemProvider *itemProvider = [item.attachments firstObject];
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSString *text, NSError * _Null_unspecified error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.label.text = text;
            }];
        }];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

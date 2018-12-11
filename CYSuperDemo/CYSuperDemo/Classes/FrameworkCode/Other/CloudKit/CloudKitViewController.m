//
//  CloudKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/21.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CloudKitViewController.h"
#import "CloudKeyValueViewController.h"
#import "CloudDocumentViewController.h"
#import "CloudCloudKitViewController.h"

@interface CloudKitViewController ()

@end

@implementation CloudKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *keyValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keyValueBtn.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 50);
    [keyValueBtn setTitle:@"key-value" forState:UIControlStateNormal];
    [keyValueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keyValueBtn addTarget:self action:@selector(keyValueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *documentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    documentBtn.frame = CGRectMake(0, 250, CGRectGetWidth(self.view.frame), 50);
    [documentBtn setTitle:@"Document" forState:UIControlStateNormal];
    [documentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [documentBtn addTarget:self action:@selector(documentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cloudKitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cloudKitBtn.frame = CGRectMake(0, 350, CGRectGetWidth(self.view.frame), 50);
    [cloudKitBtn setTitle:@"Cloud kit" forState:UIControlStateNormal];
    [cloudKitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cloudKitBtn addTarget:self action:@selector(cloudKitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:keyValueBtn];
    [self.view addSubview:documentBtn];
    [self.view addSubview:cloudKitBtn];
    
}

#pragma mark - evnet

- (void)keyValueBtnClicked
{
    CloudKeyValueViewController *vc = [[CloudKeyValueViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)documentBtnClicked
{
    CloudDocumentViewController *vc = [[CloudDocumentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cloudKitBtnClicked
{
    CloudCloudKitViewController *vc = [[CloudCloudKitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

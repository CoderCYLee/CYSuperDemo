//
//  CloudDocumentAddNewViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/22.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CloudDocumentAddNewViewController.h"
#import "CYICloudHandle.h"
#import "CYDocument.h"

@interface CloudDocumentAddNewViewController ()
@property (nonatomic ,strong) UITextField           *titleText;
@property (nonatomic ,strong) UITextView            *contentText;

@end

@implementation CloudDocumentAddNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpViews];
    
    if(_type == Document_type_edit)
    {
        self.titleText.text = self.fileName;
        [self getContent];
    }
}

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    [self.navigationItem setRightBarButtonItem:addBtnItem];
    
    self.titleText = [[UITextField alloc] init];
    self.titleText.frame = CGRectMake(10, 74, CGRectGetWidth(self.view.frame)-20, 40);
    self.titleText.textAlignment = NSTextAlignmentCenter;
    self.titleText.placeholder = @"请输入文件名";
    
    self.contentText = [[UITextView alloc] init];
    self.contentText.frame = CGRectMake(10, 124, CGRectGetWidth(self.view.frame)-20, 300);
    self.contentText.layer.borderWidth = 1;
    self.contentText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    [self.view addSubview:self.titleText];
    [self.view addSubview:self.contentText];
}

- (void)getContent
{
    CYDocument *doc = [[CYDocument alloc] initWithFileURL:[CYICloudHandle getUbiquityContauneURLWithFileName:self.fileName]];
    [doc openWithCompletionHandler:^(BOOL success) {
        
        if(success)
        {
            NSLog(@"读取数据成功。");
            
            NSString *docConten = [[NSString alloc] initWithData:doc.myData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",docConten);
            
            self.contentText.text = docConten;
        }
    }];
    
}

#pragma mark -
#pragma mark -

- (void)addBtnClicked
{
    
    if(_type == Document_type_addNew)
    {
        NSString *fileName = [NSString stringWithFormat:@"%@.txt",self.titleText.text];
        NSString *content = self.contentText.text;
        [CYICloudHandle createDocumentWithFileName:fileName content:content completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"成功");
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
            }
        }];
    }
    else if(_type == Document_type_edit)
    {
        [CYICloudHandle overwriteDocumentWithFileName:self.fileName content:self.contentText.text completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"成功");
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

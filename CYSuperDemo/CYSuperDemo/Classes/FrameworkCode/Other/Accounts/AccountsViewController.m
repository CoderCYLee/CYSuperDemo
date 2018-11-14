//
//  AccountsViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AccountsViewController.h"
#import <Accounts/Accounts.h>

@interface AccountsViewController ()

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建操作对象
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    //通过操作对象 构建社交平台类型示例  这里采用的新浪微博
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
    //进行用户授权请求
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (error) {
            NSLog(@"error = %@", [error localizedDescription]);
            return;
        }
        
        if (granted) {
            NSLog(@"授权通过了");
            
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            for (ACAccount *account in accounts) {
                NSLog(@"%@", account.accountDescription);
            }
        };
    }];
}

@end

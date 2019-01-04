//
//  AccountsViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AccountsViewController.h"
#import <Accounts/Accounts.h>
#import "AccountsDetailViewController.h"
#import <SVProgressHUD.h>

@interface AccountsViewController ()
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    if (@available(iOS 11.0, *)) {
        ShowMsg(@"iOS 11.0 以后Apple把这个废弃了");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = @"";
    switch (indexPath.row) {
        case 0:
            str = ACAccountTypeIdentifierTwitter;
            break;
        case 1:
            str = ACAccountTypeIdentifierSinaWeibo;
            break;
        case 2:
            str = ACAccountTypeIdentifierFacebook;
            break;
        case 3:
            str = ACAccountTypeIdentifierTencentWeibo;
            break;
        default:
            break;
    }
    [self requestWithAccountTypeIdentifier:str title:self.titleArr[indexPath.row]];
}

#pragma mark - ---

- (void)requestWithAccountTypeIdentifier:(NSString *)typeIdentifier title:(NSString *)title {
    //创建操作对象
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    //通过操作对象 构建社交平台类型示例  这里采用的新浪微博
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:typeIdentifier];
    
    //进行用户授权请求
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (error) {
            NSLog(@"error = %@", [error localizedDescription]);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            }];
            return;
        }
        
        if (granted) {
            NSLog(@"授权通过了");
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                if (accounts.count == 0) {
                    ShowMsg(@"您没有配置账号");
                    return;
                }
                AccountsDetailViewController *vc = [[AccountsDetailViewController alloc] init];
                vc.accounts = accounts;
                vc.navigationItem.title = title;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
        };
    }];
    
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"Twitter", @"SinaWeibo"];
    }
    return _titleArr;
}

@end

//
//  AccountsDetailViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AccountsDetailViewController.h"
#import <Accounts/Accounts.h>

@interface AccountsDetailViewController ()

@end

@implementation AccountsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellId"];
    }
    
    ACAccount *account = self.accounts[indexPath.row];
    cell.textLabel.text = account.username;
    cell.detailTextLabel.text = account.accountDescription;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)add:(ACAccount *)account {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if ([accountStore.accounts containsObject:account]) {
        ShowMsg(@"已经存在");
        return;
    }
    [accountStore renewCredentialsForAccount:account completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
        
    }];
}

- (void)remove:(ACAccount *)account {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if (![accountStore.accounts containsObject:account]) {
        ShowMsg(@"不存在");
        return;
    }
    [accountStore removeAccount:account withCompletionHandler:^(BOOL success, NSError *error) {
        
    }];
}

@end

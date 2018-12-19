//
//  ContactsViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ContactsViewController.h"

#import <Contacts/Contacts.h>

@interface ContactsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", @(NSFoundationVersionNumber));
    
    if (@available(iOS 9.0, *)) {
        CNContactStore *store = [[CNContactStore alloc] init];

        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized:

                break;
            case CNAuthorizationStatusNotDetermined:
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {

                    if (granted) {

                    }

                }];

                break;
            case CNAuthorizationStatusRestricted:

                break;
            case CNAuthorizationStatusDenied:

                break;

            default:
                break;
        }
    } else {
        ShowMsg(@"iOS 9.0 以上才能使用");
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - DataSource and Delegate

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - event response

#pragma mark - reuseable methods

#pragma mark - private methods

#pragma mark - getters and setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"New", @"Select"];
    }
    return _titleArr;
}

@end

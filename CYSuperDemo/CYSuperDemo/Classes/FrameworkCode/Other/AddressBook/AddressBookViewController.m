//
//  AddressBookViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AddressBookViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Masonry.h>
/*
 首先，AddressBook框架是一个已经过时的框架，iOS9之后官方提供了Contacts框架来进行用户通讯录相关操作。
 */

@interface AddressBookViewController ()
<
ABNewPersonViewControllerDelegate,
ABPeoplePickerNavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation AddressBookViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    
    [self getAuthCompletionHandler:^(bool granted) {
        if (granted) {
//            [self demo];
        }
    }];
    
}


#pragma mark - DataSource and Delegate

#pragma mark ABNewPersonViewControllerDelegate

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person {
    
    [newPersonView.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark ABPeoplePickerNavigationControllerDelegate
// 取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
}

// 选择
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    //拿到姓名
    //姓 需要转换成NSString类型
    NSString *lastNameValue = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //名
    NSString *firstNameValue = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSLog(@"%@:%@",lastNameValue,firstNameValue);
    //拿到电话 电话可能有多个
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //解析电话数据
    CFIndex phoneCount = ABMultiValueGetCount(phones);
    for (int j = 0; j < phoneCount ; j++) {
        //电话标签本地化(例如是住宅,工作等)
        NSString *phoneLabel = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, j));
        //拿到标签下对应的电话号码
        NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, j);
        NSLog(@"%@:%@",phoneLabel,phoneValue);
    }
    CFRelease(phones);
    
    //邮箱 可能多个
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
    CFIndex emailCount = ABMultiValueGetCount(emails);
    for (int k = 0; k < emailCount; k++) {
        NSString *emailLabel = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emails, k));
        NSString *emailValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, k);
        NSLog(@"%@:%@",emailLabel,emailValue);
    }
    NSLog(@"==============");
    CFRelease(emails);
    
    
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
}

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
            [self new];
            break;
        case 1:
            [self selectPerson];
            break;
            
        default:
            break;
    }
}

#pragma mark - event response

#pragma mark - reuseable methods

#pragma mark - private methods
- (void)new {
    ABNewPersonViewController *vc = [[ABNewPersonViewController alloc] init];
    vc.newPersonViewDelegate = self;
    [self showViewController:vc sender:self];
}

- (void)selectPerson {
    ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
    vc.peoplePickerDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)getAuthCompletionHandler:(void (^)(bool granted))handler {
    // 获取用户授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    // 如果尚未获取过授权 进行授权申请
    if (status == kABAuthorizationStatusNotDetermined) {
        // 创建通讯录对象 这个方法中第1个参数为预留参数 传NULL 即可 第2个参数可以传一个CFErrorRef的指针
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        // 请求授权
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            //            if (granted) {// 请求授权页面用户同意授权
            //                // 可以进行使用
            //            }
            //释放内存
            CFRelease(addressBookRef);
            
            handler(granted);
            
        });
    } else if (status == kABAuthorizationStatusAuthorized) {
        handler(YES);
    }
}

- (void)demo {
    //获取通讯录
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //获取联系人数量
    CFIndex personCount = ABAddressBookGetPersonCount(addressBook);
    //拿到所有联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (int i = 0; i < personCount; i++) {
        //获取记录
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        //拿到姓名
        //姓 需要转换成NSString类型
        NSString *lastNameValue = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        //名
        NSString *firstNameValue = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@:%@",lastNameValue,firstNameValue);
        //拿到电话 电话可能有多个
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        //解析电话数据
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (int j = 0; j < phoneCount ; j++) {
            //电话标签本地化(例如是住宅,工作等)
            NSString *phoneLabel = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, j));
            //拿到标签下对应的电话号码
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, j);
            NSLog(@"%@:%@",phoneLabel,phoneValue);
        }
        CFRelease(phones);
        
        //邮箱 可能多个
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFIndex emailCount = ABMultiValueGetCount(emails);
        for (int k = 0; k < emailCount; k++) {
            NSString *emailLabel = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emails, k));
            NSString *emailValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, k);
            NSLog(@"%@:%@",emailLabel,emailValue);
        }
        NSLog(@"==============");
        CFRelease(emails);
    }
    CFRelease(addressBook);
    CFRelease(peopleArray);
    
}

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

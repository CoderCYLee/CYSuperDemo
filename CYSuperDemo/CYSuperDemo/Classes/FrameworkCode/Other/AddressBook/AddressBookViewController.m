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

/*
 首先，AddressBook框架是一个已经过时的框架，iOS9之后官方提供了Contacts框架来进行用户通讯录相关操作。
 */

@interface AddressBookViewController () <ABNewPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"ABUI" forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 200, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(ABUITap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self getAuthCompletionHandler:^(bool granted) {
        if (granted) {
            
        }
    }];
}

- (void)ABUITap {
//    ABNewPersonViewController *vc = [[ABNewPersonViewController alloc] init];
//    vc.newPersonViewDelegate = self;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
    
    
    ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
    vc.peoplePickerDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];

}

#pragma mark - Private

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

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person {
    
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate
// 取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
}

// 选择
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
}

@end

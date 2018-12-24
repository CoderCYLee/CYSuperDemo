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

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", @(NSFoundationVersionNumber));
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressBookDidChange:) name:CNContactStoreDidChangeNotification object:nil];
    
    
    if (@available(iOS 9.0, *)) {
        CNContactStore *store = [[CNContactStore alloc] init];

        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized:

                break;
            case CNAuthorizationStatusNotDetermined:
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {

                    if (granted) {
                        NSLog(@"授权成功");
                    } else {
                        NSLog(@"授权失败!");
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
            [self new];
            break;
        case 1:
            [self select];
            break;
            
        default:
            break;
    }
}

#pragma mark - event response
- (void)addressBookDidChange:(NSNotification *)notifi {
    
}

#pragma mark - reuseable methods
- (void)new {
    CNMutableContact *contact = [[CNMutableContact alloc] init]; // 第一次运行的时候，会获取通讯录的授权（对通讯录进行操作，有权限设置）
    
    contact.namePrefix = @"n";
    // 1、添加姓名（姓＋名）
    contact.givenName = @"g";
    contact.middleName = @"m";
    contact.familyName = @"f";
    contact.previousFamilyName = @"pf";
    contact.nameSuffix = @"ns";
    contact.nickname = @"nickname";
    // 2、添加职位相关
    contact.organizationName = @"公司名称";
    contact.departmentName = @"开发部门";
    contact.jobTitle = @"工程师";
    
    // 3、这一部分内容会显示在联系人名字的下面，phoneticFamilyName属性设置的话，会影响联系人列表界面的排序
    //    contact.phoneticGivenName = @"GivenName";
    //    contact.phoneticFamilyName = @"FamilyName";
    //    contact.phoneticMiddleName = @"MiddleName";
    
    // 4、备注
    contact.note = @"同事";
    
    // 5、头像
    contact.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"yun"]);
    
    // 6、添加生日
    NSDateComponents *birthday = [[NSDateComponents alloc] init];
    birthday.year = 1991;
    birthday.month = 5;
    birthday.day = 6;
    contact.birthday = birthday;
    
    // 7、添加邮箱
    CNLabeledValue *homeEmail = [CNLabeledValue labeledValueWithLabel:CNLabelEmailiCloud value:@"pennyberry29@live.com"];
//    CNLabeledValue *workEmail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"11111888888"];
//    CNLabeledValue *iCloudEmail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"34454554"];
//    CNLabeledValue *otherEmail = [CNLabeledValue labeledValueWithLabel:CNLabelOther value:@"6565448"];
    contact.emailAddresses = @[homeEmail];
    
    // 8、添加电话
    CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:@"11122233344"]];
    contact.phoneNumbers = @[homePhone];
    
    // 9、添加urlAddresses,
    CNLabeledValue *homeurl = [CNLabeledValue labeledValueWithLabel:CNLabelURLAddressHomePage value:@"https://baidu.com"];
    contact.urlAddresses = @[homeurl];
    
    // 10、添加邮政地址
    CNMutablePostalAddress *postal = [[CNMutablePostalAddress alloc] init];
    postal.city = @"北京";
    postal.country =  @"中国";
    CNLabeledValue *homePostal = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:postal];
    contact.postalAddresses = @[homePostal];
    
    // 获取通讯录操作请求对象
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addContact:contact toContainerWithIdentifier:nil]; // 添加联系人操作（同一个联系人可以重复添加）
    // 获取通讯录
    CNContactStore *store = [[CNContactStore alloc] init];
    // 保存联系人
    NSError *error = nil;
    [store executeSaveRequest:request error:&error]; // 通讯录有变化之后，还可以监听是否改变（CNContactStoreDidChangeNotification）
    
}

- (void)select {
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 2.如果没有授权,先执行授权失败的block后return
    if (status != CNAuthorizationStatusAuthorized)
    {
        return;
    }
    // 3.获取联系人
    // 3.1.创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    // 3.2.创建联系人的请求对象
    // keys决定能获取联系人哪些信息,例:姓名,电话,头像等
    NSArray *fetchKeys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    
    // 3.3.请求联系人
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact,BOOL * _Nonnull stop) {
        
        // 获取联系人全名
        NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
        NSLog(@"name: %@", name);
       
        // 获取一个人的所有电话号码
        NSArray *phones = contact.phoneNumbers;
        
        for (CNLabeledValue *labelValue in phones)
        {
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSLog(@"phoneNumber: %@", phoneNumber.stringValue);
        }
    }];
}

- (void)deleteContact:(CNMutableContact *)contact {
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteContact:contact];
    // 写入操作
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];
}

- (void)updateContact:(CNMutableContact *)contact {
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateContact:contact];
    // 重新写入
    CNContactStore *store = [[CNContactStore alloc] init];
    [store executeSaveRequest:saveRequest error:nil];
    
}

- (NSArray *)queryContactWithName:(NSString *)name {
    CNContactStore *store = [[CNContactStore alloc] init];
    //检索条件
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    
    //过滤的条件，也可以过滤时候格式化
    NSArray *keysToFetch = @[CNContactEmailAddressesKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
    
    NSArray *contact = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keysToFetch error:nil];
    return contact;
}

#pragma mark - private methods

#pragma mark - getters and setters

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"New", @"Select"];
    }
    return _titleArr;
}

@end

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
    }

}

@end

//
//  FrameworkCodeTableViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "FrameworkCodeTableViewController.h"

@interface FrameworkCodeTableViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation FrameworkCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    
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
    NSString *typeName = self.titleArr[indexPath.row];
    NSString *className = [NSString stringWithFormat:@"%@ViewController", typeName];
    
    __kindof UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.navigationItem.title = typeName;
//    if ([vc respondsToSelector:@selector(setTitle:)]) {
//        [vc performSelector:@selector(setTitle:) withObject:typeName];
//    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"Foundation", @"UIKit", @"Accounts", @"AddressBook", @"AdSupport", @"ARKit", @"AudioToolbox", @"AuthenticationServices", @"AVFoundation", @"AVKit", @"BusinessChat", @"CallKit", @"CarPlay", @"CloudKit", @"Contacts", @"CoreAudioKit", @"CoreBluetooth", @"CoreML", @"CoreMotion", @"CoreNFC", @"CoreTelephony", @"CoreText", @"CoreVideo", @"DeviceCheck", @"EventKit", @"HealthKit", @"IAD", @"LocalAuthentication", @"MapKit", @"MediaPlayer", @"Network", @"PassKit", @"PDFKit", @"PushKit", @"QuickLook", @"ReplayKit", @"SafariServices", @"Speech", @"StoreKit", @"UserNotifications"];
    }
    return _titleArr;
}

@end

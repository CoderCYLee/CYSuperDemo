//
//  IOS11APISampleCodeListTableViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/8.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "IOS11APISampleCodeListTableViewController.h"
#import <DeviceCheck/DeviceCheck.h>

@interface IOS11APISampleCodeListTableViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation IOS11APISampleCodeListTableViewController

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
    
    if (indexPath.row == 0) {
        [self deviceCheck];
        return;
    }
    
    NSString *typeName = self.titleArr[indexPath.row];
    [self.navigationController pushViewController:[self getControllerWithString:typeName] animated:YES];
}

- (id)getControllerWithString:(NSString *)string {
    
    NSString *className = [NSString stringWithFormat:@"%@ViewController", string];
    return [[NSClassFromString(className) alloc] init];
}

- (void)deviceCheck {
    if (@available(iOS 11.0, *)) {
        [[DCDevice currentDevice] generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
            if (error) {
                // Do what you want
                
            } else {
                // Upload token to App server
                NSLog(@"%@", token ?: @"No Data");
                
                //                [token ]
            }
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"DeviceCheck", @"CoreNFC", @"ARKit", @"MapKit"];
    }
    return _titleArr;
}

@end

//
//  CoreMotionViewControllerTableViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CoreMotionViewController.h"

@interface CoreMotionViewController ()

@property (nonatomic, copy) NSArray *titleArr;

@end

@implementation CoreMotionViewController

#pragma mark - life cycle
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
    NSString *str = self.titleArr[indexPath.row];
    cell.textLabel.text = NSLocalizedString(str, str);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *typeName = self.titleArr[indexPath.row];
    NSString *localStr = NSLocalizedString(typeName, typeName);
    
    NSString *className = [NSString stringWithFormat:@"%@ViewController", typeName];
    
    id vc = [[NSClassFromString(className) alloc] init];
    if ([vc respondsToSelector:@selector(setTitle:)]) {
        [vc performSelector:@selector(setTitle:) withObject:localStr];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getters and setters
- (NSArray *)titleArr
{
    /*
     "Accelerometer" = "加速器";
     "Gyroscope" = "陀螺仪";
     "Megnetometer" = "磁力计";
     "DeviceMotion" = "设备定位";
     "Shake" = "震动";
     "Proximity" = "距离传感器";
     */
    if (!_titleArr) {
        _titleArr = @[@"Accelerometer", @"Gyroscope", @"Megnetometer", @"DeviceMotion", @"Shake", @"Proximity"];
    }
    return _titleArr;
}

@end

//
//  LocalAuthenticationViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2019/1/2.
//  Copyright © 2019 Cyrill. All rights reserved.
//

#import "LocalAuthenticationViewController.h"

@interface LocalAuthenticationViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation LocalAuthenticationViewController

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

#pragma mark - getter

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"TouchID", @"FaceID"];
    }
    return _titleArr;
}

@end

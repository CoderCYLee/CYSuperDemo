//
//  SecondViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/7.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
    [self.navigationController pushViewController:[self getControllerWithString:typeName] animated:YES];
}

- (id)getControllerWithString:(NSString *)string {
    NSString *className = [NSString stringWithFormat:@"%@TableViewController", string];
    return [[NSClassFromString(className) alloc] init];
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"APISampleCodeList", @"FrameworkCode"];
    }
    return _titleArr;
}

@end

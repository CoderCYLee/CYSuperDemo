//
//  SpeechViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/18.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SpeechViewController.h"
#import <Speech/Speech.h>
#import <Masonry.h>

@interface SpeechViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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
    
    if (@available(iOS 10.0, *)) {
        
    } else {
        ShowMsg(@"iOS 10.0 以上才能使用");
        return;
    }
    
    NSString *typeName = self.titleArr[indexPath.row];
    NSString *className = [NSString stringWithFormat:@"Speech%@ViewController", typeName];
    

    id vc = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
    if ([vc respondsToSelector:@selector(setTitle:)]) {
        [vc performSelector:@selector(setTitle:) withObject:typeName];
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"Demo1", @"Demo2"];
    }
    return _titleArr;
}

@end

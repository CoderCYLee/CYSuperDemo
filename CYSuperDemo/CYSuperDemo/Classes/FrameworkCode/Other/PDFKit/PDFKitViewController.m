//
//  PDFKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/9.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFKitViewController.h"
#import "PDFDetailViewController.h"
#import "PDFKitTableViewCell.h"
#import <PDFKit/PDFKit.h>

@interface PDFKitViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PDFKitViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PDFKitTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self requestData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDFKitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    if (@available(iOS 11.0, *)) {
        cell.document = self.dataArray[indexPath.row];
    } else {
        // Fallback on earlier versions
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        PDFDocument *document = self.dataArray[indexPath.row];
        PDFDetailViewController *vc = [[PDFDetailViewController alloc] initWithNibName:@"PDFDetailViewController" bundle:nil];
        vc.document = document;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // Fallback on earlier versions
        ShowMsg(@"iOS 11.0 以上可用");
    }
}

#pragma mark - event response

#pragma mark - reuseable methods
- (void)requestData {
    NSArray<NSURL *> *arr = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"pdf" subdirectory:@""];
  
    if (@available(iOS 11.0, *)) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PDFDocument *document = [[PDFDocument alloc] initWithURL:obj];
            [tmpArr addObject:document];
        }];
        
        self.dataArray = tmpArr;
        
        
        [self.tableView reloadData];
        
    } else {
        // Fallback on earlier versions
    }
    
    
}

#pragma mark - private methods

#pragma mark - getters and setters
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end

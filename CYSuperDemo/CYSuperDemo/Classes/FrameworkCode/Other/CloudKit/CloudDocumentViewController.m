//
//  CloudDocumentViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/22.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CloudDocumentViewController.h"
#import "CloudDocumentAddNewViewController.h"
#import "CYICloudHandle.h"
#import "CYDocument.h"
#import "CYCategories.h"

@interface CloudDocumentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView               *mainTableView;
@property (nonatomic ,copy)   NSMutableArray                   *dataArr;
@property (nonatomic ,strong) NSMetadataQuery           *myMetadataQuery;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation CloudDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myMetadataQuery = [[NSMetadataQuery alloc] init];
    
    [self setUpViews];
    [self setUpNotification];
    [CYICloudHandle getNewDocument:self.myMetadataQuery];
}

- (void)setUpViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Document";
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    [self.navigationItem setRightBarButtonItem:addBtnItem];
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    
    [self.view addSubview:self.mainTableView];
    
    
    if (@available(iOS 10.0, *)) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
        self.mainTableView.refreshControl = self.refreshControl;
    }
    
}



- (void)setUpNotification
{
    //获取最新数据完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedGetNewDocument:) name:NSMetadataQueryDidFinishGatheringNotification object:self.myMetadataQuery];
    
    //数据更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentDidChange:) name:NSMetadataQueryDidUpdateNotification object:self.myMetadataQuery];
    
}


#pragma mark -
#pragma mark - events
- (void)handleRefresh {
    
    [self refreshTabView];
}

-(void)refreshTabView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CYICloudHandle getNewDocument:self.myMetadataQuery];
        if ([self.mainTableView.refreshControl isRefreshing]) {
            
            [self.mainTableView.refreshControl endRefreshing];
        }
    });
}

- (void)addBtnClicked
{
    CloudDocumentAddNewViewController *vc = [[CloudDocumentAddNewViewController alloc] init];
    vc.type = Document_type_addNew;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSMetadataItem *item = [self.dataArr objectAtIndex:indexPath.row];
    
    //获取文件名
    NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
    cell.textLabel.text = fileName;
    
    //获取文件创建日期
    NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
    cell.detailTextLabel.text = [date dateString];

//    NSLog(@"%@,%@",fileName,date);
//
//    CYDocument *doc = [[CYDocument alloc] initWithFileURL:[CYICloudHandle getUbiquityContauneURLWithFileName:fileName]];
//    [doc openWithCompletionHandler:^(BOOL success) {
//
//        if(success)
//        {
//            NSLog(@"读取数据成功。");
//
//            NSString *docConten = [[NSString alloc] initWithData:doc.myData encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",docConten);
//        }
//    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMetadataItem *item = [self.dataArr objectAtIndex:indexPath.row];
    
    //获取文件名
    NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
    
    CloudDocumentAddNewViewController *vc = [[CloudDocumentAddNewViewController alloc] init];
    vc.fileName = fileName;
    vc.type = Document_type_edit;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMetadataItem *item = [self.dataArr objectAtIndex:indexPath.row];
        
        //获取文件名
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        [CYICloudHandle removeDocumentWithFileName:fileName];
        
        [self.dataArr removeObject:item];
        
        [self.mainTableView reloadData];
    }
}


#pragma mark -
#pragma mark - NSNotificationCenter


- (void)finishedGetNewDocument:(NSMetadataQuery *)metadataQuery
{
    
    NSArray *item =self.myMetadataQuery.results;
    self.dataArr = [NSMutableArray arrayWithArray:item];
    [self.mainTableView reloadData];
    
    [item enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMetadataItem *item = obj;
        
        //获取文件名
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        //获取文件创建日期
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        
        NSLog(@"%@,%@",fileName,date);
        
        CYDocument *doc = [[CYDocument alloc] initWithFileURL:[CYICloudHandle getUbiquityContauneURLWithFileName:fileName]];
        [doc openWithCompletionHandler:^(BOOL success) {
            
            if(success)
            {
                NSLog(@"读取数据成功。");
                
                NSString *docConten = [[NSString alloc] initWithData:doc.myData encoding:NSUTF8StringEncoding];
                NSLog(@"%@",docConten);
            }
        }];
    }];
}


- (void)documentDidChange:(NSMetadataQuery *)metadataQuery
{
    NSLog(@"Document 数据更新");
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

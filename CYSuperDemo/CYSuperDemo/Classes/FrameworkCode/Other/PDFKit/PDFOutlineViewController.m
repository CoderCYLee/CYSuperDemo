//
//  PDFOutlineViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFOutlineViewController.h"
#import <PDFKit/PDFKit.h>
#import "PDFOutlineCell.h"
#import <Masonry.h>

@interface PDFOutlineViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation PDFOutlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Outline";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleAction)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)cancleAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - --- Customed Methods ---

- (void)insertOulineWithParentOutline:(PDFOutline *)parentOutline
API_AVAILABLE(ios(11.0)){
    NSInteger baseIndex = [self.arrData indexOfObject:parentOutline];
    
    for (int i = 0; i < parentOutline.numberOfChildren; i++)
    {
        PDFOutline *tempOuline = [parentOutline childAtIndex:i];
        tempOuline.isOpen = NO;
        [self.arrData insertObject:tempOuline atIndex:baseIndex + i + 1];
    }
}

- (void)removeOutlineWithParentOuline:(PDFOutline *)parentOutline
API_AVAILABLE(ios(11.0)){
    
    if (parentOutline.numberOfChildren <= 0)
    {
        return;
    }
    
    for (int i = 0; i < parentOutline.numberOfChildren; i++)
    {
        PDFOutline *node = [parentOutline childAtIndex:i];
        
        if (node.numberOfChildren > 0 && node.isOpen)
        {
            [self removeOutlineWithParentOuline:node];
            
            NSInteger index = [self.arrData indexOfObject:node];
            
            if (index)
            {
                [self.arrData removeObjectAtIndex:index];
            }
        }
        else
        {
            if ([self.arrData containsObject:node])
            {
                NSInteger index = [self.arrData indexOfObject:node];
                
                if (index)
                {
                    [self.arrData removeObjectAtIndex:index];
                }
            }
        }
    }
}

- (NSInteger)findDepthWithOutline:(PDFOutline *)outline
API_AVAILABLE(ios(11.0)){
    NSInteger depth = -1;
    if (@available(iOS 11.0, *)) {
        PDFOutline *tempOutline = outline;
        
        while (tempOutline.parent != nil)
        {
            depth++;
            tempOutline = tempOutline.parent;
        }
    }
    return depth;
}

#pragma mark - --- UITableView DataSource ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDFOutlineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    if (@available(iOS 11.0, *)) {
        PDFOutline *outline = self.arrData[indexPath.row];
        
        cell.lblTitle.text = outline.label;
        cell.lblPage.text = outline.destination.page.label;
        cell.btnArrow.selected = outline.isOpen;
        
        if (outline.numberOfChildren > 0)
        {
            [cell.btnArrow setImage:outline.isOpen ? [UIImage imageNamed:@"xia"] : [UIImage imageNamed:@"you"] forState:UIControlStateNormal];
            [cell.btnArrow setEnabled:YES];
        }
        else
        {
            [cell.btnArrow setImage:nil forState:UIControlStateNormal];
            [cell.btnArrow setEnabled:NO];
        }
        
        cell.outlineBlock = ^(UIButton * _Nonnull button) {
            
            if (outline.numberOfChildren > 0)
            {
                if (button.isSelected)
                {
                    outline.isOpen = YES;
                    [self insertOulineWithParentOutline:outline];
                }
                else
                {
                    outline.isOpen = NO;
                    [self removeOutlineWithParentOuline:outline];
                }
                
                [tableView reloadData];
            }
            
        };
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger depth = 0;
    if (@available(iOS 11.0, *)) {
        PDFOutline *outline = self.arrData[indexPath.row];
        depth = [self findDepthWithOutline:outline];
    } 
    return depth;
}

#pragma mark - --- UITableView Delegate ---

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    if (@available(iOS 11.0, *)) {
        PDFOutline *outline = [self.arrData objectAtIndex:indexPath.row];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(outlineViewController:didSelectOutline:)])
        {
            [self.delegate outlineViewController:self didSelectOutline:outline];
        }
        
        [self cancleAction];
    }
}

#pragma mark - --- Setter & Getter ---

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDFOutlineCell class]) bundle:nil] forCellReuseIdentifier:@"CellId"];
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

- (NSMutableArray *)arrData
{
    if (!_arrData)
    {
        _arrData = [[NSMutableArray alloc] init];
    }
    
    return _arrData;
}

- (void)setOutlineRoot:(PDFOutline *)outlineRoot
API_AVAILABLE(ios(11.0)){
    _outlineRoot = outlineRoot;
    
    if (@available(iOS 11.0, *)) {
        for (int i = 0; i < outlineRoot.numberOfChildren; i++)
        {
            PDFOutline *outline = [outlineRoot childAtIndex:i];
            outline.isOpen = NO;
            [self.arrData addObject:outline];
        }
        
        [self.tableView reloadData];
    }
}

@end

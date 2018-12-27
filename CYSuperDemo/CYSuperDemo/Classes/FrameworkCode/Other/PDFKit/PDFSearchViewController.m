//
//  PDFSearchViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFSearchViewController.h"
#import <PDFKit/PDFKit.h>
#import "PDFSeachCell.h"

@interface PDFSearchViewController ()
<
UISearchBarDelegate,
UITableViewDelegate,
UITableViewDataSource,
PDFDocumentDelegate
>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation PDFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.searchBar;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

- (void)cancleAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    PDFSeachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    if (@available(iOS 11.0, *)) {
        PDFSelection *selection = self.arrData[indexPath.row];
        PDFPage *page = selection.pages[0];
        PDFOutline *outline = [self.document outlineItemForSelection:selection];
        
        NSString *destinationStr = [NSString stringWithFormat:@"%@  PAGE: %@", outline.label, page.label];
        
        cell.lblDestination.text = destinationStr;
        
        PDFSelection *extendSelection = [selection copy];
        [extendSelection extendSelectionAtStart:10];
        [extendSelection extendSelectionAtEnd:90];
        [extendSelection extendSelectionForLineBoundaries];
        
        NSRange range = [extendSelection.string rangeOfString:selection.string options:NSCaseInsensitiveSearch];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:extendSelection.string];
        [attrStr addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:range];
        
        cell.lblResult.attributedText = attrStr;
    }
    return cell;
}

#pragma mark - --- UITableView Delegate ---

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    
    if (@available(iOS 11.0, *)) {
        PDFSelection *selection = self.arrData[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewController:didSelectSearchResult:)])
        {
            [self.delegate searchViewController:self didSelectSearchResult:selection];
        }
        
        [self cancleAction];
    } else {
        // Fallback on earlier versions
    }
    
}

#pragma mark - --- UIScrollView Delegate ---

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - --- UISearchBar Delegate ---

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.document cancelFindString];
    [self cancleAction];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length < 2)
    {
        return;
    }
    
    [self.arrData removeAllObjects];
    [self.tableView reloadData];
    
    [self.document cancelFindString];
    self.document.delegate = self;
    [self.document beginFindString:searchText withOptions:NSCaseInsensitiveSearch];
}

#pragma mark - --- PDFDocument Delegate ---

- (void)didMatchString:(PDFSelection *)instance
API_AVAILABLE(ios(11.0)){
    [self.arrData addObject:instance];
    [self.tableView reloadData];
}

#pragma mark - --- setter & getter ---

- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    
    return _searchBar;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDFSeachCell class]) bundle:nil] forCellReuseIdentifier:@"CellId"];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 150;
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

@end

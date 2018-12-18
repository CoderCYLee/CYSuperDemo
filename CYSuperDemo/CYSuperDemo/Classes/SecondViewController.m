//
//  SecondViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/7.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *system = NSLocalizedString(@"System", @"System");
    self.navigationItem.title = system;
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
    
    // Force Touch
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:cell];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *typeName = self.titleArr[indexPath.row];
    id vc = [self getControllerWithString:typeName];
    if ([vc respondsToSelector:@selector(setTitle:)]) {
        [vc performSelector:@selector(setTitle:) withObject:typeName];
    }
    [self showViewController:vc sender:self];
//    [self showDetailViewController:vc sender:self];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (id)getControllerWithString:(NSString *)string {
    NSString *className = [NSString stringWithFormat:@"%@TableViewController", string];
    return [[NSClassFromString(className) alloc] init];
}

// If you return nil, a preview presentation will not be performed
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    UIGestureRecognizer *previewingGestureRecognizerForFailureRelationship = previewingContext.previewingGestureRecognizerForFailureRelationship;
    
    id<UIViewControllerPreviewingDelegate> delegate = previewingContext.delegate;
    UITableViewCell *sourceView = (UITableViewCell *)previewingContext.sourceView;
    
    // This rect will be set to the bounds of sourceView before each call to
    // -previewingContext:viewControllerForLocation:
    CGRect sourceRect = previewingContext.sourceRect;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sourceView];
    NSString *typeName = [NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    
    
    //创建要预览的控制器
    id vc = [self getControllerWithString:typeName];
    if ([vc respondsToSelector:@selector(setTitle:)]) {
        [vc performSelector:@selector(setTitle:) withObject:typeName];
    }
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    previewingContext.sourceRect = rect;
    
    return vc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    
    [self showViewController:viewControllerToCommit sender:self];
}


- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"FrameworkCode", @"Extension"];
    }
    return _titleArr;
}

@end

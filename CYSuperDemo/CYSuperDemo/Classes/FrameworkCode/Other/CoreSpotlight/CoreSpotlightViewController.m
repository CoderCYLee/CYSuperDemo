//
//  CoreSpotlightViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2019/3/21.
//  Copyright © 2019 Cyrill. All rights reserved.
//

#import "CoreSpotlightViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <CoreServices/CoreServices.h>

@interface CoreSpotlightViewController ()

@end

@implementation CoreSpotlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建索引属性对象
    CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeText];
    //设置索引属性
    set.title = @"哈哈哈";
    set.displayName = @"Hello";
    set.alternateNames = @[@"aaa",@"bbb"];
    set.keywords = @[@"333",@"444"];
    set.version = @"1.1";
    set.path = @"path";
    set.thumbnailURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"png1" ofType:@"png"]];
    set.contentURL = [NSURL URLWithString:@"https://www.baidu.com"];
    //创建索引
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"1111" domainIdentifier:@"vvvvvvv" attributeSet:set];
    //添加索引
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"buildSearchableItem Error:%@",error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

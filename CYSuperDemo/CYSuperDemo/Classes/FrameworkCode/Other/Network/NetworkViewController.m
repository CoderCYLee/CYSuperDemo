 //
//  NetworkViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/9.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "NetworkViewController.h"
#import <Network/Network.h>

@interface NetworkViewController ()

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (id)[UIImage imageNamed:@"Icon_Home"].CGImage;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon_Home"]];
    
    
    
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

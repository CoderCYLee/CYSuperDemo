//
//  ThirdViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/10.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView.subviews firstObject];
}

@end

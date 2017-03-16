//
//  ViewController.m
//  CYSuperDemo
//
//  Created by Cyrill on 2017/3/15.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "ViewController.h"
#import "CYAudioUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[[CYAudioUtility alloc] init] playAduio:@"8436" ext:@"wav"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

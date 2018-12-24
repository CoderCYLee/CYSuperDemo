//
//  MotionActivityViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "MotionActivityViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface MotionActivityViewController ()

@property (nonatomic, strong) CMMotionActivityManager *motionActivityManager;
@property (nonatomic, strong) NSDateFormatter *dateFormater;
@property (nonatomic, strong) UILabel *timeStampLabel;
@property (nonatomic, strong) UILabel *currentStateLabel;
@property (nonatomic, strong) UILabel *confidenceLabel;

@end

@implementation MotionActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    _currentStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 200, 30)];
    _confidenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 200, 30)];
    
    [self.view addSubview:self.timeStampLabel];
    [self.view addSubview:self.currentStateLabel];
    [self.view addSubview:self.confidenceLabel];
    
    self.motionActivityManager = [[CMMotionActivityManager alloc] init];
    self.dateFormater = [[NSDateFormatter alloc] init];
    self.dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    __weak typeof (self)weakSelf = self;
    [self.motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity)
     {
         weakSelf.timeStampLabel.text = [weakSelf.dateFormater stringFromDate:[NSDate date]];
         
         if (activity.unknown) {
             weakSelf.currentStateLabel.text = @"未知状态";
         } else if (activity.walking) {
             weakSelf.currentStateLabel.text = @"步行";
         } else if (activity.running) {
             weakSelf.currentStateLabel.text = @"跑步";
         } else if (activity.automotive) {
             weakSelf.currentStateLabel.text = @"驾车";
         } else if (activity.stationary) {
             weakSelf.currentStateLabel.text = @"静止";
         }
         
         if (activity.confidence == CMMotionActivityConfidenceLow) {
             weakSelf.confidenceLabel.text = @"准确度  低";
         } else if (activity.confidence == CMMotionActivityConfidenceMedium) {
             weakSelf.confidenceLabel.text = @"准确度  中";
         } else if (activity.confidence == CMMotionActivityConfidenceHigh) {
             weakSelf.confidenceLabel.text = @"准确度  高";
         }
         
     }];
}

@end

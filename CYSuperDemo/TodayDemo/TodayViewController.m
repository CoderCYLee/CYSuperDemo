//
//  TodayViewController.m
//  TodayDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NSDate+CY.h"

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    self.label.text = [NSDate currentDateString];
    
    completionHandler(NCUpdateResultNewData);
}

- (IBAction)tap:(id)sender {
    // superdemo 是主体app定义的 schemes
    NSURL *url = [NSURL URLWithString:@"superdemo://"];
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
    }];
}

@end

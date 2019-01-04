//
//  LaunchView.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "LaunchView.h"

@interface LaunchView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation LaunchView

- (void)showAnimation {
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //让其在z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];//旋转角度
    rotationAnimation.duration = 3; //旋转周期
    rotationAnimation.cumulative = YES;//旋转累加角度
    rotationAnimation.repeatCount = 100000;//旋转次数
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.versionLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Version", @"Version"), AppVersion];
    [UIView animateWithDuration:0.3 animations:^{
        self.versionLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideAnimation {
    
    //    [self.imageView.layer removeAllAnimations];
    
    [UIView animateWithDuration:1 animations:^{
        self.versionLabel.alpha = 0;
        self.imageView.alpha = 0;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end

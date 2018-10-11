//
//  UIButton+CYTouch.h
//  PutiBaby
//
//  Created by Cyrill on 2015/2/29.
//  Copyright © 2015年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .5  //默认时间间隔
@interface UIButton (CYTouch)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end

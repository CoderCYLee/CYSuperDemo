//
//  CYRoundedButton.h
//  MkmyIOS
//
//  Created by cyrill on 2016/10/9.
//  Copyright © 2016 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CYRoundedButton : UIButton

@property (nonatomic, assign) IBInspectable NSUInteger style;
@property (nonatomic, assign) IBInspectable CGFloat cy_cornerRaduous;

@end

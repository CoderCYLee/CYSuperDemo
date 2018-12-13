//
//  PhotoEditingViewController.h
//  PhotoEditingDemo
//
//  Created by cyrill on 2018/12/13.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoEditingViewController : UIViewController
{
    NSString *filterName;
}
@property (weak, nonatomic) IBOutlet UIImageView *myImg;

@end

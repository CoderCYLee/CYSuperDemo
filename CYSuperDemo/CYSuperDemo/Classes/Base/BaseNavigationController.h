//
//  BaseNavigationController.h
//  ExamApp
//
//  Created by cyrill on 2018/11/20.
//  Copyright © 2018 Fibrlink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationController : UINavigationController

/**
 Enable the drag to back interaction, Defalt is YES.
 */
@property (nonatomic, assign) BOOL canDragBack;

@end

NS_ASSUME_NONNULL_END

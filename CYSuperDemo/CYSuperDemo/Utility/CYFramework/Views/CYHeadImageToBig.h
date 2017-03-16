//
//  CYHeadImageToBig.h
//  头像放大
//
//  Created by 李春阳 on 15/6/29.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CYHeadImageToBig : NSObject
/**
 *	@brief	浏览头像
 *
 *	@param 	headImageView 	头像所在的imageView
 */
+ (void)showImage:(UIImageView *)headImageView;
+ (void)showImage:(UIImageView *)headImageView withImage:(UIImage *)image;

@end

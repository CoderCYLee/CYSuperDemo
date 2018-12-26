//
//  PDFThumbnailCell.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFThumbnailCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END

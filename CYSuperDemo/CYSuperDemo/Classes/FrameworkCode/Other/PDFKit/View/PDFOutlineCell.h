//
//  PDFOutlineCell.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PDFOutlineButtonBlock)(UIButton *button);

@interface PDFOutlineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOffset;
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPage;
@property (nonatomic, copy) PDFOutlineButtonBlock outlineBlock;

@end

NS_ASSUME_NONNULL_END

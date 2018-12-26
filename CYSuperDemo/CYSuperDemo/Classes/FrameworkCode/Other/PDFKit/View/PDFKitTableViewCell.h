//
//  PDFKitTableViewCell.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFDocument;

NS_ASSUME_NONNULL_BEGIN

@interface PDFKitTableViewCell : UITableViewCell

@property (nonatomic, copy) PDFDocument *document;

@end

NS_ASSUME_NONNULL_END

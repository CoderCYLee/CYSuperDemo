//
//  PDFThumbnailViewController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ViewController.h"
@class PDFThumbnailViewController;
@class PDFDocument;

NS_ASSUME_NONNULL_BEGIN

@protocol PDFThumbnailViewControllerDelegate <NSObject>


/**
 缩略图被点击
 
 @param controller 缩略图controller
 @param indexPath indexPath
 */
- (void)thumbnailViewController:(PDFThumbnailViewController *)controller didSelectAtIndex:(NSIndexPath *)indexPath;

@end

@interface PDFThumbnailViewController : ViewController

@property (nonatomic, strong) PDFDocument *document;
@property (nonatomic, weak) id<PDFThumbnailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

//
//  PDFOutlineViewController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ViewController.h"
@class PDFOutline;

NS_ASSUME_NONNULL_BEGIN

@class PDFOutlineViewController;

@protocol PDFOutlineViewControllerDelegate <NSObject>


/**
 did select outline delegate
 
 @param controller controller
 @param outline outline
 */
- (void)outlineViewController:(PDFOutlineViewController *)controller didSelectOutline:(PDFOutline *)outline API_AVAILABLE(ios(11.0));

@end

@interface PDFOutlineViewController : ViewController

@property (nonatomic, strong) PDFOutline *outlineRoot;
@property (nonatomic, weak) id<PDFOutlineViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

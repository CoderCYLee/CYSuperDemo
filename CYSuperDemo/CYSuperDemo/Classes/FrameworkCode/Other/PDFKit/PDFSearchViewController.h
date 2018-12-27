//
//  PDFSearchViewController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ViewController.h"

@class PDFDocument;
@class PDFSearchViewController;
@class PDFSelection;

NS_ASSUME_NONNULL_BEGIN

@protocol PDFSearchViewControllerDelegate <NSObject>

/**
 did select search result delegate
 
 @param controller controller
 @param selection selection
 */
- (void)searchViewController:(PDFSearchViewController *)controller didSelectSearchResult:(PDFSelection *)selection API_AVAILABLE(ios(11.0));

@end

@interface PDFSearchViewController : ViewController


@property (nonatomic, weak) id<PDFSearchViewControllerDelegate> delegate;

@property (nonatomic, strong) PDFDocument *document;

@end

NS_ASSUME_NONNULL_END

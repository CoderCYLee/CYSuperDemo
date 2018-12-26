//
//  PDFDetailViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/26.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFDetailViewController.h"
#import "NavigationController.h"
#import "PDFOutlineViewController.h"
#import "PDFThumbnailViewController.h"
#import <PDFKit/PDFKit.h>
#import <Masonry.h>

API_AVAILABLE(ios(11.0))
@interface PDFDetailViewController () <PDFThumbnailViewControllerDelegate, PDFOutlineViewControllerDelegate>

@property (nonatomic, strong) PDFView *pdfView;
@property (weak, nonatomic) IBOutlet UIView *zoomBaseView;
@property (nonatomic, strong) IBOutlet UIButton *btnZoomIn;
@property (nonatomic, strong) IBOutlet UIButton *btnZoomOut;
@property (nonatomic, assign)  BOOL hasDisplay;

@end

@implementation PDFDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zoomBaseView.layer.cornerRadius = 5;
    
    if (@available(iOS 11.0, *)) {
        
        [self.view insertSubview:self.pdfView atIndex:0];
        [self.pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        if (!self.document) {
            return;
        }
        
        NSDictionary *dic = self.document.documentAttributes;
        NSString *Title = dic[@"Title"];
        self.navigationItem.title = Title;
        
        self.pdfView.document = self.document;
        self.pdfView.autoScales = YES;
        self.pdfView.userInteractionEnabled = YES;
        /*
         kPDFDisplaySinglePage = 0, 单页显示，滚动只影响当前页
         kPDFDisplaySinglePageContinuous = 1, 显示全部页面，默认垂直排列
         kPDFDisplayTwoUp = 2,
         kPDFDisplayTwoUpContinuous = 3
         */
//        self.pdfView.displayMode = kPDFDisplaySinglePageContinuous;
//        self.pdfView.displayDirection = kPDFDisplayDirectionVertical;
        
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired = 1;
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
        doubleTapGesture.numberOfTapsRequired = 2;
        doubleTapGesture.numberOfTouchesRequired = 1;
        
        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
        
        [self.pdfView addGestureRecognizer:singleTapGesture];
        [self.pdfView addGestureRecognizer:doubleTapGesture];
        
        
        self.hasDisplay = YES;
        

        UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"liebiao"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];
        UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]  initWithImage:[UIImage imageNamed:@"sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
        [self.navigationItem setRightBarButtonItems:@[searchItem, menuItem]];
        
        
    } else {
        // Fallback on earlier versions
        return;
    }
    
}

#pragma mark - delegate

#pragma mark PDFOutlineViewControllerDelegate
- (void)outlineViewController:(PDFOutlineViewController *)controller didSelectOutline:(PDFOutline *)outline  API_AVAILABLE(ios(11.0)){
    NSLog(@"%s",__func__);
    PDFAction *action = outline.action;
    PDFActionGoTo *goToAction = (PDFActionGoTo *)action;
    
    if (goToAction) {
        [self.pdfView goToDestination:goToAction.destination];
    }
}

#pragma mark PDFThumbnailViewControllerDelegate
- (void)thumbnailViewController:(PDFThumbnailViewController *)controller didSelectAtIndex:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        PDFPage *page = [self.document pageAtIndex:indexPath.item];
        [self.pdfView goToPage:page];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - event response
- (void)menuAction {
    
    if (@available(iOS 11.0, *)) {
        PDFOutline *outline = self.document.outlineRoot;
        
        if (outline) {
            
            PDFOutlineViewController *vc = [[PDFOutlineViewController alloc] init];
            
            vc.outlineRoot = outline;
            vc.delegate = self;
            
            [self presentViewController:[[NavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        } else {
            
            PDFThumbnailViewController *vc = [[PDFThumbnailViewController alloc] init];
            vc.document = self.document;
            vc.delegate = self;
            [self showDetailViewController:[[NavigationController alloc] initWithRootViewController:vc] sender:self];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)searchAction {
    
}

- (void)singleTapAction
{
    NSLog(@"%s",__func__);
    
    if (self.hasDisplay)
    {
        self.zoomBaseView.hidden = NO;
        self.zoomBaseView.alpha = 1.0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.zoomBaseView.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.zoomBaseView.hidden = YES;
        }];
    }
    else
    {
        self.zoomBaseView.hidden = NO;
        self.zoomBaseView.alpha = 0.0;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.zoomBaseView.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.zoomBaseView.hidden = NO;
        }];
    }
    
    self.hasDisplay = !self.hasDisplay;
}

- (void)doubleTapAction
{
    NSLog(@"%s",__func__);
    

    if (@available(iOS 11.0, *)) {
        NSLog(@"%f",self.pdfView.scaleFactorForSizeToFit);
        
        if (self.pdfView.scaleFactor == self.pdfView.scaleFactorForSizeToFit)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit * 4;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.pdfView.scaleFactor = self.pdfView.scaleFactorForSizeToFit;
            }];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (IBAction)zoomInAction
{
    NSLog(@"%s",__func__);
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.pdfView zoomIn:nil];
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)zoomOutAction
{
    NSLog(@"%s",__func__);
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.pdfView zoomOut:nil];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - reuseable methods

#pragma mark - private methods

#pragma mark - getters and setters
- (PDFView *)pdfView
API_AVAILABLE(ios(11.0)){
    if (!_pdfView) {
        _pdfView = [[PDFView alloc] initWithFrame:self.view.bounds];
    }
    return _pdfView;
}

@end

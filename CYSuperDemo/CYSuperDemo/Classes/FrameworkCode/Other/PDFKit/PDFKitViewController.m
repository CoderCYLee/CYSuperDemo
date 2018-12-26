//
//  PDFKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/9.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PDFKitViewController.h"
#import <PDFKit/PDFKit.h>
#import <Masonry.h>

API_AVAILABLE(ios(11.0))
@interface PDFKitViewController ()

@property (nonatomic, strong) PDFView *pdfView;

@end

@implementation PDFKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        
        [self.view addSubview:self.pdfView];
        [self.pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pdf1.pdf" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
        if (!document) {
            return;
        }
        
        self.pdfView.document = document;
        self.pdfView.autoScales = YES;
        /*
         kPDFDisplaySinglePage = 0, 单页显示，滚动只影响当前页
         kPDFDisplaySinglePageContinuous = 1, 显示全部页面，默认垂直排列
         kPDFDisplayTwoUp = 2,
         kPDFDisplayTwoUpContinuous = 3
         */
        self.pdfView.displayMode = kPDFDisplaySinglePage;
        self.pdfView.backgroundColor = [UIColor lightGrayColor];
        
    } else {
        // Fallback on earlier versions
        return;
    }
    
    
    
}



- (PDFView *)pdfView
API_AVAILABLE(ios(11.0)){
    if (!_pdfView) {
        _pdfView = [[PDFView alloc] init];
    }
    return _pdfView;
}


@end

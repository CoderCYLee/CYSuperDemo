//
//  QuickLookViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/18.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "QuickLookViewController.h"
#import <QuickLook/QuickLook.h>

@interface QuickLookViewController () <QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) NSString *path;

@end

@implementation QuickLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.path = [[NSBundle mainBundle] pathForResource:@"doc1.docx" ofType:@""];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.delegate = self;
    previewController.dataSource = self;
    
    [self showViewController:previewController sender:self];
}

#pragma mark - datasource
/*!
 * @abstract Returns the number of items that the preview controller should preview.
 * @param controller The Preview Controller.
 * @result The number of items.
 */
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

/*!
 * @abstract Returns the item that the preview controller should preview.
 * @param controller The Preview Controller.
 * @param index The index of the item to preview.
 * @result An item conforming to the QLPreviewItem protocol.
 */
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    if ([self.path hasSuffix:@"txt"] || [self.path hasSuffix:@"TXT"]) {
        // 处理txt格式内容显示有乱码的情况
        NSData *fileData = [NSData dataWithContentsOfFile:self.path];
        // 判断是UNICODE编码
        NSString *isUNICODE = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        // 还是ANSI编码（-2147483623，-2147482591，-2147482062，-2147481296）encoding 任选一个就可以了
        NSString *isANSI = [[NSString alloc] initWithData:fileData encoding:-2147483623];
        if (isUNICODE) {
        } else {
            NSData *data = [isANSI dataUsingEncoding:NSUTF8StringEncoding];
            [data writeToFile:self.path atomically:YES];
        }
        return [NSURL fileURLWithPath:self.path];
    } else {
        NSURL *fileURL = nil;
        fileURL = [NSURL fileURLWithPath:self.path];
        return fileURL;
    }
    
}


#pragma mark - delegate

/*!
 * @abstract Invoked before the preview controller is closed.
 */
- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    
}

/*!
 * @abstract Invoked after the preview controller is closed.
 */
- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    
}

/*!
 * @abstract Invoked by the preview controller before trying to open an URL tapped in the preview.
 * @result Returns NO to prevent the preview controller from calling -[UIApplication openURL:] on url.
 * @discussion If not implemented, defaults is YES.
 */
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return YES;
}

/*!
 * @abstract Invoked when the preview controller is about to be presented full screen or dismissed from full screen, to provide a zoom effect.
 * @discussion Return the origin of the zoom. It should be relative to view, or screen based if view is not set. The controller will fade in/out if the rect is CGRectZero.
 */
//- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * _Nullable * __nonnull)view {
//
//}

/*!
 * @abstract Invoked when the preview controller is about to be presented full screen or dismissed from full screen, to provide a smooth transition when zooming.
 * @param contentRect The rect within the image that actually represents the content of the document. For example, for icons the actual rect is generally smaller than the icon itself.
 * @discussion Return an image the controller will crossfade with when zooming. You can specify the actual "document" content rect in the image in contentRect.
 */
//- (UIImage * _Nullable)previewController:(QLPreviewController *)controller transitionImageForPreviewItem:(id <QLPreviewItem>)item contentRect:(CGRect *)contentRect {
//
//}

/*!
 * @abstract Invoked when the preview controller is about to be presented full screen or dismissed from full screen, to provide a smooth transition when zooming.
 * @discussion  Return the view that will crossfade with the preview.
 */
//- (UIView* _Nullable)previewController:(QLPreviewController *)controller transitionViewForPreviewItem:(id <QLPreviewItem>)item NS_AVAILABLE_IOS(10_0) {
//
//}

@end

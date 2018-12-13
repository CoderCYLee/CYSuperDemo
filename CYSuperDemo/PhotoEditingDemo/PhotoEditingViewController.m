//
//  PhotoEditingViewController.m
//  PhotoEditingDemo
//
//  Created by cyrill on 2018/12/13.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface PhotoEditingViewController () <PHContentEditingController>
@property (strong) PHContentEditingInput *input;
@end

@implementation PhotoEditingViewController

- (IBAction)imageFilter:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            filterName = @"CISepiaTone";
            break;
            
        case 1:
            filterName = @"CIPhotoEffectInstant";
    }
    
    [self showImage];
}

-(void)showImage
{
    CIImage *inputImg = [CIImage imageWithCGImage:self.input.displaySizeImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setDefaults];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    
    CIImage *outputImg = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef =  [context createCGImage:outputImg fromRect:outputImg.extent];
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    self.myImg.image = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHContentEditingController

- (BOOL)canHandleAdjustmentData:(PHAdjustmentData *)adjustmentData {
    // Inspect the adjustmentData to determine whether your extension can work with past edits.
    // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
    BOOL result = [adjustmentData.formatIdentifier isEqualToString:@"ckk.photoeditor"];
    result &= [adjustmentData.formatVersion isEqualToString:@"1.0"];
    return result;
}

- (void)startContentEditingWithInput:(PHContentEditingInput *)contentEditingInput placeholderImage:(UIImage *)placeholderImage {
    // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
    // If you returned YES from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
    // If you returned NO, the contentEditingInput has past edits "baked in".
    PHAdjustmentData *adjustmentData = contentEditingInput.adjustmentData;
    filterName =  [NSKeyedUnarchiver unarchiveObjectWithData:adjustmentData.data];
    self.input = contentEditingInput;
    
    if (filterName) {
        [self showImage];
    } else {
        self.myImg.image = contentEditingInput.displaySizeImage;
    }
}

- (void)finishContentEditingWithCompletionHandler:(void (^)(PHContentEditingOutput *))completionHandler {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    // Render and provide output on a background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Create editing output from the editing input.
        PHContentEditingOutput *output = [[PHContentEditingOutput alloc] initWithContentEditingInput:self.input];
        
        // Provide new adjustments and render output to given location.
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:filterName];
        PHAdjustmentData *adjustmentData = [[PHAdjustmentData alloc] initWithFormatIdentifier:@"ckk.photoeditor" formatVersion:@"1.0" data:archivedData];
        output.adjustmentData = adjustmentData;
        
        NSData *renderedJPEGData = UIImageJPEGRepresentation(self.myImg.image, 0.9f);
        [renderedJPEGData writeToURL:output.renderedContentURL atomically:YES];
        
        // Call completion handler to commit edit to Photos.
        completionHandler(output);
        
        // Clean up temporary files, etc.
    });
}

- (BOOL)shouldShowCancelConfirmation {
    // Returns whether a confirmation to discard changes should be shown to the user on cancel.
    // (Typically, you should return YES if there are any unsaved changes.)
    return NO;
}

- (void)cancelContentEditing {
    // Clean up temporary files, etc.
    // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
}

@end

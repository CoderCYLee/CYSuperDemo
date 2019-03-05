//
//  ActionViewController.m
//  ActionDemo
//
//  Created by cyrill on 2018/11/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
//            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
//                // This is an image. We'll load it, then place it in our image view.
//                __weak UIImageView *imageView = self.imageView;
//                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
//                    if(image) {
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            [imageView setImage:image];
//                        }];
//                    }
//                }];
//                imageFound = YES;
//                
//                break;
//            }
            
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeText]) {
                
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSString *text, NSError * _Null_unspecified error) {
                    
                    if(!error) {
                        
                        self.textField.text = text;
                        self.label.text = [text uppercaseString];
                    }
                }];
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    
    
    NSExtensionItem *outputItem = [NSExtensionItem new];
    NSItemProvider *item = [[NSItemProvider alloc] initWithItem:self.label.text typeIdentifier:(NSString *)kUTTypeText];
    outputItem.attachments = @[item];
    NSArray *outputItems = @[outputItem];
    
    
    [self.extensionContext completeRequestReturningItems:outputItems completionHandler:nil];
}

@end

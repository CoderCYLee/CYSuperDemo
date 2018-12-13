//
//  ShareViewController.m
//  ShareDemo
//
//  Created by cyrill on 2018/12/12.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    // 自定义方式校验内容 validateContent
    NSInteger messageLength = [self.contentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
    NSInteger charactersRemaining = 100 - messageLength;
    self.charactersRemaining = @(charactersRemaining);
    
    if (charactersRemaining >= 0) {
        return YES;
    }
    
    return NO;
}

- (void)didSelectCancel {
    NSLog(@"点击了取消");
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    NSExtensionItem *inputItem = self.extensionContext.inputItems.firstObject;
    NSExtensionItem *outputItem = [inputItem copy];
    outputItem.attributedContentText = [[NSAttributedString alloc] initWithString:self.contentText attributes:nil];
    NSLog(@"%@", self.contentText);
    
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[outputItem] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end

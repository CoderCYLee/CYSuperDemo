//
//  CloudDocumentAddNewViewController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/22.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Document_type)
{
    Document_type_addNew = 0,
    Document_type_edit,
};

@interface CloudDocumentAddNewViewController : UIViewController
@property (nonatomic ,copy) NSString                *fileName;
@property (nonatomic ,assign) Document_type          type;
@end

NS_ASSUME_NONNULL_END

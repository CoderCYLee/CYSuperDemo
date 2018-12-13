//
//  CloudCloudKitAddNewViewController.h
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/22.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "ViewController.h"
#import <CloudKit/CloudKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CloudKit_type)
{
    CloudKit_type_AddNew = 0,
    CloudKit_type_edit,
};

@interface CloudCloudKitAddNewViewController : ViewController

@property (nonatomic ,assign) CloudKit_type         type;
@property (nonatomic ,strong) CKRecordID            *recordID;

@end

NS_ASSUME_NONNULL_END

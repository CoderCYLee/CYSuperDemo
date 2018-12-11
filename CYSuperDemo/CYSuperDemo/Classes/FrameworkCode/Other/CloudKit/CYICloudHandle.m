//
//  CYICloudHandle.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/22.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CYICloudHandle.h"
#import "CYDocument.h"

#define UbiquityContainerIdentifiers @"iCloud.developer.cy.superdemo"
#define RECORD_TYPE_NAME @"Note"

@implementation CYICloudHandle

- (BOOL)isOpenedICloud {
    NSFileManager *fm = [NSFileManager defaultManager];
    id token = [fm ubiquityIdentityToken];
    return token!=nil;
}

#pragma mark - key-value storage
+ (void)setUpKeyValueICloudStoreWithKey:(NSString *)key value:(id)value {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    [keyValueStore setObject:value forKey:key];
    [keyValueStore synchronize];
}

+ (id)getKeyValueICloudStoreWithKey:(NSString *)key {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    return [keyValueStore objectForKey:key];
}

+ (void)removeKeyValueICloudStoreWithKey:(NSString *)key {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    if ([keyValueStore objectForKey:key]) {
        [keyValueStore removeObjectForKey:key];
        [keyValueStore synchronize];
    }
}

#pragma mark - iCloud Document

+ (NSURL *)getUbiquityContauneURLWithFileName:(NSString *)fileName {
    NSURL *ubiquityURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:UbiquityContainerIdentifiers];
    
    if (!ubiquityURL) {
        NSLog(@"尚未开启iCloud功能");
        return nil;
    }
    
    NSURL *URLWithFileName = [ubiquityURL URLByAppendingPathComponent:@"Documents"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:URLWithFileName.path]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtURL:URLWithFileName withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSURL *fileURL = [URLWithFileName URLByAppendingPathComponent:fileName];
    
    return fileURL;
}

/// 创建文档
+ (void)createDocumentWithFileName:(NSString *)fileName content:(NSString *)content completionHandler:(void (^ __nullable)(BOOL success))completionHandler {
    NSURL *url = [self getUbiquityContauneURLWithFileName:fileName];
    CYDocument *doc = [[CYDocument alloc] initWithFileURL:url];
    
    NSString *docContent = content;
    doc.myData = [docContent dataUsingEncoding:NSUTF8StringEncoding];
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:completionHandler];
    
}

/// 修改文档
+ (void)overwriteDocumentWithFileName:(NSString *)fileName content:(NSString *)content completionHandler:(void (^ __nullable)(BOOL success))completionHandler {
    NSURL *url = [self getUbiquityContauneURLWithFileName:fileName];
    CYDocument *doc = [[CYDocument alloc] initWithFileURL:url];
    
    doc.myData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForOverwriting completionHandler:completionHandler];
}


/// 删除文档
+ (void)removeDocumentWithFileName:(NSString *)fileName {
    NSURL *url = [self getUbiquityContauneURLWithFileName:fileName];
    NSError *error = nil;
    
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    
    if (error) {
        NSLog(@"删除文档失败 %@", error);
    } else {
        // 删除文档成功
    }
}

/// 获取最新的数据
+ (void)getNewDocument:(NSMetadataQuery *)myMetaDataQuery {
    [myMetaDataQuery setSearchScopes:@[NSMetadataQueryUbiquitousDocumentsScope]];
    [myMetaDataQuery startQuery];
}


#pragma mark - Cloud Kit

+ (void)saveCloudKitModelWithTitle:(NSString *)title content:(NSString *)content photoImage:(UIImage *)image
{
    CKContainer *container = [CKContainer defaultContainer];
    
    //公共数据
    CKDatabase *datebase = container.publicCloudDatabase;
    //    //私有数据
    //    CKDatabase *datebase = container.privateCloudDatabase;
    
    //创建主键
    //    CKRecordID *noteID = [[CKRecordID alloc] initWithRecordName:@"NoteID"];
    
    //创建保存数据
    CKRecord *noteRecord = [[CKRecord alloc] initWithRecordType:RECORD_TYPE_NAME];
    
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (imageData == nil)
    {
        imageData = UIImageJPEGRepresentation(image, 0.6);
    }
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:tempPath]) {
        
        [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate *dateID = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [dateID timeIntervalSince1970] * 1000;      //*1000表示到毫秒级，这样可以保证不会同时生成两个同样的id
    NSString *idString = [NSString stringWithFormat:@"%.0f", timeInterval];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,idString];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [imageData writeToURL:url atomically:YES];
    
    CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
    
    [noteRecord setValue:title forKey:@"title"];
    [noteRecord setValue:content forKey:@"content"];
    [noteRecord setValue:asset forKey:@"image"];
    
    
    [datebase saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        if(!error)
        {
            NSLog(@"保存成功");
        }
        else
        {
            NSLog(@"保存失败");
            NSLog(@"%@",error.description);
        }
    }];
}




//查询数据
+ (void)queryCloudKitData
{
    //获取位置
    CKContainer *container = [CKContainer defaultContainer];
    CKDatabase *database = container.publicCloudDatabase;
    
    //添加查询条件
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:RECORD_TYPE_NAME predicate:predicate];
    
    //开始查询
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        
        NSLog(@"%@",results);
        //把数据做成字典通知出去
        NSDictionary *userinfoDic = [NSDictionary dictionaryWithObject:results forKey:@"key"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CloudDataQueryFinished" object:nil userInfo:userinfoDic];
    }];
    
}


//删除数据
+ (void)removeCloudKitDataWithRecordID:(CKRecordID *)recordID
{
    CKContainer *container = [CKContainer defaultContainer];
    CKDatabase *database = container.publicCloudDatabase;
    
    [database deleteRecordWithID:recordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        NSLog(@"删除成功");
    }];
    
}

//查询单条数据
+ (void)querySingleRecordWithRecordID:(CKRecordID *)recordID
{
    //获取容器
    CKContainer *container = [CKContainer defaultContainer];
    //获取公有数据库
    CKDatabase *database = container.publicCloudDatabase;
    
    [database fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",record);
            //把数据做成字典通知出去
            NSDictionary *userinfoDic = [NSDictionary dictionaryWithObject:record forKey:@"key"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CloudDataSingleQueryFinished" object:nil userInfo:userinfoDic];
        });
    }];
}

//修改数据
+ (void)changeCloudKitWithTitle:(NSString *)title content:(NSString *)content photoImage:(UIImage *)image RecordID:(CKRecordID *)recordID
{
    //获取容器
    CKContainer *container = [CKContainer defaultContainer];
    //获取公有数据库
    CKDatabase *database = container.publicCloudDatabase;
    
    [database fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData == nil)
        {
            imageData = UIImageJPEGRepresentation(image, 0.6);
        }
        NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:tempPath]) {
            
            [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSDate *dateID = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timeInterval = [dateID timeIntervalSince1970] * 1000;      //*1000表示到毫秒级，这样可以保证不会同时生成两个同样的id
        NSString *idString = [NSString stringWithFormat:@"%.0f", timeInterval];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,idString];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [imageData writeToURL:url atomically:YES];
        CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
        [record setObject:title forKey:@"title"];
        [record setObject:content forKey:@"content"];
        [record setValue:asset forKey:@"photo"];
        [database saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
            
            if(error)
            {
                
                NSLog(@"修改失败 %@",error.description);
            }
            else
            {
                NSLog(@"修改成功");
            }
        }];
    }];
}











@end

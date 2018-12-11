//
//  CYDocument.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/21.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CYDocument.h"

@implementation CYDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    self.myData = [contents copy];
    
    return YES;
}

- (nullable id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    if (!self.myData) {
        self.myData = [[NSData alloc] init];
        
    }
    
    return self.myData;
}

@end

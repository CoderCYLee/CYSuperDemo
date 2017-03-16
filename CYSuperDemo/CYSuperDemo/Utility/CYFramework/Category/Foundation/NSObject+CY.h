//
//  NSObject+CY.h
//  JustJokes
//
//  Created by 李春阳 on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/*
 定义一个需要指定时间后执行的block块
 */
typedef void(^BlockPerform)(id param);

/**
 申明一个 block_self 的指针，指向自身，以用于在block中使用
 */
#define IMP_BLOCK_SELF(type) __block type *block_self=self;

@interface NSObject (CY)

/** 是否是64位 */
- (BOOL)is64Bit;
/** 是否是32位 */
- (BOOL)is32Bit;


- (void)afterBlock:(dispatch_block_t)block after:(float)time;

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

- (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion;

- (id)getAssociatedObjectForKey:(const char *)key;
- (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy;
- (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy;
- (void)removeAllAssociatedObjects;


+ (id)getAssociatedObjectForKey:(const char *)key;
+ (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy;
+ (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy;
+ (void)removeAllAssociatedObjects;


/** 取得并保存cookie */
- (void)getAndSaveCookie;

/** 再取出保存的cookie重新设置cookie */
- (void)setCoookie;

/** 删除cookie */
- (void)deleteCookie;


/**
 获取MainBundle下的文件夹路径

 @param folderName 文件名
 
 @return 路径
 */
- (NSString *)getBundleFolderPathWithFolderName:(NSString *)folderName;

/** 自定义文件路径 */
- (NSString *)getFilePathFromFolderPath:(NSString *)folderPathStr withFileName:(NSString *)fileNameStr;

/** 获取Document下文件路径 */
- (NSString *)getFilePathWithFileName:(NSString *)fileNameStr;

/** Document下创建文件夹 */
- (NSString *)createFolderWithFolderName:(NSString *)folderNameStr;

/** 文件夹下创建文件夹 */
- (NSString *)createFolderWithFolderPath:(NSString *)folderPath folderName:(NSString *)folderName;

/** 存文件 */
- (BOOL)saveFileWithData:(NSData *)data filePath:(NSString *)filePath;
- (BOOL)saveFileFromNetWorkWithData:(NSData *)data filePath:(NSString *)filePath;
/** 取文件 */
- (NSData *)getSavedFileFromNetworkWithFilePath:(NSString *)filePath;

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (NSString *)distanceTimeWithBeforeTime:(double)beTime;

/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end

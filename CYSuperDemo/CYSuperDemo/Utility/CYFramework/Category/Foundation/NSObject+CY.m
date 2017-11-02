//
//  NSObject+CY.m
//  JustJokes
//
//  Created by cy on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import "NSObject+CY.h"

@implementation NSObject (CY)

- (BOOL)is64Bit
{
#if defined(__LP64__) && __LP64__
    return YES;
#else
    return NO;
#endif
}

- (BOOL)is32Bit
{
#if defined(__LP64__) && __LP64__
    return NO;
#else
    return YES;
#endif
}


-(void)afterBlock:(dispatch_block_t)block after:(float)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

- (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion{
    
    [UIView animateWithDuration:delay
                     animations: ^{
                         
                     }completion:^(BOOL finished) {
                         
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

#pragma mark -
#pragma mark - associated
- (id)getAssociatedObjectForKey:(const char *)key
{
    id currValue = objc_getAssociatedObject( self, key);
    return currValue;
}

- (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    id oldValue = objc_getAssociatedObject( self, key );
    objc_setAssociatedObject( self, key, obj, policy );
    return oldValue;
}

- (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject( self, key, nil, policy );
}

- (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects( self );
}

+ (id)getAssociatedObjectForKey:(const char *)key
{
    id currValue = objc_getAssociatedObject( self, key);
    return currValue;
}

+ (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    id oldValue = objc_getAssociatedObject( self, key );
    objc_setAssociatedObject( self, key, obj, policy );
    return oldValue;
}

+ (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject( self, key, nil, policy );
}

+ (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects( self );
}

#pragma mark -------------------
- (BOOL)saveFileWithData:(NSData *)data filePath:(NSString *)filePath
{
    //==写入文件
    //    kDebugLog(@"data{\nclass:%@;\
    :%@\n}", [data class], data);
    
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isSaved = [manager createFileAtPath:filePath contents:data attributes:nil];
    
    //    BOOL isSaved = [data writeToFile:filePath atomically:YES];
    NSLog(@"%@", isSaved ? @"Succeed":@"Failed");
    
    return isSaved;
}

- (BOOL)saveFileFromNetWorkWithData:(NSData *)data filePath:(NSString *)filePath
{
    //==写入文件
//    kDebugLog(@"data{\nclass:%@;\
    :%@\n}", [data class], data);
    
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isSaved = [manager createFileAtPath:filePath contents:data attributes:nil];
    
//    BOOL isSaved = [data writeToFile:filePath atomically:YES];
    NSLog(@"%@", isSaved ? @"Succeed":@"Failed");
    
    return isSaved;
}

- (NSData *)getSavedFileFromNetworkWithFilePath:(NSString *)filePath
{
    //==读取文件二进制
    NSData *data=[NSData dataWithContentsOfFile:filePath];
    return data;
}

- (NSString *)getBundleFolderPathWithFolderName:(NSString *)folderName
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *bundleFolderPath = [bundlePath stringByAppendingPathComponent:folderName];
    return bundleFolderPath;
}

- (NSString *)createFolderWithFolderName:(NSString *)folderNameStr
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *folderPath = [path stringByAppendingPathComponent:folderNameStr];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isCreated = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
    NSLog(@"%@", isCreated ? @"创建成功":@"创建失败");
    return folderPath;
}

- (NSString *)createFolderWithFolderPath:(NSString *)folderPath folderName:(NSString *)folderName
{
    NSString *newFolderPath = [folderPath stringByAppendingPathComponent:folderName];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isCreated = [fileManager createDirectoryAtPath:newFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
    NSLog(@"%@", isCreated ? @"创建成功":@"创建失败");
    return newFolderPath;
}

- (NSString *)getFilePathWithFileName:(NSString *)fileNameStr
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filePath=[path stringByAppendingPathComponent:fileNameStr];
    return filePath;
}

- (NSString *)getFilePathFromFolderPath:(NSString *)folderPathStr withFileName:(NSString *)fileNameStr
{
    NSString *filePath=[folderPathStr stringByAppendingPathComponent:fileNameStr];
    return filePath;
}

- (void)getUserInfoWithAccess_token:(NSString *)access_token openid:(NSString *)openid
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token, openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
//                self.nickname.text = [dic objectForKey:@"nickname"];
//                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                
            }
        });
        
    });
}

#pragma mark 取得并保存cookie
- (void)getAndSaveCookie
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        //打印获得的cookie
        NSLog(@"getCookie: %@", tempCookie);
    }
    /*
     * 把cookie进行归档并转换为NSData类型
     * 注意：cookie不能直接转换为NSData类型，否则会引起崩溃。
     * 所以先进行归档处理，再转换为Data
     */
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    
    //存储归档后的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: cookiesData forKey: @"cookie"];
    NSLog(@"\n");
}

#pragma mark 再取出保存的cookie重新设置cookie
- (void)setCoookie
{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    
    if (cookies) {
        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        NSLog(@"setCookie: %@", cookie);
    }
    NSLog(@"\n");
}

#pragma mark 删除cookie
- (void)deleteCookie
{
    NSLog(@"============删除cookie===============");
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    
    //把cookie打印出来，检测是否已经删除
    NSArray *cookiesAfterDelete = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookiesAfterDelete) {
        NSLog(@"cookieAfterDelete: %@", tempCookie);
    }
    NSLog(@"\n");
}


- (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end

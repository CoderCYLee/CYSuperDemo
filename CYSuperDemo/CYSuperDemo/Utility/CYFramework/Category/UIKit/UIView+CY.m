//
//  UIView+CY.m
//  JustJokes
//
//  Created by 李春阳 on 15/9/12.
//  Copyright (c) 2015年 Cyrill. All rights reserved.
//

#import "UIView+CY.h"

@implementation UIView (CY)

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.y = right - frame.size.width;
    self.frame = frame;
}


-(CGFloat)height
{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    [self setHeight:height Animated:NO];
}
-(void)setHeight:(CGFloat)height Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size.height=height;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
}
-(void)addHeight:(CGFloat)height
{
    [self setHeight:[self height]+height ];
}


-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    [self setWidth:width Animated:NO];
}
-(void)setWidth:(CGFloat)width Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size.width=width;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addWidth:(CGFloat)width
{
    [self setWidth:[self width]+width Animated:NO];
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(void)setOriginX:(CGFloat)x
{
    [self setOriginX:x Animated:NO];
}
-(void)setOriginX:(CGFloat)x Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addOriginX:(CGFloat)x
{
    [self setOriginX:[self originX]+x];
}

-(CGFloat)originY
{
    return self.frame.origin.y;
}
-(void)setOriginY:(CGFloat)y
{
    [self setOriginY:y Animated:NO];
}
-(void)setOriginY:(CGFloat)y Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addOriginY:(CGFloat)y
{
    [self setOriginY:[self originY]+y];
}

-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)size
{
    [self setSize:size Animated:NO];
}
-(void)setSize:(CGSize)size Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size=size;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
}

-(CGPoint)origin
{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)point
{
    [self setOrigin:point Animated:NO];
}
-(void)setOrigin:(CGPoint)point Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin=point;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}


-(CGPoint)originTopRight
{
    return CGPointMake(self.origin.x+self.width, self.origin.y);
}

-(CGPoint)originBottomLeft
{
    return CGPointMake(self.originX, self.originY+self.height);
}

-(CGPoint)originBottomRight
{
    return CGPointMake(self.originX+self.width, self.originY+self.height);
}
-(CGRect)rectForAddViewTop:(CGFloat)height//返回在该view上面添加一个视图时的frame
{
    CGRect frame=self.frame;
    frame.size.height=height;
    frame.origin.y=frame.origin.y-height;
    
    return frame;
}
-(CGRect)rectForAddViewBottom:(CGFloat)height//返回在该view下面添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.origin.y=frame.origin.y+frame.size.height;
    frame.size.height=height;
    return frame;
}
-(CGRect)rectForAddViewLeft:(CGFloat)width//返回在该view左边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x-width;
    return frame;
}
-(CGRect)rectForAddViewRight:(CGFloat)width//返回在该view右边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x+width;
    return frame;
}

-(CGRect)rectForAddViewTop:(CGFloat)height Offset:(CGFloat)offset//返回在该view上面添加一个视图时的frame
{
    CGRect frame=self.frame;
    frame.size.height=height;
    frame.origin.y=frame.origin.y-height-offset;
    return frame;
    
}
-(CGRect)rectForAddViewBottom:(CGFloat)height Offset:(CGFloat)offset//返回在该view下面添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.origin.y=frame.origin.y+frame.size.height+offset;
    frame.size.height=height;
    return frame;
    
}
-(CGRect)rectForAddViewLeft:(CGFloat)width Offset:(CGFloat)offset//返回在该view左边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x-width-offset;
    return frame;
    
}
-(CGRect)rectForAddViewRight:(CGFloat)width Offset:(CGFloat)offset//返回在该view右边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x+width+offset;
    return frame;
}

-(CGRect)rectForCenterofSize:(CGSize)size
{
    CGRect rect;
    rect.size.width=size.width;
    rect.size.height=size.height;
    rect.origin.x=(self.width-size.width)/2.0;
    rect.origin.y=(self.height-size.height)/2.0;
    return rect;
}

-(NSArray*)subviewsWithClass:(Class )cls
{
    NSArray *array=[self subviews];
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([evaluatedObject isKindOfClass:cls]) {
            return YES;
        }
        return NO;
    }]];
}

-(id)viewWithTag2:(int)tag
{
    return [self viewWithTag:tag];
}

- (UIView *)findFirstResponder;
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

- (UIViewController *)fetchViewController
{
    UIViewController *viewController = nil;
    
    for (UIView *currentSuperview = [self superview]; (currentSuperview != nil); (currentSuperview = currentSuperview.superview)) {
        UIResponder *nextResponder = [currentSuperview nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)nextResponder;
            
            break;
        }
    }
    
    return viewController;
}

/**
 取消子视图中UIAsyncImageView与UIAsyncImageButton的图片下载请求
 此方法不会遍历子视图的视图，只会进行一次遍历
 */
-(void)cancelSubviewImageDownload
{
    //    for (UIView *s_view in self.subviews) {
    //        if ([s_view isKindOfClass:[UIButton class]]) {
    //            [(UIButton*)s_view cancelCurrentImageLoad];
    //        }else if ([s_view isKindOfClass:[UIImageView class]]){
    //            [(UIImageView*)s_view cancelCurrentImageLoad];
    //        }
    //    }
}

/**
 取消所有子视图的异步图片下载
 */
+(void)cancelSubviewImageDownloadinView:(UIView*)view
{
    for (UIView *s_view in view.subviews) {
        [s_view cancelSubviewImageDownload];
        [UIView cancelSubviewImageDownloadinView:s_view];
    }
}

-(id)initWithFrame:(CGRect)frame nibNameOrNil:(NSString *)nibNameOrNil
{
    self=[self initWithFrame:frame];
    if (self) {
        if (nibNameOrNil==nil||[nibNameOrNil isEqualToString:@""]) {
            nibNameOrNil=NSStringFromClass([self class]);
        }
        UIView *view=[[UINib nibWithNibName:nibNameOrNil bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil][0];
        view.frame=self.bounds;
        [self addSubview:view];
    }
    return self;
}

+(id)loadFromXibWithNibName:(NSString *)nibNameOrNil Frame:(CGRect)frame
{
    if (nibNameOrNil==nil||[nibNameOrNil isEqualToString:@""]) {
        nibNameOrNil=NSStringFromClass([self class]);
    }
    UIView *view=[[UINib nibWithNibName:nibNameOrNil bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil][0];
    view.frame = frame;
    return view;
}

+(id)loadFromXib
{
    NSString *className = NSStringFromClass([self class]);//_S(@"%s",object_getClassName([self class]));
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
    return [xibArray objectAtIndex:0];
}

+(id)loadFromXibWithNibName:(NSString *)nibNameOrNil
{
    if (nibNameOrNil==nil||[nibNameOrNil isEqualToString:@""]) {
        nibNameOrNil=NSStringFromClass([self class]);
    }
    UIView *view=[[UINib nibWithNibName:nibNameOrNil bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil][0];
    return view;
}

- (BOOL)isExclusiveTouch
{
    return YES;
}

- (UIImage *)snapshotImage {
    UIImage *image = nil;
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return image;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}



- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}


- (nonnull id)viewControllerWithNeedViewOrViewController:(nullable Class)viewControllerCls
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = self;
    id nextResponse = [frontView nextResponder];
    Class cls = viewControllerCls?viewControllerCls:UIViewController.class;
    while (nextResponse) {
        if ([nextResponse isKindOfClass:cls]) {
            result = nextResponse;
            break;
        }
        nextResponse = [nextResponse nextResponder];
    }
    if(!result) result = window.rootViewController;
    
    return result;
}

- (void)clearScrollViewDelegate {
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).delegate = nil;
        if ([self isKindOfClass:[UITableView class]]) {
            ((UITableView *)self).delegate = nil;
        }
    }
    for (UIView *sub in self.subviews) {
        [sub clearScrollViewDelegate];
    }
}

- (void)removeAllGestures {
    NSArray *gs = [self.gestureRecognizers copy];
    for (UIGestureRecognizer *g in gs) {
        [self removeGestureRecognizer:g];
    }
}
- (void)removeAllGesturesWithSubViews {
    [self removeAllGestures];
    for (UIView *v in self.subviews) {
        [v removeAllGesturesWithSubViews];
    }
    [UIView animateWithDuration:0 animations:^{
        
    }];
}



@end

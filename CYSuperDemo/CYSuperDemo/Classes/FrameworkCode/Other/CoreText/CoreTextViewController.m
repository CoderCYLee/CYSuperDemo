//
//  CoreTextViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CoreTextViewController.h"
#import <CoreText/CoreText.h>
#import "CTDemoView1.h"
#import "CTDemoView2.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import <Masonry.h>

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1、图文混排
     CTFrameRef  textFrame     // coreText 的 frame
     CTLineRef   line          // coreText 的 line
     CTRunRef    run           // line  中的部分文字
     
     2、相关方法：
     CFArrayRef CTFrameGetLines(CTFrameRef frame) //获取包含CTLineRef的数组
     void CTFrameGetLineOrigins(CTFrameRef frame,CFRange range,CGPoint origins[])//获取所有CTLineRef的原点
     CFRange CTLineGetStringRange(CTLineRef line) //获取line中文字在整段文字中的Range
     CFArrayRef CTLineGetGlyphRuns(CTLineRef line)//获取line中包含所有run的数组
     CFRange CTRunGetStringRange(CTRunRef run)//获取run在整段文字中的Range
     CFIndex CTLineGetStringIndexForPosition(CTLineRef line,CGPoint position)//获取点击处position文字在整段文字中的index
     CGFloat CTLineGetOffsetForStringIndex(CTLineRef line,CFIndex charIndex,CGFloat* secondaryOffset)//获取整段文字中charIndex位置的字符相对line的原点的x值
     */
    
    
//    CTDemoView1 *v1 = [[CTDemoView1 alloc] initWithFrame:CGRectZero];
//    v1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:v1];
//    
//    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@10);
//        make.top.equalTo(@100);
//        make.width.equalTo(@300);
//        make.height.equalTo(@200);
//    }];
    
    
    //创建画布
    CTDemoView2 *dispaleView = [[CTDemoView2 alloc] initWithFrame:self.view.bounds];
    dispaleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dispaleView];
    
    //设置配置信息
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = dispaleView.width;
    
    
    //获取模板文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsonTemplate" ofType:@"json"];
    
    //创建绘制数据实例
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    dispaleView.data = data;
    dispaleView.height = data.height;
    dispaleView.backgroundColor = [UIColor lightGrayColor];
    
}



@end

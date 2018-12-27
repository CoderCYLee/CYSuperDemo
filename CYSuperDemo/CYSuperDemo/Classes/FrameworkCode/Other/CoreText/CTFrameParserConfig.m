
//
//  CTFrameParserConfig.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/27.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        _width = 200.f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor lightTextColor];
    }
    return self;
}

@end

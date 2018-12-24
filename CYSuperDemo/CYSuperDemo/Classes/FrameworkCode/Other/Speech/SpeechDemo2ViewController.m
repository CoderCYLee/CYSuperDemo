//
//  SpeechDemo2ViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SpeechDemo2ViewController.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface SpeechDemo2ViewController () <SFSpeechRecognizerDelegate>

@property (nonatomic, strong) AVAudioEngine *audioEngine;                           // 声音处理器
@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;                 // 语音识别器
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *speechRequest; // 语音请求对象
@property (nonatomic, strong) SFSpeechRecognitionTask *currentSpeechTask;           // 当前语音识别进程
@property (nonatomic, strong) UILabel *showLb;       // 用于展现的label
@property (nonatomic, strong) UIButton *startBtn;    // 启动按钮

@end

@implementation SpeechDemo2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化
    self.audioEngine = [AVAudioEngine new];
    // 这里需要先设置一个AVAudioEngine和一个语音识别的请求对象SFSpeechAudioBufferRecognitionRequest
    self.speechRecognizer = [SFSpeechRecognizer new];
    self.startBtn.enabled = NO;
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status)
     {
         if (status != SFSpeechRecognizerAuthorizationStatusAuthorized)
         {
             // 如果状态不是已授权则return
             return;
         }
         
         // 初始化语音处理器的输入模式
         [self.audioEngine.inputNode installTapOnBus:0 bufferSize:1024 format:[self.audioEngine.inputNode outputFormatForBus:0] block:^(AVAudioPCMBuffer * _Nonnull buffer,AVAudioTime * _Nonnull when)
          {
              // 为语音识别请求对象添加一个AudioPCMBuffer，来获取声音数据
              [self.speechRequest appendAudioPCMBuffer:buffer];
          }];
         // 语音处理器准备就绪（会为一些audioEngine启动时所必须的资源开辟内存）
         [self.audioEngine prepare];
         
         NSOperationQueue *queue = [NSOperationQueue mainQueue];
         [queue addOperationWithBlock:^{
             self.startBtn.enabled = YES;
         }];
     }];
    
}
- (void)onStartBtnClicked
{
    if (self.currentSpeechTask.state == SFSpeechRecognitionTaskStateRunning)
    {   // 如果当前进程状态是进行中
        
        [self.startBtn setTitle:@"开始录制" forState:UIControlStateNormal];
        // 停止语音识别
        [self stopDictating];
    }
    else
    {   // 进程状态不在进行中
        [self.startBtn setTitle:@"停止录制" forState:UIControlStateNormal];
        self.showLb.text = @"等待";
        // 开启语音识别
        [self startDictating];
    }
}


/*
 所有的私有权限
 Privacy - Media Library Usage Description 使用媒体资源库
 Privacy - Calendars Usage Description 使用日历
 Privacy - Motion Usage Description 使用蓝牙
 Privacy - Camera Usage Description 使用相机
 Privacy - Health Update Usage Description 使用健康更新
 Privacy - Microphone Usage Description 使用麦克风
 Privacy - Bluetooth Peripheral Usage Description 使用蓝牙
 Privacy - Health Share Usage Description 使用健康分享
 Privacy - Reminders Usage Description 使用提醒事项
 Privacy - Location Usage Description 使用位置
 Privacy - Location Always Usage Description 始终访问位置
 Privacy - Photo Library Usage Description 访问相册
 Privacy - Speech Recognition Usage Description 使用语音识别
 Privacy - Location When In Use Usage Description 使用期间访问位置
 */
- (void)startDictating
{
    NSError *error;
    // 启动声音处理器
    [self.audioEngine startAndReturnError: &error];
    // 初始化
    self.speechRequest = [SFSpeechAudioBufferRecognitionRequest new];
    // 使用speechRequest请求进行识别
    self.currentSpeechTask =
    [self.speechRecognizer recognitionTaskWithRequest:self.speechRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result,NSError * _Nullable error)
     {
         // 识别结果，识别后的操作
         if (result == NULL) return;
         self.showLb.text = result.bestTranscription.formattedString;
     }];
}

- (void)stopDictating
{
    // 停止声音处理器，停止语音识别请求进程
    [self.audioEngine stop];
    [self.speechRequest endAudio];
}





#pragma mark- getter

- (UILabel *)showLb {
    if (!_showLb) {
        _showLb = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, self.view.bounds.size.width - 100, 100)];
        _showLb.numberOfLines = 0;
        _showLb.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _showLb.text = @"等待中...";
        _showLb.adjustsFontForContentSizeCategory = YES;
        _showLb.textColor = [UIColor orangeColor];
        [self.view addSubview:_showLb];
    }
    return _showLb;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame = CGRectMake(50, 80, 80, 80);
        [_startBtn addTarget:self action:@selector(onStartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setBackgroundColor:[UIColor redColor]];
        [_startBtn setTitle:@"录音" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_startBtn];
        
    }
    return _startBtn;
}

@end

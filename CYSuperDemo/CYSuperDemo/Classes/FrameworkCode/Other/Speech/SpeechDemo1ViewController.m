//
//  SpeechDemo1ViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SpeechDemo1ViewController.h"
#import <Speech/Speech.h>

@interface SpeechDemo1ViewController () <SFSpeechRecognitionTaskDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) SFSpeechRecognitionTask *recognitionTask;
@property (nonatomic ,strong) SFSpeechRecognizer *speechRecognizer;

@end

@implementation SpeechDemo1ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //0.0获取权限
    //    //0.1在info.plist里面配置
    //    /*
    //     typedef NS_ENUM(NSInteger, SFSpeechRecognizerAuthorizationStatus) {
    //     SFSpeechRecognizerAuthorizationStatusNotDetermined,
    //     SFSpeechRecognizerAuthorizationStatusDenied,
    //     SFSpeechRecognizerAuthorizationStatusRestricted,
    //     SFSpeechRecognizerAuthorizationStatusAuthorized,
    //     };
    //     */
    
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"NotDetermined");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"Denied");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                break;
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                break;
            default:
                break;
        }
    }];
    
    //1.创建SFSpeechRecognizer识别实例
    self.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];//中文识别
    //@"zh"在iOS9之后就不是简体中文了，而是TW繁体中文

    [SFSpeechRecognizer supportedLocales];//根据手机设置的语言识别
    for (NSLocale *lacal in [SFSpeechRecognizer supportedLocales].allObjects) {
        NSLog(@"countryCode:%@  languageCode:%@ ", lacal.countryCode, lacal.languageCode);
    }

}

- (SFSpeechRecognitionTask *)recognitionTaskWithRequest0:(SFSpeechURLRecognitionRequest *)request{

    return [self.speechRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"语音识别解析正确--%@", result.bestTranscription.formattedString);
        } else {
            NSLog(@"语音识别解析失败--%@", error);
        }
    }];
}

- (SFSpeechRecognitionTask *)recognitionTaskWithRequest1:(SFSpeechURLRecognitionRequest *)request{
    return [self.speechRecognizer recognitionTaskWithRequest:request delegate:self];
}

- (void)dealloc {
    [self.recognitionTask cancel];
    self.recognitionTask = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFSpeechRecognitionTaskDelegate

// Called when the task first detects speech in the source audio
- (void)speechRecognitionDidDetectSpeech:(SFSpeechRecognitionTask *)task {
    
}

// Called for all recognitions, including non-final hypothesis
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription {
    NSLog(@"%@", transcription.formattedString);
    self.label.text = transcription.formattedString;
}

// Called only for final recognitions of utterances. No more about the utterance will be reported
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)recognitionResult {
//    NSString *resultString = recognitionResult.bestTranscription.formattedString;
//    self.label.text = resultString;
    // 解析完毕得到的最终文本
}

// Called when the task is no longer accepting new audio but may be finishing final processing
- (void)speechRecognitionTaskFinishedReadingAudio:(SFSpeechRecognitionTask *)task {
    
}

// Called when the task has been cancelled, either by client app, the user, or the system
- (void)speechRecognitionTaskWasCancelled:(SFSpeechRecognitionTask *)task {
    
}

// Called when recognition of all requested utterances is finished.
// If successfully is false, the error property of the task will contain error information
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishSuccessfully:(BOOL)successfully {
    
    self.button.enabled = YES;
    
    if (successfully) {
        NSLog(@"全部解析完毕");
        
    }
}

#pragma mark - event response

- (IBAction)tap:(id)sender {
    
    //2.创建识别请求
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1122334455.mp3" ofType:nil]]];
    
    //3.开始识别任务
    self.recognitionTask = [self recognitionTaskWithRequest1:request];
    
    self.button.enabled = NO;
    
}
#pragma mark - reuseable methods

#pragma mark - private methods

#pragma mark - getters and setters

@end

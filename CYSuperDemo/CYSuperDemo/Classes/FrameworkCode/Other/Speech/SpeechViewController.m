//
//  SpeechViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/18.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "SpeechViewController.h"
#import <Speech/Speech.h>

@interface SpeechViewController () <SFSpeechRecognitionTaskDelegate>
@property (nonatomic ,strong) SFSpeechRecognitionTask *recognitionTask;
@property (nonatomic ,strong) SFSpeechRecognizer      *speechRecognizer;
@property (nonatomic ,strong) UILabel                 *recognizerLabel;
@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 10.0, *)) {
        [self speech];
    } else {
        ShowMsg(@"iOS 10.0 以上才能使用");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)speech {
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
    
    //    [SFSpeechRecognizer supportedLocales];//根据手机设置的语言识别
    //    for (NSLocale *lacal in [SFSpeechRecognizer supportedLocales].allObjects) {
    //        NSLog(@"countryCode:%@  languageCode:%@ ", lacal.countryCode, lacal.languageCode);
    //    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1122334455.mp3" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //2.创建识别请求
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    //3.开始识别任务
    self.recognitionTask = [self recognitionTaskWithRequest1:request];
}

- (SFSpeechRecognitionTask *)recognitionTaskWithRequest0:(SFSpeechURLRecognitionRequest *)request{

    return [self.speechRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"语音识别解析正确--%@", result.bestTranscription.formattedString);
        }else {
            NSLog(@"语音识别解析失败--%@", error);
        }
    }];
}

- (SFSpeechRecognitionTask *)recognitionTaskWithRequest1:(SFSpeechURLRecognitionRequest *)request{
    return [self.speechRecognizer recognitionTaskWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- SFSpeechRecognitionTaskDelegate

// Called when the task first detects speech in the source audio
- (void)speechRecognitionDidDetectSpeech:(SFSpeechRecognitionTask *)task
{

}



// Called for all recognitions, including non-final hypothesis
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription {

}

// Called only for final recognitions of utterances. No more about the utterance will be reported
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)recognitionResult {
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 };

    CGRect rect = [recognitionResult.bestTranscription.formattedString boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.recognizerLabel.text = recognitionResult.bestTranscription.formattedString;
    self.recognizerLabel.frame = CGRectMake(50, 120, rect.size.width, rect.size.height+10);
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
    if (successfully) {
        NSLog(@"全部解析完毕");
    }
}

#pragma mark- getter

- (UILabel *)recognizerLabel {
    if (!_recognizerLabel) {
        _recognizerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, self.view.bounds.size.width - 100, 100)];
        _recognizerLabel.numberOfLines = 0;
        _recognizerLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _recognizerLabel.adjustsFontForContentSizeCategory = YES;
        _recognizerLabel.textColor = [UIColor orangeColor];
        [self.view addSubview:_recognizerLabel];
    }
    return _recognizerLabel;
}

@end

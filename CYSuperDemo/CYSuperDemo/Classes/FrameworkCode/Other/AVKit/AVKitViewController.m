//
//  AVKitViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/14.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "AVKitViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVKitViewController () <AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayerViewController *avplayerVC;

@end

@implementation AVKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"error = %@",[error description]);
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *remoteStr = @"https://media.w3.org/2010/05/sintel/trailer.mp4";
//    NSURL *remoteUrl = [NSURL URLWithString:remoteStr];
    
    NSString *localStr = [[NSBundle mainBundle] pathForResource:@"video1" ofType:@"mp4"];
    NSURL *localUrl = [NSURL fileURLWithPath:localStr];
    
    self.avplayerVC = [[AVPlayerViewController alloc] init];
    // 是否显示播放控制。 默认为YES。
    self.avplayerVC.showsPlaybackControls = YES;
    // 默认项，在layer层范围内保持长宽比适配。不会变形和缺失。
    self.avplayerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    // 在layer层范围内保持长宽比完全填充满。不会变形但是会使显示部分缺失。
//    self.avplayerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 平铺，会变形
//    self.avplayerVC.videoGravity = AVLayerVideoGravityResize;
    
//    self.avplayerVC.player = [AVPlayer playerWithURL:localUrl];
    
    // 表示第一个视频帧已经准备就绪，可以显示相关AVPlayer的当前项目，就是说是否准备好播放视频。
//    BOOL readyForDisplay = self.avplayerVC.readyForDisplay;
    // 视频图像显示在父视图范围内的当前大小和位置。
//    CGRect videoBounds = self.avplayerVC.videoBounds;
    // 获取在视频内容和视频控制控件之间用来添加其他自定义视图的内容叠加层视图。
//    UIView *contentOverlayView = self.avplayerVC.contentOverlayView;
    
    AVAsset *asset = [AVAsset assetWithURL:localUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    self.avplayerVC.player = [AVPlayer playerWithPlayerItem:item];
    
    self.avplayerVC.delegate = self;
    if (@available(iOS 9.0, *)) {
        // 是否允许画中画播放。 默认为YES。只在iPad上有效。
        self.avplayerVC.allowsPictureInPicturePlayback = YES;
    }
    
    if (@available(iOS 10.0, *)) {
        // 指示播放器视图控制器是否更新现在正在播放的信息中心.
        self.avplayerVC.updatesNowPlayingInfoCenter = YES;
    }
    
    if (@available(iOS 11.0, *)) {
        // 当播放按钮被点击时，是否自动进入全屏。 默认为NO。
//        self.avplayerVC.entersFullScreenWhenPlaybackBegins = YES;
//        // 当播放完后，是否自动退出全屏。 默认为NO。
//        self.avplayerVC.exitsFullScreenWhenPlaybackEnds = YES;
        
    } else {
        // Fallback on earlier versions
    }
//    [self presentViewController:self.avplayerVC animated:YES completion:^{
//        [self.avplayerVC.player play];
//    }];
    
    
    _avplayerVC.view.frame = CGRectMake(0, 100, 300, 300);
//    [_avplayerVC.player play];
    
    // Play the movie!
    [self.view addSubview:_avplayerVC.view];
    
}

#pragma mark - delegate
// 画中画将要开始时调用。
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}
// 画中画已经开始时调用。
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}
//在画中画无法启动时调用。
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error {
    
}

//在画中画将要停止是调用
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}
//在画中画已经停止是调用。
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}
//是否在开始画中画时自动将当前的播放界面dismiss掉 返回YES则自动dismiss 返回NO则不会自动dismiss。
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    //默认返回YES，表示进入画中画模式后，dismiss掉‘原视图’的layer
    return YES;
}
//用户点击还原按钮 从画中画模式还原时调用的方法。
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    [self presentViewController:playerViewController animated:YES completion:^{
        completionHandler(YES);
    }];
}
    
@end

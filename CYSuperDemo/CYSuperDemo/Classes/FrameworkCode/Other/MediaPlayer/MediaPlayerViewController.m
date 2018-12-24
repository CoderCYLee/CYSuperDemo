//
//  MediaPlayerViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/11/14.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation MediaPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *str = @"https://media.w3.org/2010/05/sintel/trailer.mp4";

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video1" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceMovieURL];
    _moviePlayer.view.frame=CGRectMake(0, 100, 300, 300);
    _moviePlayer.controlStyle=MPMovieControlStyleDefault;
    [_moviePlayer play];
    
    // Play the movie!
    [self.view addSubview:_moviePlayer.view];
    
    
}


- (void)dealloc {
    [_moviePlayer stop];
    _moviePlayer = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

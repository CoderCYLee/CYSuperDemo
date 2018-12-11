//
//  IADViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/11.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "IADViewController.h"
#import <iAd/iAd.h>

@interface IADViewController () <ADBannerViewDelegate>
@property (nonatomic, strong) ADBannerView *bannerView;
@end

@implementation IADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _bannerView.frame = CGRectMake(0, 100, 320, 50);
    _bannerView.delegate = self;
    [_bannerView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview: _bannerView];
}

/*!
 * @method bannerViewWillLoadAd:
 *
 * @discussion
 * Called when a banner has confirmation that an ad will be presented, but
 * before the resources necessary for presentation have loaded.
 */
- (void)bannerViewWillLoadAd:(ADBannerView *)banner  NS_AVAILABLE_IOS(5_0) {
    // banner 广告将要载入
    NSLog(@"banner 广告将要载入");
}

/*!
 * @method bannerViewDidLoadAd:
 *
 * @discussion
 * Called each time a banner loads a new ad. Once a banner has loaded an ad, it
 * will display it until another ad is available.
 *
 * It's generally recommended to show the banner view when this method is called,
 * and hide it again when bannerView:didFailToReceiveAdWithError: is called.
 */
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    // banner 广告已经载入
    NSLog(@"banner 广告已经载入");
}

/*!
 * @method bannerView:didFailToReceiveAdWithError:
 *
 * @discussion
 * Called when an error has occurred while attempting to get ad content. If the
 * banner is being displayed when an error occurs, it should be hidden
 * to prevent display of a banner view with no ad content.
 *
 * @see ADError for a list of possible error codes.
 */
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    // 广告加载错误
    NSLog(@"广告加载错误");
}

/*!
 * @method bannerViewActionShouldBegin:willLeaveApplication:
 *
 * Called when the user taps on the banner and some action is to be taken.
 * Actions either display full screen content modally, or take the user to a
 * different application.
 *
 * The delegate may return NO to block the action from taking place, but this
 * should be avoided if possible because most ads pay significantly more when
 * the action takes place and, over the longer term, repeatedly blocking actions
 * will decrease the ad inventory available to the application.
 *
 * Applications should reduce their own activity while the advertisement's action
 * executes.
 */
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    // 是否允许用户点击打开
    NSLog(@"是否允许用户点击打开");
    return YES;
}

/*!
 * @method bannerViewActionDidFinish:
 *
 * Called when a modal action has completed and control is returned to the
 * application. Games, media playback, and other activities that were paused in
 * bannerViewActionShouldBegin:willLeaveApplication: should resume at this point.
 */
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    // 用户关闭广告内容通知
    NSLog(@"用户关闭广告内容通知");
}

@end

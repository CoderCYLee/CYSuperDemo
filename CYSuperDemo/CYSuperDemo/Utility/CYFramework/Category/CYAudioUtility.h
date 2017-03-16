//
//  CYAudioUtility.h
//  CYSuperDemo
//
//  Created by Cyrill on 2017/3/16.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CYAudioUtility : NSObject

/**
 *
 * 需要播放的音频文件不能超过30秒
 * 必须是IMA/ADPCM格式[in linear PCM or IMA4(IMA/ADPCM) format]
 * 必须是.caf  .aif .wav文件
 */

/**
 * 播放声音(如：videoRing.caf)
 * @param fileNmae 资源名称
 * @param fileType 资源后缀名
 */
- (void)playAduio:(NSString*)fileNmae ext:(NSString*)fileType;

/**
 * 震动
 */
- (void)playVibrate;

@end

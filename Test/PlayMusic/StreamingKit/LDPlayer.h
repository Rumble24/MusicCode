//
//  LDPlayer.h
//  StreamingKit本地缓存
//
//  Created by 宜必鑫科技 on 2017/9/2.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "LDPlayMusicModel.h"
#import "STKAudioPlayer.h"
#import "PublicModel.h"

@protocol LDPlayerDelegate <NSObject>

- (void)updatePlayProgressWithTime:(float)value  currentTimeStr:(NSString *)currentTimeStr;
- (void)ldPlayStart;
- (void)ldPlayEnd;
- (void)playNewMusic;
- (void)playerChangeRate:(float)changeRate;
- (void)playError;
@end

@interface LDPlayer : NSObject<STKAudioPlayerDelegate>

@property (nonatomic, strong) STKAudioPlayer *player;

@property (nonatomic, weak) id<LDPlayerDelegate> delegate;
/* 用于播放上一首和下一首 */
@property (nonatomic, strong) NSArray *modelArray;
/* 当前播放的model */
@property (nonatomic, strong) LDPlayMusicModel *currentModel;
/* 当前的名字 */
@property (nonatomic, strong) NSString *currentUrlStr;
/* 当前的完整名字 */
@property (nonatomic, strong) NSString *currentAllUrlStr;
/* 当前的播放时间的字符串 */
@property (nonatomic, strong) NSString *currentTimeStr;
/* 当前的播放时间的浮点型 */
@property (nonatomic, assign) CGFloat playCurrentTime;
/* 当前的缓冲进度 */
@property (nonatomic, assign) CGFloat cacheProgress;

@property (nonatomic, copy) void (^CurrentTime)(CGFloat playCurrentTime);

@property (nonatomic, assign) NSInteger currentIndex;

+ (instancetype)sharePlayer;

- (void)play:(LDPlayMusicModel *)model;
/** 暂停 */
- (void)pause;
/** 跳到某个时间进度 */
- (void)seekToTime:(CGFloat)seconds completion:(void(^)(void))completion;
/** 上一首 */
- (void)PreviousTrack;
/** 下一首 */
- (void)NextTrack;




@end

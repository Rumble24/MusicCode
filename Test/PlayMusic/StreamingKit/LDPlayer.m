//
//  LDPlayer.m
//  StreamingKit本地缓存
//
//  Created by 宜必鑫科技 on 2017/9/2.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDPlayer.h"
#import "SUFileHandle.h"
#import <notify.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"

@interface LDPlayer ()
//时间计时器
@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, assign) BOOL isBack;

@end

@implementation LDPlayer

+ (instancetype)sharePlayer
{
    static LDPlayer *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/* 播放当前的音乐 */
- (void)play:(LDPlayMusicModel *)model
{
    if (self.player.state == STKAudioPlayerStatePaused)
    {
        [self.player resume];
    }
    else
    {
        self.currentModel = model;
        self.currentUrlStr = model.url;
        self.currentAllUrlStr = [NSString stringWithFormat:@"%@%@",[PublicModel getMusicPath],model.url];
        
        NSLog(@"完整的地址  %@",self.currentAllUrlStr);
        
        NSLog(@"我缓存的地址 %@",NSHomeDirectory());
        
        NSString * cacheFilePath = [SUFileHandle cacheFileExistsWithMusicName:self.currentUrlStr];
        if (cacheFilePath)
        {
            [self.player playURL:[NSURL fileURLWithPath:cacheFilePath]];
            NSLog(@"有缓存，播放缓存文件");
        }
        else
        {
            [self.player play:self.currentAllUrlStr];
            NSLog(@"无缓存，播放网络文件");
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(playNewMusic)]) {
            [self.delegate playNewMusic];
        }
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
    if(self.isBack == false)
    {
        [self playControl];
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
}
/** 暂停 */
- (void)pause
{
    [self.player pause];
    [self.timer setFireDate:[NSDate distantFuture]];
}
/** 跳到某个时间进度 */
- (void)seekToTime:(CGFloat)seconds completion:(void(^)(void))completion
{
    if (self.player) {
        [self.player seekToTime:seconds];
    }
}
/** 上一首 */
- (void)PreviousTrack
{
    if (self.modelArray == nil || self.modelArray.count == 1)
        return;
    
    NSInteger currrentIndex = self.currentModel.RN.integerValue - 1;
    if (currrentIndex - 1 < 0) {
        currrentIndex = self.modelArray.count - 1;
    }
    LDPlayMusicModel *model = self.modelArray[currrentIndex - 1];
    self.currentIndex = currrentIndex - 1;
    [self play:model];
}
/** 下一首 */
- (void)NextTrack
{
    if (self.modelArray == nil || self.modelArray.count == 1)
        return;
    
    NSInteger currrentIndex = self.currentModel.RN.integerValue - 1;
    if (currrentIndex + 1 >= self.modelArray.count) {
        currrentIndex = 0;
    }
    LDPlayMusicModel *model = self.modelArray[currrentIndex + 1];
    self.currentIndex = currrentIndex + 1;
    [self play:model];
}


#pragma mark - 读取进度信息
- (void)trackAction
{    
    self.currentTimeStr = [self timeFormatted:self.player.progress];
    self.playCurrentTime = self.player.progress;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(updatePlayProgressWithTime:currentTimeStr:)]) {
        [self.delegate updatePlayProgressWithTime:self.playCurrentTime currentTimeStr:self.currentTimeStr];
    }
    
    [self showLockScreenTotaltime:self.player.duration andCurrentTime:self.player.progress];
}





/// 开始播放
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ldPlayStart)]) {
        [self.delegate ldPlayStart];
    }
    NSLog(@"--------------开始播放--------------");
}
/// 完成加载
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    NSLog(@"--------------完成加载--------------");
}
/// 状态发生改变
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    NSLog(@"--------------状态发生改变 %ld",(long)state);
    
    if (state == STKAudioPlayerStatePlaying)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(playerChangeRate:)]) {
            [self.delegate playerChangeRate:1];
        }
    }
    else if(state == STKAudioPlayerStatePaused || state == STKAudioPlayerStateStopped || state == STKAudioPlayerStateError || state == STKAudioPlayerStateDisposed)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(playerChangeRate:)]) {
            [self.delegate playerChangeRate:0];
        }
    }
    else if(state == STKAudioPlayerStateDisposed)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ldPlayEnd)]) {
            [self.delegate ldPlayEnd];
        }
        [self NextTrack];
    }
}
/// 完成播放
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{

}
/// 发生错误
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playError)]) {
        [self.delegate playError];
    }
}


#pragma mark - tool
- (NSString *)timeFormatted:(double)totalSeconds {
    NSInteger seconds = (NSInteger)totalSeconds % 60;
    NSInteger minutes = (NSInteger)(totalSeconds / 60);
    return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
}
-(STKAudioPlayer*)player
{
    if (_player == nil)
    {
        _player = [[STKAudioPlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}

- (NSTimer*)timer
{
    if (_timer == nil)
    {
        //下载完成后执行每秒读取
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(trackAction) userInfo:nil repeats:YES];
    }
    return _timer;
}








#pragma mark -- Help Methods
//播放控制和监测
- (void)playControl
{
    //后台播放音频设置,需要在Capabilities->Background Modes中勾选Audio,Airplay,and Picture in Picture
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    self.isBack = true;
}

//展示锁屏歌曲信息：图片、歌词、进度、演唱者
- (void)showLockScreenTotaltime:(float)totalTime andCurrentTime:(float)currentTime
{
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    //设置歌曲题目
    [songDict setObject:[LDPlayer sharePlayer].currentModel.title forKey:MPMediaItemPropertyTitle];
    //设置歌手名
    [songDict setObject:[LDPlayer sharePlayer].currentModel.author forKey:MPMediaItemPropertyArtist];
    
    //设置歌曲时长
    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
    //设置已经播放时长
    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    if(![PublicModel isBlankString:[LDPlayer sharePlayer].currentModel.imgurl])
    {
        UIImageView *view = [UIImageView new];
        [view sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],[LDPlayer sharePlayer].currentModel.imgurl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil) {
                [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:image] forKey:MPMediaItemPropertyArtwork];
            }
        }];
    }
    else
    {
        [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"enXiuErImage.png"]] forKey:MPMediaItemPropertyArtwork];
    }
    
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
}

- (void)appDidEnterBackground
{
    if(self.player.state == STKAudioPlayerStatePaused || self.player.state == STKAudioPlayerStateStopped || self.player.state == STKAudioPlayerStateError || self.player.state == STKAudioPlayerStateDisposed)
    {
        [self removeObserver];
    }
}
// 移除观察者
- (void)removeObserver
{
    self.isBack = false;
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.togglePlayPauseCommand removeTarget:self];
    [commandCenter.pauseCommand removeTarget:self];
    [commandCenter.playCommand removeTarget:self];
    [commandCenter.previousTrackCommand removeTarget:self];
    [commandCenter.nextTrackCommand removeTarget:self];
    [commandCenter.changePlaybackPositionCommand removeTarget:self];
    
    NSLog(@"-----------------------------------------");
}

-(void)dealloc
{
    [self removeObserver];
}


@end

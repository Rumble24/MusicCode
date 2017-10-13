//
//  LDRadioBackView.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDRadioBackView.h"
#import "LDPlayer.h"
#import "UIButton+InitButton.h"
#import "PublicModel.h"
#import "PlayingLineView.h"
#import <AVFoundation/AVFoundation.h>
#import "SUFileHandle.h"


#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height) - 64
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

@interface LDRadioBackView ()<LDPlayerDelegate>
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIProgressView *downProgress;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) UIImageView *aniView;
@property (nonatomic, strong) PlayingLineView *lineView;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *cacheFilePath;
@property (nonatomic, assign) int status;
@property (nonatomic, strong) NSMutableArray *originalArray;
@property (nonatomic, strong) NSMutableArray *powerArray;
@end

@implementation LDRadioBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self)
    {
        [LDPlayer sharePlayer].delegate = self;
        _powerArray = [NSMutableArray array];
        _originalArray = [NSMutableArray array];
        self.clipsToBounds = false;
        [self createView];
    }
    return self;
}


- (void)createView
{
    _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1054/2.0f*kScale)];
    _backImage.image = [UIImage imageNamed:@"radio_backImage.png"];
    [self addSubview:_backImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (136 + 212 + 274 + 128) * kScale/2.0f, ScreenWidth, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textAlignment = 1;
    _nameLabel.textColor = [PublicModel colorWithHexString:@"60BDA5"];
    [self addSubview:_nameLabel];
    
    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (136 + 212 + 274 + 60 + 128) * kScale/2.0f, 52 * kScale, 15)];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.text = @"00:00";
    _leftLabel.textAlignment = 1;
    _leftLabel.textColor = [PublicModel colorWithHexString:@"2C977C"];
    [self addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 52 * kScale,(136 + 212 + 274 + 60 + 128) * kScale/2.0f, 52 * kScale, 15)];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.textAlignment = 1;
    _rightLabel.text = @"00:00";
    _rightLabel.textColor = [PublicModel colorWithHexString:@"2C977C"];
    [self addSubview:_rightLabel];
    
    _downProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(52 * kScale, (136 + 212 + 274 + 70 + 128) * kScale/2.0f, ScreenWidth - 104 * kScale, 5 * kScale)];
    _downProgress.trackTintColor = [PublicModel colorWithHexString:@"EDF4F8"];
    _downProgress.progressTintColor = [PublicModel colorWithHexString:@"A5FFE8"];
    [self addSubview:_downProgress];
    
    _playSlider = [[UISlider alloc]initWithFrame:CGRectMake(50 * kScale, (136 + 212 + 274 + 68 + 128) * kScale/2.0f, ScreenWidth - 104 * kScale, 5 * kScale)];
    _playSlider.minimumValue = 0.0;
    _playSlider.minimumTrackTintColor = [PublicModel colorWithHexString:@"6CC3A2"];
    _playSlider.maximumTrackTintColor = [UIColor clearColor];
    [_playSlider setThumbImage:[UIImage imageNamed:@"VideoSlider.png"] forState:UIControlStateNormal];
    [_playSlider addTarget:self action:@selector(progtessAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playSlider];
    
    _leftButton = [UIButton buttonWithTitle:@"" frame:CGRectMake(ScreenWidth /2.0f - 98 * kScale, (756/2.0f + 31.5f + 64)* kScale, 18  * kScale, 22  * kScale) target:self action:@selector(OnClickLeftBut)];
    [_leftButton setImage:[UIImage imageNamed:@"Radio_left.png"] forState:0];
    [self addSubview:_leftButton];
    
    _playButton = [UIButton buttonWithTitle:@"" frame:CGRectMake((ScreenWidth - 26 * kScale) / 2, (756/2.0f + 27 + 64)* kScale, 26  * kScale, 31  * kScale) target:self action:@selector(OnClickPlayButton)];
    [_playButton setImage:[UIImage imageNamed:@"RadioStop.png"] forState:0];
    [self addSubview:_playButton];
    
    _rightButton = [UIButton buttonWithTitle:@"" frame:CGRectMake(ScreenWidth /2.0f + 76 * kScale, (756/2.0f + 31.5f + 64)* kScale, 18  * kScale, 22  * kScale) target:self action:@selector(OnClickRightBut)];
    [_rightButton setImage:[UIImage imageNamed:@"Radio_right.png"] forState:0];
    [self addSubview:_rightButton];
    
    _lineView = [[PlayingLineView alloc]initWithFrame:CGRectMake(26 * kScale, (136 + 128)/2.0f * kScale, ScreenWidth - 52 * kScale, 106* kScale) lineWidth:7 * kScale lineColor:[UIColor yellowColor]];
    [self addSubview:_lineView];
    
    self.aniView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 52 * kScale, 219.5 * kScale)];
    _aniView.image = [UIImage imageNamed:@"AniBack.png"];
    [_lineView addSubview:self.aniView];
    
    UIImageView *downImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1054/2.0f*kScale - 20 * kScale, 130 * kScale, 40 * kScale)];
    downImage.image = [UIImage imageNamed:@"downImage.png"];
    [self addSubview:downImage];
}


- (void)setModel:(LDPlayMusicModel *)model
{
    _model = model;
    
    _nameLabel.text = model.title;
    
    _rightLabel.text = [NSString stringWithFormat:@"%@",[self getMiniteAndSecondFromInt:model.total_time]];
    
    self.playSlider.maximumValue = model.total_time.floatValue;
    
    _cacheFilePath = [SUFileHandle cacheFileExistsWithMusicName:model.url];
    
    if (_cacheFilePath)
    {
        self.downProgress.progress = 1.0f;
    }
    else
    {
        self.downProgress.progress = 0.0f;
    }
}


- (void)OnClickLeftBut
{
    [[LDPlayer sharePlayer] PreviousTrack];
}

- (void)OnClickRightBut
{
    [[LDPlayer sharePlayer] NextTrack];
}

- (void)OnClickPlayButton
{
    if (self.isPlaying == false)
    {
        [[LDPlayer sharePlayer]play:_model];
        [LDPlayer sharePlayer].delegate = self;
    }
    else
    {
        [[LDPlayer sharePlayer] pause];
    }
}


- (void)updatePlayProgressWithTime:(float)value  currentTimeStr:(NSString *)currentTimeStr
{
    _leftLabel.text = currentTimeStr;
    self.playSlider.value = value;
}

- (void)updateDownLoadProgress:(float)progress
{
    self.downProgress.progress = progress;
}

- (void)ldPlayStart
{
}

- (void)ldPlayEnd
{
    [[LDPlayer sharePlayer] NextTrack];
}

// 控制暂停和结束的
- (void)player:(AVPlayer *)player changeRate:(float)changeRate
{
    if (changeRate == 1) {
        [self.playButton setImage:[UIImage imageNamed:@"RadioStart.png"] forState:0];
        self.isPlaying = true;
        [self startCircle];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"RadioStop.png"] forState:0];
        self.isPlaying = false;
        [self stopCircle];
    }
}

- (void)playNewMusic
{
    self.model = [LDPlayer sharePlayer].currentModel;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:_cacheFilePath] error:nil];
    self.player.volume = 0;
    if (self.NeedReloadData) {
        self.NeedReloadData();
    }
}


#pragma mark - 滑动进度条
-(void)progtessAction:(UISlider *)slider
{
    [[LDPlayer sharePlayer] seekToTime:slider.value completion:^{
    }];
}




#pragma mark - 开始旋转 开始转动
- (void)startCircle
{
    if (_cacheFilePath && _player != nil)
    {
        [self.player play];
    }
    
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    else
    {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

#pragma mark - 停止播放
-(void)stopCircle
{
    [self.player pause];
    [self.lineView stopAllAnimation];
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)updateProgress
{
    if (_cacheFilePath && _player != nil)
    {
        _player.meteringEnabled = YES;
        [_player updateMeters];
        CGFloat power = ([_player averagePowerForChannel:0] + [_player averagePowerForChannel:1])/2;
        if (_cacheFilePath)
        {
            if(_status < 10)
            {
                _status++;
                return;
            }
            [_originalArray addObject:@(fabsf(power))];
            
            if (_originalArray.count == 30)
            {
                CGFloat max =[[_originalArray valueForKeyPath:@"@max.floatValue"] floatValue];
                
                CGFloat min =[[_originalArray valueForKeyPath:@"@min.floatValue"] floatValue];
                
                CGFloat percentage = 15.0f / (max - min);
                
                for (int i = 0 ; i < _originalArray.count; i++)
                {
                    NSNumber *number = _originalArray[i];
                    [_powerArray addObject:@((number.floatValue - min) * percentage)];
                }
                [self.lineView addAnimationWith:_powerArray];
                
                [_originalArray removeAllObjects];
                [_powerArray removeAllObjects];
            }
        }
    }
    else
    {
        float random = (arc4random() % 90) / 6.0f;
        [_powerArray addObject:@(random)];
        if (_powerArray.count == 30)
        {
            [self.lineView addAnimationWith:_powerArray];
            [_powerArray removeAllObjects];
        }        
    }
}


- (NSString *)getMiniteAndSecondFromInt:(NSNumber *)totleTime
{
    int minute = totleTime.intValue / 60;
    int second = totleTime.intValue % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}
@end

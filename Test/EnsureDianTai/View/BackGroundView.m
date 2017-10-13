//
//  BackGroundView.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/17.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "BackGroundView.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"
#import "LDPlayer.h"
#import "UIButton+InitButton.h"
#import "SUFileHandle.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height) - 64
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
//宏定义   角度转弧度
#define angleToRadian(x) (x/180.0*M_PI)

@interface BackGroundView ()<LDPlayerDelegate>

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *CircleImage;
@property (nonatomic, strong) UIImageView *StickImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIProgressView *downProgress;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isPlaying;
// 设置一个私有的定时器
@property (nonatomic,strong) CADisplayLink *link;

@property (nonatomic, assign) CGAffineTransform originalTransform;
@end

@implementation BackGroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        [LDPlayer sharePlayer].delegate = self;
        [self createView];
    }
    return self;
}


- (void)createView
{
    _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backImage.image = [UIImage imageNamed:@"musicBack.jpg"];
    [self addSubview:_backImage];
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
    view.frame = _backImage.frame;
    [self addSubview:view];
    
    // 中间的圆
    _CircleImage = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - 265 * kScale)/2, 68 * kScale, 265 * kScale, 265 * kScale)];
    _CircleImage.image = [UIImage imageNamed:@"VideoCircles.png"];
    [self addSubview:_CircleImage];
    
    // 可以动的棍子
    _StickImage = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - 82 * kScale)/2, 10 - 114 * kScale/2, 82 * kScale, 114 * kScale)];
    _StickImage.image = [UIImage imageNamed:@"VideoStick.png"];
    _StickImage.layer.anchorPoint = CGPointMake(0, 0);
    _originalTransform = _StickImage.transform;
    [self addSubview:_StickImage];
    
    // 最上面的帽子
    UIImageView *hatImage = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - 30* kScale)/2, -15, 30 * kScale, 30 * kScale)];
    hatImage.image = [UIImage imageNamed:@"VideoHat.png"];
    [self addSubview:hatImage];
    
    _centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(105 * kScale /2.0f, 105 * kScale /2.0f, 160 * kScale, 160 * kScale)];
    _centerImage.image = [UIImage imageNamed:@"Center_back.png"];
    [_centerImage setContentMode:UIViewContentModeScaleAspectFill];
    _centerImage.clipsToBounds = YES;
    [_CircleImage addSubview:_centerImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (68 + 265 + 90) * kScale, ScreenWidth, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textAlignment = 1;
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    
    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight - 118 * kScale, 52 * kScale, 15)];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.text = @"00:00";
    _leftLabel.textAlignment = 1;
    _leftLabel.textColor = [UIColor whiteColor];
    [self addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 52 * kScale, ScreenHeight - 118 * kScale, 52 * kScale, 15)];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.textAlignment = 1;
    _rightLabel.text = @"00:00";
    _rightLabel.textColor = [UIColor whiteColor];
    [self addSubview:_rightLabel];
    
    self.downProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(52 * kScale, ScreenHeight - 111 * kScale, ScreenWidth - 104 * kScale, 5 * kScale)];
    self.downProgress.trackTintColor = [PublicModel colorWithHexString:@"EDF4F8"];
    self.downProgress.progressTintColor = [PublicModel colorWithHexString:@"A5FFE8"];
    [self addSubview:self.downProgress];
    
    self.playSlider = [[UISlider alloc]initWithFrame:CGRectMake(50 * kScale, ScreenHeight - 113 * kScale, ScreenWidth - 104 * kScale, 5 * kScale)];
    self.playSlider.minimumValue = 0.0;
    self.playSlider.minimumTrackTintColor = [PublicModel colorWithHexString:@"6CC3A2"];
    self.playSlider.maximumTrackTintColor = [UIColor clearColor];
    [self.playSlider setThumbImage:[UIImage imageNamed:@"VideoSlider.png"] forState:UIControlStateNormal];
    [self.playSlider addTarget:self action:@selector(progtessAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playSlider];
    
    _leftButton = [UIButton buttonWithTitle:@"" frame:CGRectMake(56 * kScale, ScreenHeight - 83 * kScale, 53  * kScale, 53  * kScale) target:self action:@selector(OnClickLeftBut)];
    [_leftButton setImage:[UIImage imageNamed:@"VideoLast.png"] forState:0];
    [_leftButton setImage:[UIImage imageNamed:@"VideoLastHeight.png"] forState:1];
    [self addSubview:_leftButton];
    
    _playButton = [UIButton buttonWithTitle:@"" frame:CGRectMake((ScreenWidth - 69 * kScale) / 2, ScreenHeight - 90 * kScale, 69  * kScale, 69  * kScale) target:self action:@selector(OnClickPlayButton)];
    [_playButton setImage:[UIImage imageNamed:@"stop_normal.png"] forState:0];
    _playButton.adjustsImageWhenHighlighted = NO;
    [_playButton addTarget:self action:@selector(OnClickDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_playButton];
    
    _rightButton = [UIButton buttonWithTitle:@"" frame:CGRectMake(ScreenWidth - (53 + 56) * kScale, ScreenHeight - 83 * kScale, 53  * kScale, 53  * kScale) target:self action:@selector(OnClickRightBut)];
    [_rightButton setImage:[UIImage imageNamed:@"VideoLast.png"] forState:0];
    [_rightButton setImage:[UIImage imageNamed:@"VideoLastHeight.png"] forState:1];
    _rightButton.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:_rightButton];
}


- (void)setModel:(LDPlayMusicModel *)model
{
    _model = model;
    
    [_backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"musicBack.jpg"]];
    
    [_centerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"musicBack.jpg"]];
    
    _nameLabel.text = model.title;
    
    _rightLabel.text = [NSString stringWithFormat:@"%@",[self getMiniteAndSecondFromInt:model.total_time]];
    
    self.playSlider.maximumValue = model.total_time.floatValue;
    
    NSString * cacheFilePath = [SUFileHandle cacheFileExistsWithMusicName:model.url];
    
    if (cacheFilePath)
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

- (void)OnClickDown
{
    if (self.isPlaying == false)
    {
        [_playButton setImage:[UIImage imageNamed:@"stop_highlight.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [_playButton setImage:[UIImage imageNamed:@"play_highlight.png"] forState:UIControlStateHighlighted];
    }
}

- (void)OnClickPlayButton
{
    if (self.isPlaying == false)
    {
        [[LDPlayer sharePlayer]play:self.model];
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

- (void)player:(AVPlayer *)player changeRate:(float)changeRate
{
    if (changeRate == 1) {
        [self.playButton setImage:[UIImage imageNamed:@"play_normal.png"] forState:0];
        self.isPlaying = true;
        [self startCircle];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"stop_normal.png"] forState:0];
        self.isPlaying = false;
        [self stopCircle];
    }
}



#pragma mark - 滑动进度条
-(void)progtessAction:(UISlider *)slider
{
    [[LDPlayer sharePlayer] seekToTime:slider.value completion:^{
    }];
}

- (void)playNewMusic
{
    self.model = [LDPlayer sharePlayer].currentModel;
    if (self.NeedReloadData) {
        self.NeedReloadData();
    }
}

- (NSString *)getMiniteAndSecondFromInt:(NSNumber *)totleTime
{
    int minute = totleTime.intValue / 60;
    int second = totleTime.intValue % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}



#pragma mark - 开始旋转 开始转动
- (void)startCircle
{
    self.link.paused = false;
    
    [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _StickImage.transform = CGAffineTransformMakeRotation(-0.5f);
    } completion:^(BOOL finished) {}];
}

#pragma mark - 停止播放
-(void)stopCircle
{
    self.link.paused = true;

    [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _StickImage.transform = _originalTransform;
    } completion:^(BOOL finished) {}];
}


- (CADisplayLink *)link {
    if (!_link) {
        // 创建定时器, 一秒钟调用rotation方法60次
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotation)];
        // 手动将定时器加入到事件循环中
        // NSRunLoopCommonModes会使得RunLoop会随着界面切换扔继续使用, 不然如果使用Default的话UI交互没问题, 但滑动TableView就会出现不转问题, 因为RunLoop模式改变会影响定时器调度
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}


/**  背景图rotation滚动 */
- (void)rotation
{
    self.centerImage.layer.transform = CATransform3DRotate(self.centerImage.layer.transform, angleToRadian(0.4f), 0, 0, 1);
}






































































@end

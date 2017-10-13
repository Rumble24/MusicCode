//
//  LDPlayMusicCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDPlayMusicCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "LDPlayer.h"
#import "SUFileHandle.h"
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface LDPlayMusicCell ()<LDPlayerDelegate>
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *musicImage;
@property (nonatomic, strong) UIButton *playBut;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *downloadImage;
@property (nonatomic, strong) UILabel *totleSize;
@property (nonatomic, strong) UIImageView *timeImage;
@property (nonatomic, strong) UILabel *playTime;
@property (nonatomic, strong) UILabel *totleTime;
@property (nonatomic, strong) UIProgressView *downProgress;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation LDPlayMusicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
        [self createTableCellView];
    }
    return self;
}

- (void)createTableCellView
{
    self.backImage = [[UIImageView alloc]init];
    self.backImage.backgroundColor = [UIColor whiteColor];
    self.backImage.layer.masksToBounds = YES;
    self.backImage.layer.cornerRadius = 5;
    self.backImage.layer.borderWidth = 1;
    self.backImage.userInteractionEnabled = YES;
    self.backImage.layer.borderColor = [[PublicModel colorWithHexString:@"#148CE2FF"] CGColor];
    [self.contentView addSubview:self.backImage];
    
    self.musicImage = [[UIImageView alloc]init];
    [self.musicImage setContentMode:UIViewContentModeScaleAspectFill];
    self.musicImage.clipsToBounds = YES;
    self.musicImage.userInteractionEnabled = YES;
    [self.backImage addSubview:self.musicImage];
    
    self.playBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBut addTarget:self action:@selector(OnClickPlayButton) forControlEvents:1<<6];
    [self.playBut setImage:[UIImage imageNamed:@"StopMusic"] forState:0];
    [self.musicImage addSubview:self.playBut];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [PublicModel colorWithHexString:@"99D1F9"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.backImage addSubview:self.titleLabel];
    
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.textColor = [PublicModel colorWithHexString:@"B2B1C4FF"];
    self.authorLabel.font = [UIFont systemFontOfSize:15];
    [self.backImage addSubview:self.authorLabel];
    
    self.downloadImage = [[UIImageView alloc]init];
    self.downloadImage.image = [UIImage imageNamed:@"Download"];
    [self.backImage addSubview:self.downloadImage];
    
    self.totleSize = [[UILabel alloc]init];
    self.totleSize.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
    self.totleSize.font = [UIFont systemFontOfSize:15];
    [self.backImage addSubview:self.totleSize];
    
    self.timeImage = [[UIImageView alloc]init];
    self.timeImage.image = [UIImage imageNamed:@"CJSJTime"];
    [self.backImage addSubview:self.timeImage];
    
    self.playTime = [[UILabel alloc]init];
    self.playTime.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
    self.playTime.font = [UIFont systemFontOfSize:15];
    self.playTime.textAlignment = NSTextAlignmentRight;
    self.playTime.text = @"00:00";
    [self.backImage addSubview:self.playTime];
    
    self.totleTime = [[UILabel alloc]init];
    self.totleTime.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
    self.totleTime.font = [UIFont systemFontOfSize:15];
    [self.backImage addSubview:self.totleTime];
    
    self.downProgress = [[UIProgressView alloc]init];
    self.downProgress.trackTintColor = [PublicModel colorWithHexString:@"EDF4F8"];
    self.downProgress.progressTintColor = [PublicModel colorWithHexString:@"A5FFE8"];
    [self.backImage addSubview:self.downProgress];
    
    self.playSlider = [[UISlider alloc]init];
    self.playSlider.minimumValue = 0.0;
    self.playSlider.minimumTrackTintColor = [PublicModel colorWithHexString:@"6CC3A2"];
    self.playSlider.maximumTrackTintColor = [UIColor clearColor];
    [self.playSlider setThumbImage:[UIImage imageNamed:@"ScrollerBarBut"] forState:UIControlStateNormal];
    [self.playSlider addTarget:self action:@selector(progtessAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backImage addSubview:self.playSlider];    
}

- (void)setModel:(LDPlayMusicModel *)model
{
    _model = model;
    
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"ArticleDefaultIcon"]];
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
    self.totleSize.text = model.file_size;
    self.playSlider.maximumValue = model.total_time.floatValue;
    self.totleTime.text = [NSString stringWithFormat:@"/%@",[self getMiniteAndSecondFromInt:model.total_time]];
    
    NSString * cacheFilePath = [SUFileHandle cacheFileExistsWithMusicName:model.url];
    // 正在播放的音乐
    if ([self.model.url isEqualToString:[LDPlayer sharePlayer].currentUrlStr])
    {
        if ([LDPlayer sharePlayer].player.state == STKAudioPlayerStatePlaying) {
            self.isPlaying = false;
            [self.playBut setImage:[UIImage imageNamed:@"PlayMusic"] forState:0];
        }else if([LDPlayer sharePlayer].player.state == STKAudioPlayerStatePaused || [LDPlayer sharePlayer].player.state == STKAudioPlayerStateStopped || [LDPlayer sharePlayer].player.state == STKAudioPlayerStateError ){
            self.isPlaying = true;
            [self.playBut setImage:[UIImage imageNamed:@"StopMusic"] forState:0];
        }
        self.playTime.textColor = [PublicModel colorWithHexString:@"91E0CC"];
        self.downloadImage.image = [UIImage imageNamed:@"AlreadyDown"];
        self.totleSize.textColor = [PublicModel colorWithHexString:@"99D1F9"];

        if (cacheFilePath)
        {
            self.downProgress.progress = 1.0f;
        }
        else
        {
            self.downProgress.progress = [LDPlayer sharePlayer].cacheProgress;            
        }
        
        [LDPlayer sharePlayer].delegate = self;
        
        self.playTime.text = [LDPlayer sharePlayer].currentTimeStr;
        self.playSlider.value = [LDPlayer sharePlayer].playCurrentTime;
        
        self.playSlider.userInteractionEnabled = YES;
    }
    else
    {
        [self.playBut setImage:[UIImage imageNamed:@"StopMusic"] forState:0];
        self.playTime.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
        
        self.playTime.text = @"00:00";
        self.playSlider.value = 0.0f;
        
        self.playSlider.userInteractionEnabled = NO;
        self.isPlaying = false;
        
        if (cacheFilePath)
        {
            self.downProgress.progress = 1.0f;
            self.downloadImage.image = [UIImage imageNamed:@"AlreadyDown"];
            self.totleSize.textColor = [PublicModel colorWithHexString:@"99D1F9"];
        }
        else
        {
            self.downProgress.progress = 0.0f;
            self.downloadImage.image = [UIImage imageNamed:@"Download"];
            self.totleSize.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backImage.frame = CGRectMake(5, 0, ScreenWidth - 10, 100 * kScale);
    self.musicImage.frame = CGRectMake(0, 0, 100 * kScale, 100 * kScale);
    self.playBut.frame = CGRectMake( 0,0,48 * kScale, 48 * kScale);
    self.playBut.center = self.musicImage.center;
    self.titleLabel.frame = CGRectMake(110 *kScale, 10* kScale, ScreenWidth - 160 *kScale, 16* kScale);
    self.authorLabel.frame = CGRectMake(110 *kScale, 37* kScale, ScreenWidth - 160 *kScale, 16* kScale);
    self.downloadImage.frame = CGRectMake(110 *kScale, 70 * kScale, 11 * kScale, 11 * kScale);
    self.totleSize.frame = CGRectMake(125 *kScale, 67 * kScale, 50 * kScale, 16 * kScale);
    self.timeImage.frame = CGRectMake(ScreenWidth - 10 - 110,70 * kScale, 10, 10);
    self.playTime.frame = CGRectMake(ScreenWidth - 10 - 100, 67 * kScale, 45, 16);
    self.totleTime.frame = CGRectMake(ScreenWidth - 10 - 55, 67 * kScale, 50, 16);
    self.downProgress.frame = CGRectMake(110 *kScale, 87* kScale, ScreenWidth - 10 - 120 * kScale, 6);
    self.playSlider.frame = CGRectMake(108 *kScale, 85* kScale, ScreenWidth - 10 - 120 * kScale, 6);
}


- (void)OnClickPlayButton
{
    if (self.isPlaying == false)
    {
        [[LDPlayer sharePlayer]play:self.model];
        [LDPlayer sharePlayer].delegate = self;
        NSLog(@"isPlaying");
    }
    else
    {
        [[LDPlayer sharePlayer] pause];
        NSLog(@"pause");
    }
    self.isPlaying = !self.isPlaying;
}

- (void)updatePlayProgressWithTime:(float)value  currentTimeStr:(NSString *)currentTimeStr
{
    if ([self.model.url isEqualToString:[LDPlayer sharePlayer].currentUrlStr])
    {
        self.playTime.textColor = [PublicModel colorWithHexString:@"91E0CC"];
        self.playTime.text = currentTimeStr;
        self.playSlider.value = value;
    }
    else
    {
        self.playTime.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
        self.playTime.text = @"00:00";
        self.playSlider.value = 0.0f;
    }
}
- (void)updateDownLoadProgress:(float)progress
{
    self.downProgress.progress = progress;
    
    if (progress == 1)
    {
        self.downloadImage.image = [UIImage imageNamed:@"AlreadyDown"];
        self.totleSize.textColor = [PublicModel colorWithHexString:@"99D1F9"];
    }
}

- (void)ldPlayStart
{
    [self.playBut setImage:[UIImage imageNamed:@"PlayMusic"] forState:0];
    self.playTime.textColor = [PublicModel colorWithHexString:@"91E0CC"];
    self.playSlider.userInteractionEnabled = YES;
    self.playSlider.value = 0.0f;
}

- (void)ldPlayEnd
{
    self.playTime.textColor = [PublicModel colorWithHexString:@"D8E2EA"];
    [self.playBut setImage:[UIImage imageNamed:@"StopMusic"] forState:0];
    [[LDPlayer sharePlayer] seekToTime:0 completion:^{
        self.isPlaying = !self.isPlaying;
    }];
}

- (void)playerChangeRate:(float)changeRate
{
    if (changeRate == 1) {
        self.isPlaying = true;
        [self.playBut setImage:[UIImage imageNamed:@"PlayMusic"] forState:0];
    }else{
        self.isPlaying = false;
        [self.playBut setImage:[UIImage imageNamed:@"StopMusic"] forState:0];
    }
}

- (void)playError
{
    
}




#pragma mark - 滑动进度条
-(void)progtessAction:(UISlider *)slider
{
    [[LDPlayer sharePlayer] seekToTime:slider.value completion:^{
    }];
}
- (void)playNewMusic
{
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

@end

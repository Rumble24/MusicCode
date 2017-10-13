//
//  LDEpertsContentController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDVideoController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
#import "ZFPlayer.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "PublicModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDVideoController () <ZFPlayerDelegate>
/** 播放器View的父视图*/
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *mPlayerView;

@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation LDVideoController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        self.playerView.playerPushedOrPresented = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    
    [self createScrollerView];
}

- (void)createView
{
    self.mPlayerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375, 200)];
    [self.view addSubview:self.mPlayerView];
    
    self.title = @"新生儿遗传代谢病专题";
    
    _playerView = [[ZFPlayerView alloc] init];
    
    [_playerView playerControlView:nil playerModel:self.playerModel];
    
    // 设置代理
    _playerView.delegate = self;
    
    _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
    
    // 打开预览图
    self.playerView.hasPreviewView = YES;
}

- (void)createScrollerView
{
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.frame = CGRectMake(0, 264, WIDTH, HEIGHT - 200 - 64);
    [self.view addSubview:self.scrollerView];
    
    
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect namerect = [self.model.des boundingRectWithSize:CGSizeMake(WIDTH - 10, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, WIDTH - 10, namerect.size.height)];
    label.numberOfLines = 0;
    label.text = self.model.des;
    [self.scrollerView addSubview:label];
    
    self.scrollerView.contentSize = label.frame.size;
    self.scrollerView.showsHorizontalScrollIndicator = YES;
    self.scrollerView.showsVerticalScrollIndicator = YES;
}


// 设置是否可以旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}
#pragma mark - Getter
- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.videoURL         = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],_model.vedio_url]];
        _playerModel.placeholderImageURLString = [NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],_model.imgurl];
        _playerModel.fatherView       = self.mPlayerView;
        NSLog(@"Video------->%@",[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],_model.vedio_url]);
    }
    return _playerModel;
}

@end

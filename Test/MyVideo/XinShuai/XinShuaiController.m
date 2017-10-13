//
//  XinShuaiController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
#import "ZFPlayer.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "UIButton+InitButton.h"
#import "LDDiseaseCollectionView.h"

#import "XinShuaiExpertController.h"
#import "XinShuaiContentController.h"
#import "XinShuaiTextController.h"
#import "XinShuaiTextController1.h"
#import "XinShuaiTextController2.h"
#import "XinShuaiTextController3.h"
#import "XinShuaiTextController4.h"
#import "XinShuaiTextController5.h"
#import "XinShuaiTextController6.h"
#import "XinShuaiTextController7.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "LDVideoController.h"
#import "LDTextController.h"

#import "PublicModel.h"

@interface XinShuaiController () <ZFPlayerDelegate>
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *mPlayerView;
@property (nonatomic, strong) LDDiseaseCollectionView *mBelowView;
@end

@implementation XinShuaiController


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
    [self.playerView pause];
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
    
    [self createView];
    
    [self createBelowView];
    
    [self createLastBelowView];
}


- (void)createView
{
    self.mPlayerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 200)];
    [self.view addSubview:self.mPlayerView];
    
    self.title = @"先天性心脏病专题";
    
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    _playerView = [[ZFPlayerView alloc] init];
    
    [_playerView playerControlView:nil playerModel:self.playerModel];
    
    // 设置代理
    _playerView.delegate = self;
    
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
    
    // 打开预览图
    self.playerView.hasPreviewView = YES;
}


- (void)createBelowView
{
    self.mBelowView = [[LDDiseaseCollectionView alloc]init];
    self.mBelowView.view.frame = CGRectMake(0, 264, WIDTH, HEIGHT - 49 - 64 - 200);
    self.mBelowView.titleArray = @[@"专家",@"疾病介绍",@"动脉导管未闭",@"肺动脉口狭窄",@"房间隔缺损",@"室间隔缺损",@"主动脉狭窄",@"主动脉窦动脉瘤",@"法洛四联症"];
    [self.view addSubview:self.mBelowView.view];
  
    XinShuaiExpertController *epertsController = [[XinShuaiExpertController alloc]init];
    epertsController.OnClickButton = ^(NSInteger index,NSArray *modelArray) {
        if (index == -1)
        {
            XinShuaiContentController *vc = [[XinShuaiContentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            LDEpertsModel *model = modelArray[index];
            if ([model.type isEqualToString:@"2"])
            {
                LDVideoController *vc = [[LDVideoController alloc]init];
                vc.model = modelArray[index];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([model.type isEqualToString:@"1"])
            {
                LDTextController *vc = [[LDTextController alloc]init];
                vc.model = modelArray[index];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    };
    [self.mBelowView addChildViewController:epertsController];
    
    
    XinShuaiTextController *vc = [[XinShuaiTextController alloc]init];
    [self.mBelowView addChildViewController:vc];
    
    XinShuaiTextController1 *vc1 = [[XinShuaiTextController1 alloc]init];
    [self.mBelowView addChildViewController:vc1];
    
    XinShuaiTextController2 *vc2 = [[XinShuaiTextController2 alloc]init];
    [self.mBelowView addChildViewController:vc2];
    
    XinShuaiTextController3 *vc3 = [[XinShuaiTextController3 alloc]init];
    [self.mBelowView addChildViewController:vc3];
    
    XinShuaiTextController4 *vc4 = [[XinShuaiTextController4 alloc]init];
    [self.mBelowView addChildViewController:vc4];
    
    XinShuaiTextController5 *vc5 = [[XinShuaiTextController5 alloc]init];
    [self.mBelowView addChildViewController:vc5];
    
    XinShuaiTextController6 *vc6 = [[XinShuaiTextController6 alloc]init];
    [self.mBelowView addChildViewController:vc6];
    
    XinShuaiTextController7 *vc7 = [[XinShuaiTextController7 alloc]init];
    [self.mBelowView addChildViewController:vc7];
}


- (void)createLastBelowView
{
    UIButton *button = [UIButton buttonWithTitle:@"诊断/医疗通道" frame:CGRectMake(0, HEIGHT - 49, WIDTH, 49) target:self action:@selector(createLastBelowView)];
    button.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0];
    [self.view addSubview:button];
    
}

- (void)OnClickLeftBtn
{
    [self.playerView resetPlayer];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return ZFPlayerShared.isStatusBarHidden;
}

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.videoURL         = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],@"diseaseVedio1.mp4"]];
        _playerModel.placeholderImageURLString = [NSString stringWithFormat:@"%@%@,%d",[PublicModel getBigImagePath],@"disease1.jpg?a=",arc4random() % 100];
        _playerModel.fatherView       = self.mPlayerView;
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],@"diseaseVedio1.mp4"]);
    }
    return _playerModel;
}
@end

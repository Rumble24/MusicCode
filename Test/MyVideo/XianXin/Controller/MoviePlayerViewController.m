    //
//  MoviePlayerViewController.m
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MoviePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
#import "ZFPlayer.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "UIButton+InitButton.h"
#import "LDDiseaseCollectionView.h"
#import "LDEpertsController.h"
#import "LDDiseaseTextController1.h"
#import "LDDiseaseTextController2.h"
#import "LDDiseaseTextController3.h"
#import "LDDiseaseTextController4.h"
#import "LDDiseaseTextController5.h"
#import "ExpertsContentController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "LDVideoController.h"
#import "LDTextController.h"

#import "PublicModel.h"


@interface MoviePlayerViewController () <ZFPlayerDelegate>

@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *mPlayerView;
@property (nonatomic, strong) LDDiseaseCollectionView *mBelowView;

@end

@implementation MoviePlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying)
    {
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
    
    self.title = @"新生儿遗传代谢病专题";
    
    
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
    self.mBelowView.titleArray = @[@"专家",@"疾病介绍",@"G6PD",@"TSH",@"CAH",@"PKU"];
    [self.view addSubview:self.mBelowView.view];
    
    
    LDEpertsController *epertsController = [[LDEpertsController alloc]init];
    epertsController.OnClickButton = ^(NSInteger index,NSArray *modelArray) {        
        if (index == -1)
        {
            ExpertsContentController *vc = [[ExpertsContentController alloc]init];
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

    
    LDDiseaseTextController1 *vc = [[LDDiseaseTextController1 alloc]init];
    [self.mBelowView addChildViewController:vc];
    
    LDDiseaseTextController2 *vc2 = [[LDDiseaseTextController2 alloc]init];
    [self.mBelowView addChildViewController:vc2];
    
    LDDiseaseTextController3 *vc3 = [[LDDiseaseTextController3 alloc]init];
    [self.mBelowView addChildViewController:vc3];
    
    LDDiseaseTextController4 *vc4 = [[LDDiseaseTextController4 alloc]init];
    [self.mBelowView addChildViewController:vc4];
    
    LDDiseaseTextController5 *vc5 = [[LDDiseaseTextController5 alloc]init];
    [self.mBelowView addChildViewController:vc5];
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
        _playerModel.videoURL         = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],@"diseaseVedio2.mp4"]];
//        _playerModel.videoURL         = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456665467509qingshu.mp4"];

        _playerModel.placeholderImageURLString = [NSString stringWithFormat:@"%@%@,%d",[PublicModel getBigImagePath],@"disease2.jpg?a=",arc4random() % 100];
        _playerModel.fatherView       = self.mPlayerView;
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[PublicModel getVideoPath],@"diseaseVedio2.mp4"]);
    }
    return _playerModel;
}
@end

//
//  LDPlayMusicController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDPlayMusicController.h"
#import "LDPlayMusicTableController.h"
#import "UIButton+InitButton.h"

#import "PublicModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <notify.h>
#import "LDPlayer.h"
#import "UIImageView+WebCache.h"
@interface LDPlayMusicController ()

@end

@implementation LDPlayMusicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self CreteView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)CreteView
{
    self.titleArray = @[@"亲子活动",@"认知学习",@"身体律动",@"生活习惯"];
    
    self.title = @"早教音乐";
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    LDPlayMusicTableController *vc1 = [[LDPlayMusicTableController alloc]init];
    vc1.typeCode = @"T020101";
    [self addChildViewController:vc1];
    
    LDPlayMusicTableController *vc2 = [[LDPlayMusicTableController alloc]init];
    vc2.typeCode = @"T020102";
    [self addChildViewController:vc2];
    
    LDPlayMusicTableController *vc3 = [[LDPlayMusicTableController alloc]init];
    vc3.typeCode = @"T020103";
    [self addChildViewController:vc3];
    
    LDPlayMusicTableController *vc4 = [[LDPlayMusicTableController alloc]init];
    vc4.typeCode = @"T020104";
    [self addChildViewController:vc4];
}

- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end

//
//  MyCircleController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/28.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyCircleController.h"
#import "UIButton+InitButton.h"
#import "WJTableViewController.h"
#import "PublicModel.h"

@interface MyCircleController ()

@end

@implementation MyCircleController

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
    self.titleArray = @[@"我的动态",@"我的收藏"];
    
    self.title = @"我的帖子";
    
    WJTableViewController *vc1 = [[WJTableViewController alloc]init];
    vc1.url = [PublicModel getMyPostURL];
    vc1.type = 1;
    [self addChildViewController:vc1];
    
    WJTableViewController *vc2 = [[WJTableViewController alloc]init];
    vc2.url = [PublicModel getMyPostURL];
    vc2.type = 2;
    [self addChildViewController:vc2];
}

@end

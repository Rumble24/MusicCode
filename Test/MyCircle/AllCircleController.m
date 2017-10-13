//
//  ViewController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "AllCircleController.h"
#import "WJTableViewController.h"
#import "UIButton+InitButton.h"
#import "WJPublishPicVC.h"
#import "PublicModel.h"
#import "MyCircleController.h"
#import "MyMessageController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AllCircleController ()
@end

@implementation AllCircleController

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
    self.titleArray = @[@"全部动态",@"热门动态",@"好友动态"];
    
    self.title = @"宝蜜会";
    
    UIButton *button = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 18, 4) target:self action:@selector(OnClickRightBut)];
    [button setImage:[UIImage imageNamed:@"allTiezi.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    WJTableViewController *vc1 = [[WJTableViewController alloc]init];
    vc1.url = [PublicModel getPostURL];
    vc1.type = 1;
    [self addChildViewController:vc1];
    
    WJTableViewController *vc2 = [[WJTableViewController alloc]init];
    vc2.url = [PublicModel getPostURL];
    vc2.type = 2;
    [self addChildViewController:vc2];
    
    WJTableViewController *vc3 = [[WJTableViewController alloc]init];
    vc3.url = [PublicModel getPostURL];
    vc3.type = 3;
    [self addChildViewController:vc3];
}

- (void)OnClickRightBut
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"发帖" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        WJPublishPicVC *Pic = [[WJPublishPicVC alloc]init];
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"我的帖子" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        MyCircleController *Pic = [[MyCircleController alloc]init];
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"社区消息" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        MyMessageController *Pic = [[MyMessageController alloc]init];
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{}];
}


- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end













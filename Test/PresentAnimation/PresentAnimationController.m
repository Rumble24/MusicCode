//
//  PresentAnimationController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/27.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PresentAnimationController.h"
#import "UIButton+InitButton.h"
#import <JrmfWalletKit/JrmfWalletKit.h>
#import "LDNavication.h"
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface PresentAnimationController ()

@end

@implementation PresentAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    LDNavication *navc = [[LDNavication alloc]init];
    [self.view addSubview:navc];
    
    [navc.leftBut addTarget:self action:@selector(OnClickLeftBtn) forControlEvents:1<<6];
    
    navc.titleLabel.text = @"PresentAnimationController";
}


- (void)OnClickLeftBtn
{
    [UIView animateWithDuration:5 animations:^{        
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{}];
    }];
}




@end

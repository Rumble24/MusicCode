//
//  ChatFunctionController.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ChatFunctionController.h"
#import "PublicModel.h"
#import "CxyButton.h"
#import "ChooseBackgroundController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ChatFunctionController ()

@property (nonatomic, strong) CxyButton *chooseBut;

@end

@implementation ChatFunctionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"聊天背景";
    
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.chooseBut = [CxyButton buttonWithType:UIButtonTypeCustom];
    self.chooseBut.frame = CGRectMake(0, 10, WIDTH, 44);
    self.chooseBut.backgroundColor = [UIColor whiteColor];
    self.chooseBut.titleRect = CGRectMake(15, 0, WIDTH - 100, 44);
    self.chooseBut.imageRect = CGRectMake(WIDTH - 30, 14.5f, 6, 15);
    [self.chooseBut setImage:[UIImage imageNamed:@"ChooseRight.png"] forState:(UIControlStateNormal)];
    [self.chooseBut setTitle:@"选择背景图" forState:UIControlStateNormal];
    [self.chooseBut setTitleColor:[PublicModel colorWithHexString:@"#52BEA4"] forState:(UIControlStateNormal)];
    [self.chooseBut addTarget:self action:@selector(OnClickChooseBut) forControlEvents:1<<6];
    [self.view addSubview:self.chooseBut];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti1) name:@"popChatFunctionController" object:nil];
}

-(void)noti1
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)OnClickChooseBut
{
    ChooseBackgroundController *vc = [[ChooseBackgroundController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  ViewController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/27.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+InitButton.h"
#import "AllCircleController.h"
#import "PublicModel.h"
#import "MedicalController.h"
#import "MoviePlayerViewController.h"
#import "XinShuaiController.h"
#import <RongIMKit/RongIMKit.h>
#import "LDChatListController.h"
#import "LDChooseAreaController.h"
#import "LDPlayMusicController.h"
#import "LDMorningMusicController.h"
#import "RCDCustomerServiceViewController.h"
#import "UploadInsuranceController.h"
#import "PresentAnimationController.h"
#import <JrmfWalletKit/JrmfWalletKit.h>
#import "LDMusicController.h"
#import "LDRadioController.h"
#import "LDShareController.h"

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString *VersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"%@",NSHomeDirectory());

    
    UIButton *button = [UIButton buttonWithTitle:@"孕妈圈" frame:CGRectMake(50, 64, 100, 50) target:self action:@selector(OnClickButton1)];
    [self.view addSubview:button];
    
    UIButton *button_1 = [UIButton buttonWithTitle:@"音乐第二版" frame:CGRectMake((ScreenWidth - 100)/2, 64, 100, 50) target:self action:@selector(OnClickButton_1)];
    [self.view addSubview:button_1];
    
    UIButton *button_2 = [UIButton buttonWithTitle:@"恩秀儿电台" frame:CGRectMake((ScreenWidth - 100)/2 + 150, 64, 100, 50) target:self action:@selector(OnClickButton_2)];
    [self.view addSubview:button_2];
    
    UIButton *button1 = [UIButton buttonWithTitle:@"医疗档案" frame:CGRectMake((ScreenWidth - 100)/2, 160 - 50, 100, 50) target:self action:@selector(OnClickButton2)];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithTitle:@"先天病" frame:CGRectMake((ScreenWidth - 100)/2, 220 - 50, 100, 50) target:self action:@selector(OnClickButton3)];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithTitle:@"遗传代谢病" frame:CGRectMake((ScreenWidth - 100)/2, 280 - 50, 100, 50) target:self action:@selector(OnClickButton4)];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithTitle:@"聊天记录" frame:CGRectMake((ScreenWidth - 100)/2, 340 - 50, 100, 50) target:self action:@selector(OnClickButton5)];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithTitle:@"选择省市区" frame:CGRectMake((ScreenWidth - 100)/2, 400 - 50, 100, 50) target:self action:@selector(OnClickButton6)];
    [self.view addSubview:button5];
    
    UIButton *button6 = [UIButton buttonWithTitle:@"早教音乐" frame:CGRectMake(10, 460 - 50, 80, 50) target:self action:@selector(OnClickButton7)];
    [self.view addSubview:button6];
    
    UIButton *button7 = [UIButton buttonWithTitle:@"早教故事" frame:CGRectMake(100, 460 - 50, 80, 50) target:self action:@selector(OnClickButton8)];
    [self.view addSubview:button7];
    
    UIButton *button8 = [UIButton buttonWithTitle:@"胎教音乐" frame:CGRectMake(190, 460 - 50, 80, 50) target:self action:@selector(OnClickButton9)];
    [self.view addSubview:button8];
    
    UIButton *button9 = [UIButton buttonWithTitle:@"胎教故事" frame:CGRectMake(280, 460 - 50, 80, 50) target:self action:@selector(OnClickButton10)];
    [self.view addSubview:button9];
    
    UIButton *button10 = [UIButton buttonWithTitle:@"客服聊天" frame:CGRectMake((ScreenWidth - 100)/2, 510 - 50, 80, 50) target:self action:@selector(OnClickButton11)];
    [self.view addSubview:button10];
    
    UIButton *button11 = [UIButton buttonWithTitle:@"保险理赔" frame:CGRectMake((ScreenWidth - 100)/2, 570 - 50, 80, 50) target:self action:@selector(OnClickButton12)];
    [self.view addSubview:button11];
    
    UIButton *button12 = [UIButton buttonWithTitle:@"自定模态跳转动画" frame:CGRectMake((ScreenWidth - 150)/2, 630 - 50, 150, 50) target:self action:@selector(OnClickButton13)];
    [self.view addSubview:button12];
    
    UIButton *button13 = [UIButton buttonWithTitle:@"分享" frame:CGRectMake((ScreenWidth - 150)/2, 640, 150, 50) target:self action:@selector(OnClickButton14)];
    [self.view addSubview:button13];
}

- (void)OnClickButton_1
{
    LDMusicController *ensure = [[LDMusicController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:ensure];
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)OnClickButton_2
{
    LDRadioController *ensure = [[LDRadioController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:ensure];
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)OnClickButton1
{
    AllCircleController *vc = [[AllCircleController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)OnClickButton2
{
    MedicalController *vc = [[MedicalController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)OnClickButton3
{
    XinShuaiController *vc = [[XinShuaiController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)OnClickButton4
{
    MoviePlayerViewController *vc = [[MoviePlayerViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:NULL];
}


- (void)OnClickButton5
{
    LDChatListController *list = [[LDChatListController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:list];
    [self presentViewController:navc animated:YES completion:^{}];
}

- (void)OnClickButton6
{
    LDChooseAreaController *list = [[LDChooseAreaController alloc]init];
    list.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:list animated:YES completion:^{}];
}

// T0201：早教音乐
- (void)OnClickButton7
{
    LDPlayMusicController *vc = [[LDPlayMusicController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:^{}];
}
// T0202：早教故事
- (void)OnClickButton8
{
    LDMorningMusicController*vc = [[LDMorningMusicController alloc]init];
    vc.typeCode = @"T0202";
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:^{}];
}

// T0101：胎教音乐
- (void)OnClickButton9
{
    LDMorningMusicController*vc = [[LDMorningMusicController alloc]init];
    vc.typeCode = @"T0101";
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:^{}];
}

// T0102：胎教故事
- (void)OnClickButton10
{
    LDMorningMusicController*vc = [[LDMorningMusicController alloc]init];
    vc.typeCode = @"T0102";
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:^{}];
}

// T0102：胎教故事
- (void)OnClickButton11
{
    RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
#define SERVICE_ID @"KEFU149932714613051"
    chatService.userName = @"客服";
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    chatService.targetId = SERVICE_ID;
    chatService.title = chatService.userName;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:chatService];
    [self presentViewController:navc animated:YES completion:^{}];
}


- (void)OnClickButton12
{
    UploadInsuranceController *upload = [[UploadInsuranceController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:upload];
    [self presentViewController:navc animated:YES completion:^{}];
}


- (void)OnClickButton13
{
    PresentAnimationController*vc = [[PresentAnimationController alloc]init];
    
     vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    //创建动画
    CATransition * transition = [CATransition animation];
    
    //设置动画类型（这个是字符串，可以搜索一些更好看的类型）
    transition.type = @"Fade";
    
    //动画时间
    transition.duration = 5;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //移除当前window的layer层的动画
    [self.view.window.layer removeAllAnimations];
    
    //将定制好的动画添加到当前控制器window的layer层
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:vc animated:NO completion:^{}];
}

- (void)OnClickButton14
{
    LDShareController *upload = [[LDShareController alloc]init];
    upload.UrlStr = @"https://www.baidu.com";
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:upload];
    [self presentViewController:navc animated:YES completion:^{}];
}


@end

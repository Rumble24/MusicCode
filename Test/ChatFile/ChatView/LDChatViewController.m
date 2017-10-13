//
//  LDChatViewController.m
//  VoiceDemo
//
//  Created by 宜必鑫科技 on 2017/6/5.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDChatViewController.h"
//#import "MessageTool.h"
#import "OtherCenterController.h"
#import <AVFoundation/AVFoundation.h>
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+InitButton.h"
#import "PublicModel.h"
#import "ChooseBackgroundController.h"
#import "SVProgressHUD.h"
#import "WJNetTool.h"
#import "MemberController.h"

@interface LDChatViewController ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation LDChatViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImageView *test = [[UIImageView alloc] initWithFrame:self.conversationMessageCollectionView.bounds];
    [test sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],[[NSUserDefaults standardUserDefaults] objectForKey:@"ChatBackgroundView"]]]];
    [test setContentMode:UIViewContentModeScaleAspectFill];
    test.clipsToBounds = YES;
    self.conversationMessageCollectionView.backgroundView = test;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(OnClickLeftBtn)];
    
    [self loadOldData];
}

- (void)OnClickLeftBtn
{
//    [MessageTool requestUnreadeMessageWithType:@"0"];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)OnClickRightBut
{
    
}

- (void)didTapCellPortrait:(NSString *)userId
{
    NSLog(@"点击了LDChatViewController的头像%@",userId);
    OtherCenterController *vc = [[OtherCenterController alloc]init];
    vc.otherUserId = userId;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadOldData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    dic[@"member_id"] = self.targetId;
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getMemberOnlineStatusURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSDictionary *dic = resuposeObject;
        
        NSString *status = dic[@"data"][@"status"];
        
        // 弹出提示框
        if ([status isEqualToString:@"0"])
        {
            MemberController *vc = [[MemberController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
    }];
}

@end

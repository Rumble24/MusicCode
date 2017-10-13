//
//  ChatWithFriendViewController.m
//  Unity-iPhone
//
//  Created by 宜必鑫科技 on 2017/6/28.
//
//

#import "ChatWithFriendViewController.h"
#import "OtherCenterController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButton+InitButton.h"
#import "ChatFunctionController.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"

#import "UIButton+InitButton.h"
#import "PublicModel.h"
#import "ChooseBackgroundController.h"
#import "SVProgressHUD.h"
#import "WJNetTool.h"
#import "MemberController.h"


@interface ChatWithFriendViewController ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ChatWithFriendViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImageView *test = [[UIImageView alloc] initWithFrame:self.conversationMessageCollectionView.bounds];
    [test sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],[[NSUserDefaults standardUserDefaults] objectForKey:@"ChatBackgroundView"]]]];
    [test setContentMode:UIViewContentModeScaleAspectFill];
    test.clipsToBounds = YES;
    self.conversationMessageCollectionView.backgroundView = test;
}

- (void)didTapCellPortrait:(NSString *)userId
{
    NSLog(@"点击了ChatWithFriendViewController的头像%@",userId);
    OtherCenterController *vc = [[OtherCenterController alloc]init];
    vc.otherUserId = userId;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 42, 42) target:self action:@selector(OnClickRightBut)];
    [button setImage:[UIImage imageNamed:@"ChatChooseBack.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self loadOldData];
}

- (void)OnClickRightBut
{
    ChatFunctionController *vc = [[ChatFunctionController alloc]init];
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
        
        NSLog(@"-----%@-----",dic);
        
        NSString *status = dic[@"data"][@"status"];
        
        // 弹出提示框
        if ([status isEqualToString:@"0"])
        {
            MemberController *vc = [[MemberController alloc]init];
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:vc animated:NO completion:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"-----%@-----",error);
    }];
}

@end

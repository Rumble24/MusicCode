//
//  LDChatWithMemberController.m
//  Unity-iPhone
//
//  Created by 宜必鑫科技 on 2017/6/6.
//
//

#import "LDChatWithMemberController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//#import "MessageTool.h"
#import "OtherCenterController.h"
#import <AVFoundation/AVFoundation.h>
#import "PublicModel.h"

@interface LDChatWithMemberController ()<RCChatSessionInputBarControlDelegate>
@property (nonatomic, assign) long mMessageId;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
// 1. 不是历史记录  2.是历史记录
@property (nonatomic, assign) NSInteger type;
@end

@implementation LDChatWithMemberController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.type = 1;
        
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setImage:[UIImage imageNamed:@"icon_back_write.png"] forState:UIControlStateNormal];
    backBut.frame = CGRectMake(10, 20, 44, 44);
    [backBut addTarget:self action:@selector(OnClickLeftBtn) forControlEvents:1<<6];
    [self.view addSubview:backBut];
    
    UIButton *lishiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    lishiBut.frame = CGRectMake((WIDTH - 44- 20), 25, 44, 44);
    [lishiBut setImage:[UIImage imageNamed:@"BaByHistory.png"] forState:UIControlStateNormal];
    [lishiBut addTarget:self action:@selector(OnClickLishi:) forControlEvents:1<<6];
    [self.view addSubview:lishiBut];
    
    self.chatSessionInputBarControl.emojiBoardView.backgroundColor = [UIColor whiteColor];
    self.chatSessionInputBarControl.delegate = self;
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(132/2, 200/2, 486/2, 210/2)];
    self.imageView.image = [UIImage imageNamed:@"BaByMessageBack.png"];
    [self.view addSubview:self.imageView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 486/2 - 40, 122/2)];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.numberOfLines = 0;
    
    self.label.textColor = [UIColor colorWithRed:1.0 green:151.0/255.0 blue:183.0/255.0 alpha:1];
    [self.imageView addSubview:self.label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([PublicModel isBlankString:self.rolename])
    {
        self.imageView.hidden = YES;
    }
    else
    {
        self.label.text = [NSString stringWithFormat:@"快点和%@聊天吧",self.rolename];
        self.imageView.hidden = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
//    [MessageTool requestUnreadeMessageWithType:@"0"];
//    
//    [MessageTool SendMessageToUnityWithRecieverName:self.mUnityRecieverName mFunctionName:self.mUnityRecieverFunctionName mOperationId:self.mOperationId mResult:@"0" mData:@"0"];
}

- (void)OnClickLishi:(UIButton *)but
{
    if (but.isSelected)
    {
        self.type = 1;
        [UIView animateWithDuration:0.2f animations:^{
            self.conversationMessageCollectionView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50);
        }];
    }
    else
    {
        self.type = 2;
        [UIView animateWithDuration:0.2f animations:^{
            self.conversationMessageCollectionView.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 350);
        }];
        // 滑动到最下面
        [self.conversationMessageCollectionView setContentOffset:CGPointMake(0, self.conversationMessageCollectionView.contentSize.height - self.conversationMessageCollectionView.frame.size.height) animated:YES];
    }
    but.selected = !but.isSelected;
}

- (RCMessage *)willAppendAndDisplayMessage:(RCMessage *)message
{
    if ([message.objectName isEqualToString:@"RC:TxtMsg"]) {
        
        if(self.imageView.isHidden)
        {
            self.imageView.hidden = NO;
        }
        
        self.label.textAlignment = NSTextAlignmentLeft;
        
        RCTextMessage *mTextmessage = (RCTextMessage*)message.content;
        
        if ([message.senderUserId isEqualToString:[PublicModel getUserid]])
        {
            self.label.text = [NSString stringWithFormat:@"我:%@",mTextmessage.content];
        }
        else
        {
            self.label.text = [NSString stringWithFormat:@"%@:%@",self.rolename,mTextmessage.content];
        }
        
        
    }else if ([message.objectName isEqualToString:@"RC:VcMsg"]) {
        if (![message.senderUserId isEqualToString:[PublicModel getUserid]])
        {
//            [MessageTool SendMessageToUnityWithRecieverName:@"Canvas" mFunctionName:@"ReceiveMemberVoidFromMobile" mOperationId:@"mReceiveMemberVoidId" mResult:@"0" mData:@"00"];
//            NSLog(@"我向Unity发送了语音消息");
            // 自动播放
            RCVoiceMessage *vc = (RCVoiceMessage*)message.content;
            NSError *error;
            AVAudioPlayer *avAudioPlayer = [[AVAudioPlayer alloc] initWithData:vc.wavAudioData error:&error];
            self.player = avAudioPlayer;
            [self.player prepareToPlay];
            [self.player play];
        }
        
    }
    return message;
}



- (void)didTapCellPortrait:(NSString *)userId
{
    NSLog(@"点击了LDChatWithMemberController.h的头像%@",userId);
    OtherCenterController *vc = [[OtherCenterController alloc]init];
    vc.otherUserId = userId;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)chatInputBar:(RCChatSessionInputBarControl *)chatInputBar shouldChangeFrame:(CGRect)frame
{
    if (self.type == 1) {
        self.conversationMessageCollectionView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50);
    }
}
//- (void)presentViewController:(UIViewController *)viewController functionTag:(NSInteger)functionTag
//{
//}

@end

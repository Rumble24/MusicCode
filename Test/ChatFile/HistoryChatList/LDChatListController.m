//
//  LDChatListController.m
//  VoiceDemo
//
//  Created by 宜必鑫科技 on 2017/6/2.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDChatListController.h"
#import "UIImageView+WebCache.h"
#import "LDHttpTool.h"
#import "RCDUserInfoManager.h"
//#import "MessageTool.h"
#import "ChatWithFriendViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface LDChatListController ()
@property(nonatomic, assign) BOOL isClick;
@end

@implementation LDChatListController


- (id)init {
    self = [super init];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(OnClickLeftBtn)];
    
    self.title = @"消息通知";
    
    self.conversationListTableView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:244.0/255.0 blue:248.0/255.0 alpha:1.0];
    
    // 设置在NavigatorBar中显示连接中的提示
    self.showConnectingStatusOnNavigatorBar = YES;
    
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    UIView *view =[[UIView alloc]initWithFrame:self.view.frame];
//    view.backgroundColor = [UIColor redColor];
//    self.emptyConversationView = view;
}

- (void)OnClickLeftBtn
{
//    [MessageTool requestUnreadeMessageWithType:@"0"];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

/**
 *  点击进入会话页面
 */
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    ChatWithFriendViewController *chat = [[ChatWithFriendViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:model.targetId];
    chat.title = model.conversationTitle;
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    [cell.contentView addSubview:view];
}
@end

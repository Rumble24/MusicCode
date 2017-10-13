//
//  ChatWithFriendViewController.h
//  Unity-iPhone
//
//  Created by 宜必鑫科技 on 2017/6/28.
//
//

#import <RongIMKit/RongIMKit.h>

@interface ChatWithFriendViewController : RCConversationViewController

// 类型判断：哪个页面条转过来的 1.聊天页面  2.他人空间 他人空间只可以显示加为好友
@property (nonatomic, assign) NSInteger type;
@end

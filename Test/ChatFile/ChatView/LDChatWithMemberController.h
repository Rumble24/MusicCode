//
//  LDChatWithMemberController.h
//  Unity-iPhone
//
//  Created by 宜必鑫科技 on 2017/6/6.
//
//

#import <RongIMKit/RongIMKit.h>

@interface LDChatWithMemberController : RCConversationViewController
// Unity 需要的参数
@property (nonatomic,copy) NSString *mUnityRecieverName;
@property (nonatomic,copy) NSString *mUnityRecieverFunctionName;
@property (nonatomic,copy) NSString *mOperationId;
@property (nonatomic,copy) NSString *rolename;
@end

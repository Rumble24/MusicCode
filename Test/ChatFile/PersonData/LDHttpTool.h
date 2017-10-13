//
//  LDHttpTool.h
//  VoiceDemo
//
//  Created by 宜必鑫科技 on 2017/6/2.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

@interface LDHttpTool : NSObject
+ (LDHttpTool *)shareInstance;
- (void)getFriendDetailsWithFriendId:(NSString *)friendId
                             success:(void (^)(RCUserInfo *user))success
                             failure:(void (^)(NSError *err))failure;
@end

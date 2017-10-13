//
//  RCDUserInfoManager.h
//  RCloudMessage
//
//  Created by Jue on 16/8/19.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

@interface RCDUserInfoManager : NSObject

+ (RCDUserInfoManager *)shareInstance;

//通过好友Id获取好友的用户信息
- (void)getFriendInfo:(NSString *)friendId completion:(void (^)(RCUserInfo *))completion;

@end

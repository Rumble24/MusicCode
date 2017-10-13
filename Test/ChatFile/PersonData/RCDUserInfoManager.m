//
//  RCDUserInfoManager.m
//  RCloudMessage
//
//  Created by Jue on 16/8/19.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import "RCDUserInfoManager.h"
#import "WJNetTool.h"
#import "PublicModel.h"
#import "LDHttpTool.h"

@implementation RCDUserInfoManager

+ (RCDUserInfoManager *)shareInstance
{
  static RCDUserInfoManager *instance = nil;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    instance = [[[self class] alloc] init];
  });
  return instance;
}
//通过好友详细信息或好友Id获取好友信息
-(void)getFriendInfo:(NSString *)friendId completion:(void (^)(RCUserInfo *))completion
{
    [[LDHttpTool shareInstance]getFriendDetailsWithFriendId:friendId success:^(RCUserInfo *user) {
        completion(user);
        
    } failure:^(NSError *err) {}];

}

@end

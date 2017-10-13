//
//  LDHttpTool.m
//  VoiceDemo
//
//  Created by 宜必鑫科技 on 2017/6/2.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDHttpTool.h"
#import "WJNetTool.h"
#import "PublicModel.h"

@implementation LDHttpTool

+ (LDHttpTool *)shareInstance {
    static LDHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)getFriendDetailsWithFriendId:(NSString *)friendId
                             success:(void (^)(RCUserInfo *user))success
                             failure:(void (^)(NSError *err))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = @"385fbc24-8ffb-4f54-9f4b-280d671538a7";
    dic[@"friend_id"] = friendId;
    
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    
    [WJNetTool POST:[PublicModel getFriendSimpleDetailURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(NSDictionary *resuposeObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

        NSLog(@"获取好友信息成功！%@    %@",friendId,(NSDictionary*)resuposeObject);
        
        
        NSDictionary *dic = resuposeObject[@"data"];
        NSDictionary *infoDic = dic[@"user"];
            
            if (![infoDic isKindOfClass:[NSNull class]])
            {
                RCUserInfo *user = [RCUserInfo new];
                user.userId = infoDic[@"userid"];
                user.name = [infoDic objectForKey:@"nickname"];
                user.portraitUri = [infoDic objectForKey:@"imgurl"];
                success(user);
            }
            else
            {
                NSError *error;
                failure(error);
            }

        });
        
        
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];

}
@end

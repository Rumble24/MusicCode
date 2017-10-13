//
//  AppDelegate.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "AppDelegate.h"
#import "RCDUserInfoManager.h"
#import "ViewController.h"
#import "PublicModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

#define RYTOKEN @"21WyoLspyEa8yARsft82pLpghISFisNamjWOpqauC1gfxoJjE4fFnVkjIR3g5g2CkIP8iNVZqylmoa6qVTtoifjzLewi/kMMpR2vOgjLFTYRXUlSP9ykRYNDlFLlQo47eKT/coL6rYM="

#define CODERYTOKEN @"zDT6wQxFPNZq0UpsfkWO19o5Jd5iTse8RE1RbR8B1HOk+RmNxPxgvzLM7atU80z2hNMcpjPCgGtAOfP3M9OSPS3jIELeQhv+gAJHR0LdTx7hmYDoGIjHCx2lw6MmZxKxJq/tsB1FtYs="

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface AppDelegate ()

@property (nonatomic, strong) id playerTimeObserver;

@property (nonatomic, strong) NSString *userid;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskId;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [PublicModel setUserid:@"1CCAE4F5B9074E6192303CD73424BB32"];
    [PublicModel setToken:@"88CBBDF1-F688-4068-AC95-D34951D84FBD"];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navc;
    [self.window makeKeyAndVisible];
    
    [self _registerShare];
    
    //统一导航条样式
    UIFont *font = [UIFont systemFontOfSize:19.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    // 按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0]];
    
    
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:@"z3v5yqkbz6qp0"];
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    
    //设置群组内用户信息源。如果不使用群名片功能，可以不设置
    //  [RCIM sharedRCIM].groupUserInfoDataSource = RCDDataSource;
    //  [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    // 链接连接服务器
    [[RCIM sharedRCIM] connectWithToken:CODERYTOKEN  success:^(NSString *userId) {
        
        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:userId name:@"CC" portrait:@"http://libtest.ldxxw.com.cn:8088/upload/mini/1496372117453.JPG"];
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
        [RCIM sharedRCIM].currentUserInfo = user;
        NSLog(@"登录成功~");
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];

#pragma mark - 1.红包的第一步
    //设置红包扩展的Url Scheme。
    [[RCIM sharedRCIM] setScheme:@"EnsureRedPacket" forExtensionModule:@"JrmfPacketManager"];

    return YES;
}

#pragma mark - 1.红包的第二步
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // 未读消息数
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE),
                                                                             @(ConversationType_DISCUSSION),
                                                                             @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE),
                                                                             @(ConversationType_GROUP)
                                                                             ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:
                              @"您的帐号在别的设备上登录，"
                              @"您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    if (![message.senderUserId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        [[RCDUserInfoManager shareInstance] getFriendInfo:message.senderUserId
                                               completion:^(RCUserInfo *user) {
                                                   RCUserInfo *user123 = [[RCUserInfo alloc] initWithUserId:user.userId name:user.name portrait:[NSString stringWithFormat:@"http://libtest.ldxxw.com.cn:8088/upload/mini/%@",user.portraitUri]];
                                                   [[RCIM sharedRCIM] refreshUserInfoCache:user123 withUserId:user.userId];
                                               }];
    }
}
// 获取用户的信息
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    NSLog(@"-------------------APP获取用户的信息-------------------%@", userId);
    RCUserInfo *user = [RCUserInfo new];
    if (userId == nil || [userId length] == 0) {
        user.userId = userId;
        user.portraitUri = @"";
        user.name = @"";
        completion(user);
        return;
    }
    //开发者调自己的服务器接口根据userID异步请求数据
    if (![userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        [[RCDUserInfoManager shareInstance] getFriendInfo:userId
                                               completion:^(RCUserInfo *user) {
                                                   completion(user);
                                               }];
    } else {
        completion([RCIM sharedRCIM].currentUserInfo);
    }
    return;
}
NSString *const shareSDKAppKey = @"1d87884fcf3c4";
NSString *const qqSDKAppID = @"1106138142";
NSString *const qqSDKAppKey = @"mTW5Crcb30XqsjvZ";
NSString *const wxSDKAppID = @"wxbd1508ec20692d7e";
NSString *const wxSDKAppSecret = @"6fcbce95784e8d69d33043f50cd557d9";
NSString *const wbSDKAppID = @"2391224122";
NSString *const wbSDKAppKey = @"5a5727348f5816680ce89991f6c8e9a5";
//shareSDK 注册方法
- (void)_registerShare
{
    //平台注册并且初始化第三方平台
    NSArray *platforems = @[
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeYouTube),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeSinaWeibo)
                            ];
    [ShareSDK registerApp:shareSDKAppKey
          activePlatforms:platforems
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:nil];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:qqSDKAppID
                                           appKey:qqSDKAppKey
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:wxSDKAppID
                                            appSecret:wxSDKAppSecret];
                      break;
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:wbSDKAppID
                                                appSecret:wbSDKAppKey
                                              redirectUri:@"http://www.baidu.com"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
}
@end

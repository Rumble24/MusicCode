//
//  LDShareController.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/9/19.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDShareController.h"
#import <WebKit/WebKit.h>
#import "UIButton+InitButton.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface LDShareController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation LDShareController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(onClickShare)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)setUrlStr:(NSString *)UrlStr
{
    _UrlStr = UrlStr;
    // 设置访问的URL
    NSURL *url = [NSURL URLWithString:UrlStr];
    // 根据URL创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // WKWebView加载请求
    [self.webView loadRequest:request];
}


- (WKWebView *)webView
{
    if (!_webView)
    {
        // 创建WKWebView
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // 将WKWebView添加到视图
        [self.view addSubview:_webView];
        
    }
    return _webView;
}

- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)onClickShare
{
    //1、创建分享参数
    NSArray* imageArray = @[@"http://mob.com/Assets/images/logo.png?v=20150320"];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}












@end

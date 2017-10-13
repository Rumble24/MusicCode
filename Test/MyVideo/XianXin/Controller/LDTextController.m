//
//  LDTextController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDTextController.h"
#import <WebKit/WebKit.h>

@interface LDTextController ()
@property (nonatomic, strong) WKWebView *webView ;

@end

@implementation LDTextController

- (void)setModel:(LDEpertsModel *)model
{
    _model = model;
    self.title = model.title;
    // 设置访问的URL
    NSURL *url = [NSURL URLWithString:model.url];
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





@end

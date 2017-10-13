//
//  PLController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/27.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PLController.h"
#import "WJTextView.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PLController ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) WJTextView *textView;
@end

@implementation PLController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self CreateView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)CreateView
{
    self.title = @"评论";
    
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(PingLun)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 69, WIDTH - 30, 50)];
    self.nameLabel.textColor = [PublicModel colorWithHexString:@"#648398"];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.backgroundColor = [UIColor whiteColor];
    self.nameLabel.text = [NSString stringWithFormat:@"回复:%@",self.name];
    [self.view addSubview:self.nameLabel];
    
    self.textView = [[WJTextView alloc]initWithFrame:CGRectMake(15, 69 + 52, WIDTH - 30, HEIGHT - 69 - 60)];
    [self.view addSubview:self.textView];
    _textView.placeholderColor = [PublicModel colorWithHexString:@"#B2BEC4"];
    _textView.placeholder = @"内容";
}

- (void)PingLun
{
    if([PublicModel isBlankString:[PublicModel getUserid]] || [PublicModel isBlankString:[PublicModel getToken]])
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = [PublicModel getUserid];
    dic[@"token"] = [PublicModel getToken];
    dic[@"post_id"] = self.tieZiId;
    dic[@"content"] = self.textView.text;
    dic[@"to_member_id"] = self.toMemberID;
    if (self.type == 2)
    {
        dic[@"reply_id"] = self.reply_id;
        dic[@"parent_id"] = self.parent_id;
    }
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    
    [WJNetTool POST:[PublicModel getAddPostReplyURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
//        NSLog(@"评论成功~");
        if(self.PLSuccess)
        {
            self.PLSuccess();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
//        NSLog(@"评论失败=%@",error.domain);
    }];
}
















@end

//
//  MyMessageController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyMessageController.h"
#import "PublicModel.h"
#import "UIButton+InitButton.h"
#import "MyPlController.h"
#import "MyDzController.h"
#import "WJNetTool.h"
#import "UnreadeModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MyMessageController ()
@property (nonatomic, strong) UIView *plView;
@property (nonatomic, strong) UIView *dzView;
@property (nonatomic, strong) UILabel *plLabel;
@property (nonatomic, strong) UILabel *dzLabel;
@property (nonatomic, strong) UIImageView *plUnredImage;
@property (nonatomic, strong) UIImageView *dzUnredImage;
@end

@implementation MyMessageController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self CreateView];
}

- (void)CreateView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.title = @"消息";
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.plView = [[UIView alloc]initWithFrame:CGRectMake(0, 15 + 64, WIDTH, 44)];
    self.plView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.plView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.plView.userInteractionEnabled = YES;
    [self.plView addGestureRecognizer:tap];
    UIImageView *plImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 15, 14)];
    plImage.image = [UIImage imageNamed:@"plicon.png"];
    [self.plView addSubview:plImage];
    UILabel *mPlLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, 100, 14)];
    mPlLabel.text = @"评论";
    [self.plView addSubview:mPlLabel];
    UIImageView *jtImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 21, 15, 6, 14)];
    jtImage.image = [UIImage imageNamed:@"Arrow.png"];
    [self.plView addSubview:jtImage];
    
    
    self.plUnredImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 51, 12, 20, 20)];
    self.plUnredImage.layer.cornerRadius = 10;
    self.plUnredImage.layer.masksToBounds =YES;
    self.plUnredImage.backgroundColor = [PublicModel colorWithHexString:@"#ff3c6a"];
    [self.plView addSubview:self.plUnredImage];
    
    self.plLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 51, 12, 20, 20)];
    self.plLabel .text = @"0";
    self.plLabel.font = [UIFont systemFontOfSize:15];
    self.plLabel.textColor  = [UIColor whiteColor];
    self.plLabel.textAlignment = NSTextAlignmentCenter;
    [self.plView addSubview:self.plLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WIDTH, 1)];
    lineView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.plView addSubview:lineView];
    
    self.dzView = [[UIView alloc]initWithFrame:CGRectMake(0, 59 + 64, WIDTH, 44)];
    self.dzView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dzView];
    UITapGestureRecognizer *dztap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dzTapAction:)];
    self.dzView.userInteractionEnabled = YES;
    [self.dzView addGestureRecognizer:dztap];
    UIImageView *dzImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 15, 14)];
    dzImage.image = [UIImage imageNamed:@"dadezanicon.png"];
    [self.dzView addSubview:dzImage];
    UILabel *mDzLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, 100, 14)];
    mDzLabel.text = @"点赞";
    [self.dzView addSubview:mDzLabel];
    UIImageView *jTImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 21, 15, 6, 14)];
    jTImage.image = [UIImage imageNamed:@"Arrow.png"];
    [self.dzView addSubview:jTImage];
    
    self.dzUnredImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 51, 12, 20, 20)];
    self.dzUnredImage.layer.cornerRadius = 10;
    self.dzUnredImage.layer.masksToBounds =YES;
    self.dzUnredImage.backgroundColor = [PublicModel colorWithHexString:@"#ff3c6a"];
    [self.dzView addSubview:self.dzUnredImage];
    
    self.dzLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 51, 12, 20, 20)];
    self.dzLabel.text = @"0";
    self.dzLabel.font = [UIFont systemFontOfSize:15];
    self.dzLabel.textColor  = [UIColor whiteColor];
    self.dzLabel.textAlignment = NSTextAlignmentCenter;
    [self.dzView addSubview:self.dzLabel];
    
}

- (void)OnClickLeftBtn
{
   [self.navigationController popViewControllerAnimated:YES];
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    MyPlController *vc = [[MyPlController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)dzTapAction:(UITapGestureRecognizer *)tap
{
    MyDzController *vc = [[MyDzController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)loadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getUnReadCountURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSDictionary *dic = resuposeObject;
        NSArray *array = dic[@"data"][@"list"];
        for (NSDictionary *dic in array)
        {
            //1:评论，2:点赞
            UnreadeModel *model = [[UnreadeModel alloc]initWithDic:dic];
            if (model.type == 1)
            {
                self.plLabel.text = [NSString stringWithFormat:@"%ld",model.count];
                NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                CGRect rect = [self.plLabel.text boundingRectWithSize:CGSizeMake(10000, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                self.plLabel.frame = CGRectMake(WIDTH - 31 - 20 - rect.size.width, 15, rect.size.width + 20, 14);
                self.plUnredImage.frame = CGRectMake(WIDTH - 31 - 20 - rect.size.width, 12, rect.size.width + 20, 20);
            }
            else if(model.type == 2)
            {
                self.dzLabel.text = [NSString stringWithFormat:@"%ld",model.count];
                NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                CGRect rect = [self.dzLabel.text boundingRectWithSize:CGSizeMake(10000, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                self.dzLabel.frame = CGRectMake(WIDTH - 31 - 20 - rect.size.width, 15, rect.size.width + 20, 14);
                self.dzUnredImage.frame = CGRectMake(WIDTH - 31 - 20 - rect.size.width, 12, rect.size.width + 20, 20);
            }

        }
        
    } failure:^(NSError *error) {

    }];
}


@end

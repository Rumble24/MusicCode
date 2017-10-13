//
//  EnsureRadioController.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/17.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDMusicController.h"
#import "UIButton+InitButton.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "LDPlayMusicModel.h"
#import "MJRefresh.h"
#import "LDMusicViewCell.h"
#import "LDPlayer.h"
#import "BackGroundView.h"
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface LDMusicController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIButton *closeBut;
@property (nonatomic, assign) BOOL isStretchedOut;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, strong) BackGroundView *backGroundView;

@end

@implementation LDMusicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createData];
    [self createView];
}

- (void)createView
{
    self.array = [NSMutableArray array];
    
    self.isDown = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"恩秀儿电台";

    UIButton *leftBtn = [UIButton buttonWithTitle:@"" frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithTitle:@"" frame:CGRectMake(0, 0, 17, 17) target:self action:@selector(OnClickRightBtn)];
    [rightBtn setImage:[UIImage imageNamed:@"VideoList.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    __block __typeof(self) weakSelf = self;
    _backGroundView = [[BackGroundView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _backGroundView.NeedReloadData = ^{
        [weakSelf.listTableView reloadData];
    };
    [self.view addSubview:_backGroundView];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 410 * hScale)];
    _backView.backgroundColor = RGBA(41, 40, 36, 0.7f);
    [self.view addSubview:_backView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, ScreenWidth, 1)];
    lineView.backgroundColor = RGBA(138, 167, 160, 0.5f);
    [_backView addSubview:lineView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 24, 24)];
    headerImage.image = [UIImage imageNamed:@"VideoListHeader.png"];
    headerImage.alpha = 0.6f;
    [headerView addSubview:headerImage];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(54, 0, ScreenWidth - 54, 50)];
    label.textColor = RGBA(145, 224, 204, 0.6f);
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"恩秀儿电台";
    [headerView addSubview:label];
    [_backView addSubview:headerView];
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 410 * hScale - 50) style:UITableViewStylePlain];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.listTableView registerClass:[LDMusicViewCell class] forCellReuseIdentifier:@"listTableViewCell"];
    [_backView addSubview:self.listTableView];
    
    _closeBut = [UIButton buttonWithTitle:@"关闭" frame:CGRectMake(0, 410 * hScale - 50, ScreenWidth, 50) target:self action:@selector(OnClickRightBtn)];
    _closeBut.titleLabel.font = [UIFont systemFontOfSize:20];
    [_closeBut setTitleColor:[PublicModel colorWithHexString:@"#91E0CC"] forState:UIControlStateNormal];
    _closeBut.backgroundColor = RGBA(18,23, 22, 0.9f);
//    _closeBut.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_closeBut];
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isDown = YES;
        [self createData];
    }];
    
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        [self createData];
    }];
}


- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backGroundView.centerImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.backGroundView.centerImage.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.backGroundView.centerImage.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backGroundView.centerImage.layer.mask = maskLayer;
}

- (void)OnClickRightBtn
{
    if (self.isStretchedOut == false)
    {
        [UIView animateWithDuration:0.2f animations:^{
            _backView.frame = CGRectMake(0, ScreenHeight - 410 * hScale, ScreenWidth, 410 * hScale);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2f animations:^{
            _backView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 410 * hScale);
        }];
    }
    self.isStretchedOut = !self.isStretchedOut;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.isStretchedOut)
    {
        [UIView animateWithDuration:0.2f animations:^{
            _backView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 410 * hScale);
        }];
        self.isStretchedOut = !self.isStretchedOut;
    }
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDMusicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTableViewCell"];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90 * hScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDPlayMusicModel *model = self.array[indexPath.row];
    [[LDPlayer sharePlayer]play:model];
    self.backGroundView.model = model;
    [self.listTableView reloadData];
}


- (void)createData
{
    if (self.isDown) {
        self.pageId = 1;
    } else {
        self.pageId++;
    }
    // 0:文章下评论，1:评论下子评论 post_id
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"now_page"] = @(self.pageId);
    dic[@"page_size"] = @(20);
    dic[@"type_code"] = @"T0101";
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getFetalRecordListURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
                
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {
            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
                [self.array addObject:model];
            }
            
            [self.listTableView reloadData];
            
            if(self.backGroundView.model == nil)
                self.backGroundView.model = self.array[0];
            
            // 结束刷新
            [self.listTableView.mj_header endRefreshing];
        }
        else
        {
            for (NSDictionary *dic in array)
            {
                LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
                [self.array addObject:model];
            }
            
            [self.listTableView reloadData];
            // 结束刷新
            [self.listTableView.mj_footer endRefreshing];
        }
        
        [LDPlayer sharePlayer].modelArray = self.array;
        
        
    } failure:^(NSError *error) {
        // 结束刷新
        [self.listTableView.mj_header endRefreshing];
        [self.listTableView.mj_footer endRefreshing];
    }];
}

@end

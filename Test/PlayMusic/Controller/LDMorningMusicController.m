//
//  LDMorningMusicController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "LDMorningMusicController.h"
#import "MJRefresh.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "MJExtension.h"

#import "LDPlayMusicModel.h"
#import "LDPlayMusicCell.h"

#import "UIButton+InitButton.h"

#import "LDPlayer.h"

#import "PublicModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <notify.h>
#import "LDPlayer.h"
#import "UIImageView+WebCache.h"

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface LDMorningMusicController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, assign) NSInteger pageId;
@end

@implementation LDMorningMusicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createCiew];
    
    [self CreateTableView];
    
    [self createData];
}

- (void)createCiew
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Code说明  T0101：胎教音乐    T0102：胎教故事  T0201：早教音乐   T0202：早教故事
    if ([self.typeCode isEqualToString:@"T0101"]) {
        self.title = @"胎教音乐";
    }else if([self.typeCode isEqualToString:@"T0102"]){
        self.title = @"胎教故事 ";
    }else if([self.typeCode isEqualToString:@"T0202"]){
        self.title = @"早教故事";
    }
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)CreateTableView
{
    self.array = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LDPlayMusicCell class] forCellReuseIdentifier:@"LDPlayMusicCellId"];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isDown = YES;
        [self createData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        [self createData];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDPlayMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDPlayMusicCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.array[indexPath.row];
    cell.NeedReloadData = ^{
        [LDPlayer sharePlayer].modelArray = self.array;
        [self.tableView reloadData];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  110 * kScale;
}

- (BOOL)shouldAutorotate {
    return NO;
}


// Code说明  T0101：胎教音乐    T0102：胎教故事  T0201：早教音乐   T0202：早教故事
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
    dic[@"type_code"] = self.typeCode;
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getFetalRecordListURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
//        NSLog(@"请求音乐的数据成功=%@",(NSDictionary*)resuposeObject);
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {
            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            for (NSDictionary *dic in array)
            {
                LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end


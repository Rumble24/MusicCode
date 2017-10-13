//
//  LDPlayMusicTableController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDPlayMusicTableController.h"
#import "MJRefresh.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "MJExtension.h"

#import "LDPlayMusicModel.h"
#import "LDPlayMusicCell.h"
#import "LDPlayer.h"

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface LDPlayMusicTableController ()
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, assign) NSInteger pageId;
@end

@implementation LDPlayMusicTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LDPlayMusicCell class] forCellReuseIdentifier:@"LDPlayMusicCellId"];
    
    [self createData];
    
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


// 返回值要必须为NO
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
@end

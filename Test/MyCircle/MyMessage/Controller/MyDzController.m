//
//  MyDzController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyDzController.h"
#import "PublicModel.h"
#import "UIButton+InitButton.h"

#import "MyPlController.h"
#import "PublicModel.h"
#import "UIButton+InitButton.h"
#import "MJRefresh.h"

#import "MyDzCell.h"
#import "MyDzModel.h"

#import "WJNetTool.h"

#import "ContentController.h"

#import "SVProgressHUD.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MyDzController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger pageId;
@end

@implementation MyDzController

static NSString *const MyDzTableViewCell = @"MyDzTableViewCell";

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];
    
    [self Config];
    
    [self createView];
}

- (void)Config
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.title = @"点赞";
    self.array = [NSMutableArray array];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)OnClickLeftBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyDzCell class] forCellReuseIdentifier:MyDzTableViewCell];
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
    MyDzCell *cell = [tableView dequeueReusableCellWithIdentifier:MyDzTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyDzModel *model = self.array[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDzModel *model = self.array[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDzModel *model = self.array[indexPath.row];
    ContentController *vc = [[ContentController alloc]init];
    vc.tieZiId = model.post_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createData
{
    if (self.isDown) {
        self.pageId = 1;
    } else {
        self.pageId++;
    }
    // 1:评论消息，2:点赞消息
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    dic[@"now_page"] = @(self.pageId);
    dic[@"page_size"] = @(20);
    dic[@"type"] = @(2);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getMyCommunityMessageURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
//        NSLog(@"我的点赞列表成功=%@",(NSDictionary*)resuposeObject);
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {
            
            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                MyDzModel *model = [[MyDzModel alloc]initWithDic:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            if (array.count == 0)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            for (NSDictionary *dic in array) {
                MyDzModel *model = [[MyDzModel alloc]initWithDic:dic];
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

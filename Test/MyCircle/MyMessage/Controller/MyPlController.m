//
//  MyPlController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyPlController.h"
#import "PublicModel.h"
#import "UIButton+InitButton.h"
#import "MJRefresh.h"
#import "PLController.h"

#import "MyPlCell.h"
#import "MyPlModel.h"

#import "WJNetTool.h"

#import "ContentController.h"

#import "SVProgressHUD.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MyPlController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger pageId;
@end

@implementation MyPlController
static NSString *const MyPlTableViewCell = @"MyPlTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];
    
    [self Config];
    
    [self createView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)Config
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.title = @"评论";
    
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
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MyPlCell class] forCellReuseIdentifier:MyPlTableViewCell];
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
    MyPlCell *cell = [tableView dequeueReusableCellWithIdentifier:MyPlTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyPlModel *model = self.array[indexPath.row];
    cell.model = model;
    __block __typeof(self) weakSelf = self;
    cell.OnClickComment = ^(MyPlModel *model)
    {
        PLController *vc = [[PLController alloc]init];
        vc.tieZiId = model.post_id; // 那条帖子的ID；
        vc.toMemberID = model.member_id; // 那条评论发布者的的memberid == member_id
        vc.reply_id = model.reply_id;  // 那条评论的ID == id
        vc.parent_id = model.parent_id;
        vc.name = model.member_name;
        vc.type = 2;
        vc.PLSuccess = ^()
        {
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPlModel *model = self.array[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPlModel *model = self.array[indexPath.row];
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
    dic[@"type"] = @(1);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getMyCommunityMessageURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
//        NSLog(@"我的评论列表成功=%@",(NSDictionary*)resuposeObject);
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {
            
            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                MyPlModel *model = [[MyPlModel alloc]initWithDic:dic];
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
                MyPlModel *model = [[MyPlModel alloc]initWithDic:dic];
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

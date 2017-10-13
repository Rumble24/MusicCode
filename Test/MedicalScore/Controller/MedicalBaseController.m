//
//  MedicalBaseController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MedicalBaseController.h"
#import "MJRefresh.h"
#import "WJNetTool.h"
#import "PublicModel.h"
#import "SVProgressHUD.h"


#import "MedicalModel.h"
#import "MidecalCell.h"

#import "MedicalContentController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MedicalBaseController ()
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation MedicalBaseController

static NSString *const mMidecalCell = @"MidecalCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addMessage];
    
    [self createView];
}

- (void)createView
{
    self.array = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MidecalCell class] forCellReuseIdentifier:mMidecalCell];
    [self setupRefresh];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MidecalCell *cell = [tableView dequeueReusableCellWithIdentifier:mMidecalCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalContentController *vc = [[MedicalContentController alloc]init];
    vc.model = self.array[indexPath.row];
    vc.OnClickImage = ^()
    {
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



//添加刷新控件
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //根据下拉的距离提示符自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载以前的数据
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}



- (void)loadNewData
{
    _pageIndex = 1;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    
    dic[@"type"] = self.type;
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getMedicalRecordListURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSDictionary *dic = resuposeObject;
//        NSLog(@"请求成功=%@",(NSDictionary*)resuposeObject);
        
        NSArray *array = dic[@"data"][@"list"];
        
        [self.array removeAllObjects];
        
        for (NSDictionary *dic in array) {
            MedicalModel *model = [[MedicalModel alloc]initWithDic:dic];
            [self.array addObject:model];
        }
                
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    
    self.pageIndex++;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    dic[@"type"] = self.type;
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getMedicalRecordListURL]   body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        if(![resuposeObject isKindOfClass:[NSDictionary class]])
        {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        NSDictionary *dic = resuposeObject;
        
        if (![dic[@"status"] isEqualToString:@"0"])
        {
//            NSLog(@"%@",resuposeObject);
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        
        if(![resuposeObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.mj_header.hidden = YES;
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
//        NSLog(@"请求成功=%@",(NSDictionary*)resuposeObject);
        
        NSArray *array = dic[@"data"][@"list"];
        if (array.count == 0)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        for (NSDictionary *dic in array) {
            MedicalModel *model = [[MedicalModel alloc]initWithDic:dic];
            [self.array addObject:model];
        }
        
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        // 显示加载失败的信息
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)addMessage
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificiation:) name:@"UpdateMedicalRecord" object:NULL];
}
- (void)receiveNotificiation:(NSNotification*)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing];
    });
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateMedicalRecord" object:NULL];
}
@end

//
//  WJTableViewController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJTableViewController.h"
#import "WJTableViewCell.h"
#import "MJRefresh.h"
#import "WJNetTool.h"
#import "GetPostModel.h"
#import "PublicModel.h"
#import "ContentController.h"
#import "OtherCenterController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WJTableViewController ()
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation WJTableViewController
static NSString *const UPCell = @"TBCell";

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
    [self.tableView registerClass:[WJTableViewCell class] forCellReuseIdentifier:UPCell];
    [self setupRefresh];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UPCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.array[indexPath.row];
    __block __typeof(self) weakSelf = self;
    cell.OnClickComment = ^()
    {
        GetPostModel *model = self.array[indexPath.row];
        ContentController *vc = [[ContentController alloc]init];
        vc.tieZiId = model.id;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.OnClickHeader = ^(NSString *otherUserId){
        OtherCenterController *vc = [[OtherCenterController alloc]init];
        vc.otherUserId =otherUserId;
        vc.type = 3;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetPostModel *model = self.array[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetPostModel *model = self.array[indexPath.row];
    ContentController *vc = [[ContentController alloc]init];
    vc.tieZiId = model.id;
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
    if (self.type == 1)
    {
       dic[@"type"] = @"1";
    }
    else if(self.type == 2)
    {
        dic[@"type"] = @"2";
    }
    else if (self.type == 3)
    {
        dic[@"type"] = @"3";
    }
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:self.url  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSLog(@"请求成功=%@",(NSDictionary*)resuposeObject);

        NSDictionary *dic = resuposeObject;
                
        NSArray *array = dic[@"data"][@"list"];
     
        [self.array removeAllObjects];
        
        for (NSDictionary *dic in array) {
            GetPostModel *model = [[GetPostModel alloc]initWithDic:dic];
            [self.array addObject:model];
        }
        
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    
    self.pageIndex++;
        
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.type == 1)
    {
        dic[@"type"] = @"1";
    }
    else if(self.type == 2)
    {
        dic[@"type"] = @"2";
    }
    else if (self.type == 3)
    {
        dic[@"type"] = @"3";
    }
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:self.url  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
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
        
         NSLog(@"请求成功=%@",(NSDictionary*)resuposeObject);
        
        NSArray *array = dic[@"data"][@"list"];
        if (array.count == 0)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        for (NSDictionary *dic in array) {
            GetPostModel *model = [[GetPostModel alloc]initWithDic:dic];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificiation:) name:@"UpdateMyCircleFirend" object:NULL];
}
- (void)receiveNotificiation:(NSNotification*)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableView.mj_header beginRefreshing];
    });
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateMyCircleFirend" object:NULL];    
}


@end

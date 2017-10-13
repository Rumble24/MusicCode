//
//  OtherCenterController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/29.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "OtherCenterController.h"
#import "WJTableViewCell.h"
#import "MJRefresh.h"
#import "WJNetTool.h"
#import "GetPostModel.h"
#import "PublicModel.h"
#import "ContentController.h"
#import "UIButton+InitButton.h"
#import "CxyButton.h"
#import "OtherHeaderView.h"
#import "MemberModel.h"
#import "UIImageView+WebCache.h"
#import "ChatWithFriendViewController.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface OtherCenterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OtherHeaderView *otherHeaderView;
@property (nonatomic, strong) CxyButton *addFriendBut;
@property (nonatomic, strong) CxyButton *chatBut;
@end

@implementation OtherCenterController
static NSString *const OtherCenterControllerCell = @"OtherCenterControllerCell";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createView];
    
    [self loadNewData];
    
    [self createHeaderView];
    
    [self createNavicationView];
    
    [self setupRefresh];
}

- (void)createView
{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.array = [NSMutableArray array];
    
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];

    self.title = @"好友名字";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WJTableViewCell class] forCellReuseIdentifier:OtherCenterControllerCell];
    [self.view addSubview:self.tableView];
}
// 用来判断是哪个页面跳转过来的  1.从街道点击过来的  2.从聊天页面点击过来的   3.从帖子点击过来的
- (void)createNavicationView
{
    UIView *naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    naviView.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0];
    [self.view addSubview:naviView];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(20, 20, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    [naviView addSubview:leftBtn];
    
    if ([self.otherUserId isEqualToString:[PublicModel getUserid]])
        return;
    
    if (self.type == 2)
    {
        self.addFriendBut = [CxyButton buttonWithType:UIButtonTypeCustom];
        self.addFriendBut.frame = CGRectMake(WIDTH - 120, 20, 100, 44);
        self.addFriendBut.imageRect = CGRectMake(0, 12, 20, 20);
        self.addFriendBut.titleRect = CGRectMake(20, 12, 80, 20);
        [self.addFriendBut setImage:[UIImage imageNamed:@"AddFriend"] forState:(UIControlStateNormal)];
        self.addFriendBut.hidden = YES;
        [self.addFriendBut setTitle:@"添加好友" forState:UIControlStateNormal];
        [self.addFriendBut addTarget:self action:@selector(OncClickAddFriend) forControlEvents:1<<6];
        [naviView addSubview:self.addFriendBut];
    }
    else if(self.type == 3)
    {
        self.addFriendBut = [CxyButton buttonWithType:UIButtonTypeCustom];
        self.addFriendBut.frame = CGRectMake(WIDTH - 120, 20, 100, 44);
        self.addFriendBut.imageRect = CGRectMake(0, 12, 20, 20);
        self.addFriendBut.titleRect = CGRectMake(20, 12, 80, 20);
        [self.addFriendBut setImage:[UIImage imageNamed:@"AddFriend"] forState:(UIControlStateNormal)];
        self.addFriendBut.hidden = YES;
        [self.addFriendBut setTitle:@"添加好友" forState:UIControlStateNormal];
        [self.addFriendBut addTarget:self action:@selector(OncClickAddFriend) forControlEvents:1<<6];
        [naviView addSubview:self.addFriendBut];
        
        self.chatBut = [CxyButton buttonWithType:UIButtonTypeCustom];
        self.chatBut.frame = CGRectMake(WIDTH - 100, 20, 80, 44);
        self.chatBut.imageRect = CGRectMake(0, 12, 20, 20);
        self.chatBut.titleRect = CGRectMake(20, 12, 80, 20);
        self.chatBut.hidden = YES;
        [self.chatBut setTitle:@"私聊" forState:UIControlStateNormal];
        [self.chatBut setImage:[UIImage imageNamed:@"ChatWithFriend"] forState:(UIControlStateNormal)];
        [self.chatBut addTarget:self action:@selector(OnClickChatView) forControlEvents:1<<6];
        [naviView addSubview:self.chatBut];
    }
}

- (void)createHeaderView
{
    _otherHeaderView = [[OtherHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 223)];
    _otherHeaderView.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0];
    self.tableView.tableHeaderView = _otherHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OtherCenterControllerCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.array[indexPath.row];
    cell.isCanClickHeader = false;
    cell.OnClickComment = ^()
    {
        GetPostModel *model = self.array[indexPath.row];
        ContentController *vc = [[ContentController alloc]init];
        vc.pushType = @"GeRen";
        vc.tieZiId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
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
    vc.pushType = @"GeRen";
    [self.navigationController pushViewController:vc animated:YES];
}


//添加刷新控件
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //根据下拉的距离提示符自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
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
    
    dic[@"member_id"] = self.otherUserId;
    dic[@"type"] = @"1";
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getPostListByMemberIdURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSDictionary *dic = resuposeObject;
        
        NSArray *array = dic[@"data"][@"list"];
        
        NSLog(@"请求到好友的页面%@",dic);
        
        NSNumber *is_friend = dic[@"data"][@"is_friend"];
        
        if (is_friend.intValue == 1)
        {
            self.addFriendBut.hidden = YES;
            self.chatBut.hidden = NO;
        }
        else
        {
            self.addFriendBut.hidden = NO;
            self.chatBut.hidden = YES;
        }
        
        MemberModel *memberModel = [[MemberModel alloc]initWithDic:dic[@"data"][@"member"]];
        self.otherHeaderView.nameLabel.text = memberModel.nickname;
        self.otherHeaderView.pregnancyLabel.text = [NSString stringWithFormat:@"孕%@周%@天",memberModel.week,memberModel.day];
        self.otherHeaderView.articleLabel.text = [NSString stringWithFormat:@"%@",dic[@"data"][@"post_count"]];
        self.otherHeaderView.praiseLabel.text = [NSString stringWithFormat:@"%@",dic[@"data"][@"zan_count"]];
        [self.otherHeaderView.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],memberModel.imgurl]]  placeholderImage:[UIImage imageNamed:@"DefaultHead.png"]];
        
        [self.array removeAllObjects];
        
        for (NSDictionary *dic in array) {
            GetPostModel *model = [[GetPostModel alloc]initWithDic:dic];
            [self.array addObject:model];
        }
        
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    
    self.pageIndex++;
    
    NSLog(@"loadMoreData的页数%ld,%@",self.pageIndex,self.otherUserId);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"member_id"] = self.otherUserId;
    dic[@"now_page"] = @(self.pageIndex);
    dic[@"page_size"] = @(20);
    dic[@"type"] = @"2";
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getPostListByMemberIdURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        if(![resuposeObject isKindOfClass:[NSDictionary class]])
        {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        NSDictionary *dic = resuposeObject;
        
        if (![dic[@"status"] isEqualToString:@"0"])
        {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        
        NSLog(@"请求到好友的页面%@",dic);
        
        if(![resuposeObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.mj_header.hidden = YES;
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
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
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)OnClickLeftBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)OncClickAddFriend
{
    NSLog(@"点击了添加好友");
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    
    dic[@"friend_id"] = self.otherUserId;
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getaddFriendURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        [SVProgressHUD showImage:NULL status:@"已经成功发送好友请求~"];
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:NULL status:@"添加好友消息失败，请稍后重试~"];
    }];
}

- (void)OnClickChatView
{
    NSLog(@"点击了和好友聊天");
    ChatWithFriendViewController *chat = [[ChatWithFriendViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:self.otherUserId];
    chat.title = self.otherHeaderView.nameLabel.text;
    [self.navigationController pushViewController:chat animated:YES];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

@end

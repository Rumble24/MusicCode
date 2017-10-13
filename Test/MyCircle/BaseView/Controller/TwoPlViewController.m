//
//  TwoPlViewController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/5.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "TwoPlViewController.h"
#import "MJRefresh.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "UIButton+InitButton.h"
#import "PLController.h"

#import "TwoPlHeaderCell.h"
#import "TwoPlCell.h"

#import "TwoPLModel.h"

#import "OtherCenterController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TwoPlViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) NSInteger pageId;

@property (nonatomic, assign) BOOL isDown;

@property (nonatomic, assign) BOOL isPL;
@end

@implementation TwoPlViewController
static NSString *const TwoPLTableViewCell = @"TwoPLTableViewCell";
static NSString *const TwoPLTableViewHeaderCell = @"TwoPLTableViewHeaderCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createView];
    
    [self createData];
}



- (void)createView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.array = [NSMutableArray array];
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.title = @"评论详情";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TwoPlHeaderCell class] forCellReuseIdentifier:TwoPLTableViewHeaderCell];
    [self.tableView registerClass:[TwoPlCell class] forCellReuseIdentifier:TwoPLTableViewCell];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isDown = YES;
        self.isPL = NO;
        [self createData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.isPL = NO;
        [self createData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 )
    {
        TwoPlHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoPLTableViewHeaderCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.headerModel;
        __block __typeof(self) weakSelf = self;
        cell.OnClickComment = ^(NSString *memberId,NSString *replyId,NSString *memberName)
        {
            PLController *vc = [[PLController alloc]init];
            vc.tieZiId = weakSelf.headerModel.post_id; // 那条帖子的ID；
            vc.toMemberID = memberId; // 那条评论发布者的的memberid == member_id
            vc.reply_id = replyId;  // 那条评论的ID == id
            vc.parent_id = replyId;
            vc.name = memberName;
            vc.type = 2;
            vc.PLSuccess = ^()
            {
                weakSelf.isDown = YES;
                [weakSelf createData];
            };
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
    else
    {
        TwoPlCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoPLTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TwoPLModel *model = self.array[indexPath.row];
        cell.model = model;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.headerModel.cellHeight;
    }
    TwoPLModel *model = self.array[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        TwoPLModel *model = self.array[indexPath.row];
        
        PLController *vc = [[PLController alloc]init];
        vc.tieZiId = model.post_id; // 那条帖子的ID；
        vc.toMemberID = model.member_id; // 那条评论发布者的的memberid == member_id
        vc.reply_id = model.id;  // 那条评论的ID == id
        vc.parent_id = model.parent_id;
        vc.name = model.member_name;
        vc.type = 2;
        vc.PLSuccess = ^()
        {
            self.isDown = YES;
            [self createData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
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
    dic[@"post_id"] = self.headerModel.post_id;
    dic[@"reply_id"] = self.headerModel.id;
    dic[@"parent_id"] = self.headerModel.parent_id;
    dic[@"type"] = @(1);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getPostReplyListURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
//        NSLog(@"请求评论成功=%@",(NSDictionary*)resuposeObject);
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {
            
            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                TwoPLModel *model = [[TwoPLModel alloc]initWithDic:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            for (NSDictionary *dic in array) {
                TwoPLModel *model = [[TwoPLModel alloc]initWithDic:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        if(self.isPL)
        {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.array.count - 1 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
        
    } failure:^(NSError *error) {
//        NSLog(@"请求评论失败=%@",error.domain);
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
@end

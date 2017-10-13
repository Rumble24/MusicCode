//
//  ContentController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ContentController.h"
#import "MJRefresh.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "UIButton+InitButton.h"
#import "PLController.h"
#import "TwoPlViewController.h"

#import "TableViewCell.h"
#import "TableViewHeaderCell.h"

#import "PLHeaderModel.h"
#import "PLModel.h"

#import "SVProgressHUD.h"

#import "LookCircleImage.h"

#import "OtherCenterController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ContentController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) PLHeaderModel *headerModel;

@property (nonatomic, strong) UIButton *ZanBut;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) NSInteger pageId;

@property (nonatomic, assign) BOOL isDown;

@property (nonatomic, assign) BOOL isPL;

@end

@implementation ContentController
static NSString *const PLTableViewCell = @"PLTableViewCell";
static NSString *const PLTableViewHeaderCell = @"PLTableViewHeaderCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.array = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"帖子详情";
    
    [self requestHeaderData];
    
    [self createData];
    
    [self createView];
    
    [self CreateBellowView];
    
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)createView
{
    NSLog(@"------------%@",self.pushType);

    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"" frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(ShouCang)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:PLTableViewCell];
    [self.tableView registerClass:[TableViewHeaderCell class] forCellReuseIdentifier:PLTableViewHeaderCell];
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

- (void)OnClickLeftBtn
{
    self.navigationController.delegate = nil;
    if (![self.pushType isEqualToString:@"Unity"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)CreateBellowView
{
    UIButton *button = [UIButton buttonWithTitle:@"分享" frame:CGRectMake(0, HEIGHT - 64 - 49, WIDTH /3, 49) target:self action:@selector(OnClickButton1)];
    [button setImage:[UIImage imageNamed:@"fenxiang.png"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 13];
    button.imageEdgeInsets = UIEdgeInsetsMake(16, WIDTH / 6 -24, 16, WIDTH / 6);
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithTitle:@"评论" frame:CGRectMake(WIDTH/3, HEIGHT - 64 - 49, WIDTH /3, 49) target:self action:@selector(OnClickButton2)];
    [button1 setImage:[UIImage imageNamed:@"contentPL.png"] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize: 13];
    button1.imageEdgeInsets = UIEdgeInsetsMake(16, WIDTH / 6 -24, 16, WIDTH / 6);
    [self.view addSubview:button1];
    
    _ZanBut = [UIButton buttonWithTitle:NULL frame:CGRectMake(WIDTH/3*2, HEIGHT - 64 - 49, WIDTH /3, 49) target:self action:@selector(OnClickButton3)];
    [_ZanBut setImage:[UIImage imageNamed:@"dadezan.png"] forState:UIControlStateNormal];
    _ZanBut.titleLabel.font = [UIFont systemFontOfSize: 13];
    _ZanBut.imageEdgeInsets = UIEdgeInsetsMake(16, WIDTH / 6 -24, 16, WIDTH / 6);
    [self.view addSubview:_ZanBut];
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
        TableViewHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:PLTableViewHeaderCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.headerModel;
        cell.pushType = self.pushType;

        __block __typeof(self) weakSelf = self;
        cell.OnClickImage = ^(NSIndexPath *index) {
            weakSelf.currentIndexPath = index;
            LookCircleImage *vc = [[LookCircleImage alloc]init];
            vc.imageArray = weakSelf.headerModel.imageModelArray;
            vc.index = index.row;
            weakSelf.navigationController.delegate = vc;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        cell.OnClickHeader = ^(NSString *otherUserId){
            OtherCenterController *vc = [[OtherCenterController alloc]init];
            vc.otherUserId =otherUserId;
            vc.type = 3;
            weakSelf.navigationController.delegate = nil;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    else
    {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PLTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PLModel *model = self.array[indexPath.row];
        cell.model = model;
        
        __block __typeof(self) weakSelf = self;
        cell.OnClickComment = ^(NSString *memberId,NSString *replyId,NSString *memberName)
        {
            PLController *vc = [[PLController alloc]init];
            vc.tieZiId = weakSelf.tieZiId; // 那条帖子的ID；
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
            weakSelf.navigationController.delegate = nil;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        cell.OnClickHeader = ^(NSString *otherUserId){
            OtherCenterController *vc = [[OtherCenterController alloc]init];
            vc.otherUserId =otherUserId;
            vc.type = 3;
            weakSelf.navigationController.delegate = nil;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.headerModel.cellHeight;
    }
    PLModel *model = self.array[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        TwoPlViewController *vc = [[TwoPlViewController alloc]init];
        PLModel *model = self.array[indexPath.row];
        vc.headerModel = model;
        self.navigationController.delegate = nil;
        [self.navigationController pushViewController:vc animated:YES];        
    }
}

- (void)requestHeaderData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"now_page"] = @(self.pageId);
    dic[@"page_size"] = @(20);
    dic[@"post_id"] = self.tieZiId;
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getPostDetailURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        self.headerModel = [[PLHeaderModel alloc]initWithDic:resuposeObject[@"data"][@"post"]];
        
        if(self.headerModel.is_collection == 0)
        {
           self.navigationItem.rightBarButtonItem.title = @"收藏";
        }
        else
        {
            self.navigationItem.rightBarButtonItem.title = @"取消收藏";
        }
        
        if(self.headerModel.is_zan == 0)
        {
            [_ZanBut setImage:[UIImage imageNamed:@"dadezan.png"] forState:UIControlStateNormal];
        }
        else
        {
            [_ZanBut setImage:[UIImage imageNamed:@"dadezanicon.png"] forState:UIControlStateNormal];
        }
        
        [_ZanBut setTitle:[PublicModel getCurrentNumber:self.headerModel.zan_count] forState:UIControlStateNormal];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

- (void)createData
{
    if (self.isDown) {
        self.pageId = 1;
    } else {
        self.pageId++;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"now_page"] = @(self.pageId);
    dic[@"page_size"] = @(20);
    dic[@"post_id"] = self.tieZiId;
    dic[@"type"] = @(0);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getPostReplyListURL] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSArray *array = resuposeObject[@"data"][@"list"];
        if(self.isDown)
        {

            [self.array removeAllObjects];
            for (NSDictionary *dic in array) {
                PLModel *model = [[PLModel alloc]initWithDic:dic];
                [self.array addObject:model];
            }
            
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            for (NSDictionary *dic in array) {
                PLModel *model = [[PLModel alloc]initWithDic:dic];
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)ShouCang
{
    if([PublicModel isBlankString:[PublicModel getUserid]] || [PublicModel isBlankString:[PublicModel getToken]])
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = [PublicModel getUserid];
    dic[@"token"] = [PublicModel getToken];
    dic[@"type"] = @"3";
    dic[@"kid"] = self.tieZiId;
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"收藏"])
    {
        [WJNetTool POST:[PublicModel getAddCollectionURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            self.navigationItem.rightBarButtonItem.title = @"取消收藏";
        } failure:^(NSError *error) {
        }];
    }
    else
    {
        [WJNetTool POST:[PublicModel getRemoveCollectionURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            self.navigationItem.rightBarButtonItem.title = @"收藏";
        } failure:^(NSError *error) {
        }];
    }
}

- (void)OnClickButton1
{
    NSLog(@"分享");
}
- (void)OnClickButton2
{
    PLController *vc = [[PLController alloc]init];
    vc.tieZiId = self.tieZiId;
    vc.toMemberID = self.headerModel.member_id;
    vc.name = self.headerModel.member_name;
    vc.type = 1;
    
    __block __typeof(self) weakSelf = self;
    vc.PLSuccess = ^()
    {
        weakSelf.isDown = YES;
        [weakSelf createData];
        weakSelf.headerModel.reply_count += 1;
        weakSelf.isPL = YES;
    };
    self.navigationController.delegate = nil;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)OnClickButton3
{
    if([PublicModel isBlankString:[PublicModel getUserid]] || [PublicModel isBlankString:[PublicModel getToken]])
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = [PublicModel getUserid];
    dic[@"token"] = [PublicModel getToken];
    dic[@"post_id"] = self.tieZiId;
    dic[@"type"] = @(1);
    
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    if(self.headerModel.is_zan == 0)
    {
        [WJNetTool POST:[PublicModel getDianZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [_ZanBut setImage:[UIImage imageNamed:@"dadezanicon.png"] forState:UIControlStateNormal];
            self.headerModel.is_zan = 1;
            self.headerModel.zan_count += 1;
            [_ZanBut setTitle:[PublicModel getCurrentNumber:self.headerModel.zan_count] forState:UIControlStateNormal];
        } failure:^(NSError *error) {
        }];
    }
    else if(self.headerModel.is_zan == 1)
    {
        [WJNetTool POST:[PublicModel getDeletePostZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [_ZanBut setImage:[UIImage imageNamed:@"dadezan.png"] forState:UIControlStateNormal];
            self.headerModel.is_zan = 0;
            self.headerModel.zan_count -= 1;
            [_ZanBut setTitle:[PublicModel getCurrentNumber:self.headerModel.zan_count] forState:UIControlStateNormal];
        } failure:^(NSError *error) {
        }];
    }
}


@end

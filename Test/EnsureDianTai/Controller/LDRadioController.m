//
//  LDRadioController.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDRadioController.h"
#import "UIButton+InitButton.h"
#import "LDRadioBackView.h"
#import "PublicModel.h"
#import "RedioCollectionCell.h"
#import "WJNetTool.h"
#import "LDPlayer.h"
#import "MJRefresh.h"

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface LDRadioController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) LDRadioBackView *backImage;
@property (nonatomic, strong) UICollectionView *mUpCollectionView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) BOOL isLoad;
@end

@implementation LDRadioController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];

    [self createView];
}

- (void)createView
{
    self.title = @"恩秀儿电台";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = [NSMutableArray array];
    self.pageId = 1;
    
    // 取消黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"" frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    _backImage = [[LDRadioBackView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1054/2.0f*kScale)];
    [self.view addSubview:_backImage];
    __block __typeof(self) weakSelf = self;
    _backImage.NeedReloadData = ^{
        [weakSelf.mUpCollectionView reloadData];
    };
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(80*kScale, 95*kScale);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.mUpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 1054/2.0f*kScale + 20*kScale, ScreenWidth , 120*kScale) collectionViewLayout:flow];
    [self.view addSubview:self.mUpCollectionView];
    self.mUpCollectionView.backgroundColor = [UIColor whiteColor];
    self.mUpCollectionView.delegate = self;
    self.mUpCollectionView.dataSource = self;
    self.mUpCollectionView.bounces = YES;
    self.mUpCollectionView.showsHorizontalScrollIndicator = NO;
    self.mUpCollectionView.showsVerticalScrollIndicator = NO;
    [self.mUpCollectionView registerClass:[RedioCollectionCell class] forCellWithReuseIdentifier:@"RedioCollectionCell"];
}

- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RedioCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RedioCollectionCell" forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDPlayMusicModel *model = self.array[indexPath.row];
    [[LDPlayer sharePlayer]play:model];
    self.backImage.model = model;
    [self.mUpCollectionView reloadData];
}



- (void)createData
{
    // 0:文章下评论，1:评论下子评论 post_id
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"now_page"] = @(1);
    dic[@"page_size"] = @(10);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getRadioStationListList] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSArray *array = resuposeObject[@"data"][@"list"];
        
        NSLog(@"请求到的电台数据：%@",array);
        

        for (NSDictionary *dic in array) {
            LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
            [self.array addObject:model];
        }
        
        if(self.backImage.model == nil)
            self.backImage.model = self.array[0];

        [LDPlayer sharePlayer].modelArray = self.array;
        
        [self.mUpCollectionView reloadData];
        
    } failure:^(NSError *error) {
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.mUpCollectionView.contentOffset.x > (80*kScale*self.array.count + 20 * (self.array.count - 1) - ScreenWidth))
    {
        if (!self.isLoad)
        {
            NSLog(@"哈哈该刷新了 ");
            [self loadMoreData];
            self.isLoad = true;
        }
    }
}




- (void)loadMoreData
{
    self.pageId++;
    
    NSLog(@"%d------------------",self.pageId);
    
    // 0:文章下评论，1:评论下子评论 post_id
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    dic[@"now_page"] = @(self.pageId);
    dic[@"page_size"] = @(10);
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getRadioStationListList] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSArray *array = resuposeObject[@"data"][@"list"];
        
        NSLog(@"请求到的电台数据：%@",array);
        
        for (NSDictionary *dic in array) {
            LDPlayMusicModel *model = [LDPlayMusicModel mj_objectWithKeyValues:dic];
            [self.array addObject:model];
        }
        
        if(self.backImage.model == nil)
            self.backImage.model = self.array[0];
        
        [LDPlayer sharePlayer].modelArray = self.array;
        
        [self.mUpCollectionView reloadData];
        
        self.isLoad = false;
        
        if (array.count == 0)
        {
            self.isLoad = true;
        }
        
    } failure:^(NSError *error) {
        
        self.isLoad = false;
    }];
}














@end

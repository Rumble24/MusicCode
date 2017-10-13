//
//  ChooseBackgroundController.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ChooseBackgroundController.h"
#import "PublicModel.h"
#import "ChooseBackgroundCell.h"
#import "ChooseBackModel.h"
#import "WJNetTool.h"
#import "MJExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

@interface ChooseBackgroundController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mUpCollectionView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ChooseBackgroundController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];
    
    [self createView];
}

- (void)createView
{
    self.title = @"选择聊天背景";
    
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.array = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(ScreenWidth/3.0f - 30, ScreenWidth/3.0f - 30);
    
    self.mUpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , HEIGHT - 64) collectionViewLayout:flow];
    [self.view addSubview:self.mUpCollectionView];
    self.mUpCollectionView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.mUpCollectionView.delegate = self;
    self.mUpCollectionView.dataSource = self;
    self.mUpCollectionView.bounces = YES;
    self.mUpCollectionView.contentInset = UIEdgeInsetsMake(15, 25, 15, 25) ;
    self.mUpCollectionView.showsHorizontalScrollIndicator = NO;
    self.mUpCollectionView.showsVerticalScrollIndicator = NO;
    [self.mUpCollectionView registerClass:[ChooseBackgroundCell class] forCellWithReuseIdentifier:@"ChooseBackgroundCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseBackgroundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseBackgroundCell" forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mUpCollectionView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popChatFunctionController" object:nil];
}

- (void)createData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getChatBackgroundList] body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSArray *array = resuposeObject[@"data"][@"list"];
        
        NSLog(@"请求到的聊天背景是： %@",array);
        
        for (NSDictionary *dic in array) {
            ChooseBackModel *model = [ChooseBackModel mj_objectWithKeyValues:dic];
            [self.array addObject:model];
        }
        
        [self.mUpCollectionView reloadData];
        
    } failure:^(NSError *error) {
    }];
}



@end

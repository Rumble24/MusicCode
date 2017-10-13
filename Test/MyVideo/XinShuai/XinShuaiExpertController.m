//
//  XinShuaiExpertController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiExpertController.h"
#import "LDEpertsTableViewCell.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "LDEpertsModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiExpertController ()
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) LDEpertsModel *model;
@property (nonatomic, assign) CGFloat height;
@end

@implementation XinShuaiExpertController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.array = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[LDEpertsTableViewCell class] forCellReuseIdentifier:@"XinShuaiExpertController"];
    
    [self loadNewData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDEpertsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XinShuaiExpertController" forIndexPath:indexPath];
    cell.epertsModelArray = self.array;
    cell.collectionHeight = self.height;
    cell.type = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.OnClickButton = ^(NSInteger index,NSArray *modelArray) {
        if (self.OnClickButton) {
            self.OnClickButton(index,modelArray);
        }
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height + 90;
}


- (void)loadNewData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    
    dic[@"now_page"] = @(1);
    dic[@"page_size"] = @(100);
    dic[@"type"] = @"2";
    
    
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getExpertKnowledgeListURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSDictionary *dic = resuposeObject;
        
        NSLog(@"%@",dic);
        
        NSArray *ary = dic[@"data"][@"list"];
        for (NSDictionary *mDic in ary)
        {
            for (int i = 0; i < 3; i++) {
                LDEpertsModel *model = [[LDEpertsModel alloc]initWithDic:mDic];
                [self.array addObject:model];
            }
        }
        
        self.height = self.array.count / 2 * 97 + self.array.count % 2 * 97;
        if (self.array.count / 2.0f > 1)
        {
            if (self.array.count % 2 == 0)
            {
                self.height += (self.array.count / 2 - 1) * 6;
            }
            else
            {
                self.height += (self.array.count / 2) * 6;
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

@end

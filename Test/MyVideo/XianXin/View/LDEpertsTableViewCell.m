//
//  LDEpertsTableViewCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDEpertsTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "PublicModel.h"
#import "LDExpertsCollectionViewCell.h"

@interface LDEpertsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIButton *introduceButton;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LDEpertsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createView];
    }
    return self;
}


- (void)createView
{
    self.headerImage = [[UIImageView alloc]init];
    [self.headerImage setContentMode:UIViewContentModeScaleAspectFill];
    self.headerImage.clipsToBounds = YES;
    [self.contentView addSubview:self.headerImage];
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.font = [UIFont systemFontOfSize:14];
    self.introduceLabel.numberOfLines = 0;
    self.introduceLabel.textColor = [PublicModel colorWithHexString:@"52BEA4"];
    [self.contentView addSubview:self.introduceLabel];
    
    self.introduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.introduceButton.backgroundColor =  [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0f];
    [self.introduceButton setTitle:@"查看更多" forState:0];
    self.introduceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.introduceButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.introduceButton addTarget:self action:@selector(introduceButAction) forControlEvents:1<<6];
    [self.contentView addSubview:self.introduceButton];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 6;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake((WIDTH - 40)/2, 97);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 0, WIDTH , 0) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[LDExpertsCollectionViewCell class] forCellWithReuseIdentifier:@"LDExpertsCollectionViewCell"];
    [self.contentView addSubview:self.collectionView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(15, 15, 60, 60);
    
    self.introduceLabel.frame = CGRectMake(90, 15, WIDTH - 90, 40);
    
    self.introduceButton.frame = CGRectMake(WIDTH-100, 15 + 50, 80, 20);
    
    self.collectionView.frame = CGRectMake(15, 15 + 60 + 15, WIDTH - 30, self.collectionHeight);
}


- (void)setEpertsModelArray:(NSArray *)epertsModelArray
{
    _epertsModelArray = epertsModelArray;
    
    [self.collectionView reloadData];
}

- (void)introduceButAction
{
    if (self.OnClickButton) {
        self.OnClickButton(-1,self.epertsModelArray);
    }
}

- (void)setType:(NSInteger)type
{
    if (type == 1) {
        self.introduceLabel.text = @"江剑辉，男，1965年生，现任广东省妇幼保健院小儿遗传代谢病诊治中心主任。";
        self.headerImage.image = [UIImage imageNamed:@"experts1.jpg"];

    }else{
        self.introduceLabel.text = @"李田昌，男，中国人民解放军海军总医院心脏中心，主任医师，博士研究生导师。";
        self.headerImage.image = [UIImage imageNamed:@"experts2.jpg"];
    }
}


#pragma mark - CollectionView Delelgate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.epertsModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDExpertsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDExpertsCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.epertsModelArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionView delegate  点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.OnClickButton) {
        self.OnClickButton(indexPath.row,self.epertsModelArray);
    }
}
@end

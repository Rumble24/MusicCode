//
//  TableViewHeaderCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "TableViewHeaderCell.h"
#import "PublicModel.h"
#import "ImageCollectionViewCell.h"
#import "PLHeaderModel.h"
#import "UIImageView+WebCache.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TableViewHeaderCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *Views;
@property (nonatomic, strong) UIImageView *redImage;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *reLabel;
@property (nonatomic, strong) UILabel *jingLabel;
@property (nonatomic, strong) UILabel *dingLabel;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *lineBackImage;
@property (nonatomic, strong) UILabel *plLabel;
@property (nonatomic, strong) UILabel *plCount;
@property (nonatomic, strong) UIImageView *whiteImage;
@property (nonatomic, strong) UIImageView *pinkImage;
@end

@implementation TableViewHeaderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createTableHeaderViewCellView];
        
    }
    return self;
}

- (void)createTableHeaderViewCellView
{
    _headerView = [[UIImageView alloc]init];
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerView];
    [self.headerView setContentMode:UIViewContentModeScaleAspectFill];
    self.headerView.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap];
    
    _name = [[UILabel alloc]init];
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.textColor=[PublicModel colorWithHexString:@"#66B4EB"];
    [self.contentView addSubview:_name];
    
    _time = [[UILabel alloc]init];
    _time.font = [UIFont systemFontOfSize:13];
    _time.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [self.contentView addSubview:_time];
    
    _Views = [[UILabel alloc]init];
    _Views.font = [UIFont systemFontOfSize:12];
    _Views.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    _Views.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_Views];
    
    _redImage = [[UIImageView alloc]init];
    _redImage.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_redImage];
    
    _title = [[UILabel alloc]init];
    _title.font = [UIFont systemFontOfSize:18];
    _title.numberOfLines = 0;
    _title.textColor=[PublicModel colorWithHexString:@"#648398"];
    [self.contentView addSubview:_title];
    self.reLabel = [[UILabel alloc]init];
    self.reLabel.backgroundColor =[UIColor redColor];
    self.reLabel.text = @"热";
    self.reLabel.textAlignment = NSTextAlignmentCenter;
    self.reLabel.font = [UIFont systemFontOfSize:14];
    self.reLabel.layer.cornerRadius = 3;
    self.reLabel.textColor = [UIColor whiteColor];
    self.reLabel.layer.masksToBounds = YES;
    [self.title addSubview:self.reLabel];
    
    self.jingLabel = [[UILabel alloc]init];
    self.jingLabel.backgroundColor = [PublicModel colorWithHexString:@"#e5c645"];
    self.jingLabel.font = [UIFont systemFontOfSize:14];
    self.jingLabel.layer.cornerRadius = 3;
    self.jingLabel.layer.masksToBounds = YES;
    self.jingLabel.text = @"精";
    self.jingLabel.textColor = [UIColor whiteColor];
    self.jingLabel.textAlignment = NSTextAlignmentCenter;
    [self.title addSubview:self.jingLabel];
    
    self.dingLabel = [[UILabel alloc]init];
    self.dingLabel.backgroundColor = [PublicModel colorWithHexString:@"#74baec"];
    self.dingLabel.layer.cornerRadius = 3;
    self.dingLabel.layer.masksToBounds = YES;
    self.dingLabel.textColor = [UIColor whiteColor];
    self.dingLabel.font = [UIFont systemFontOfSize:14];
    self.dingLabel.text = @"顶";
    self.dingLabel.textAlignment = NSTextAlignmentCenter;
    [self.title addSubview:self.dingLabel];
    
    _content = [[UILabel alloc]init];
    _content.numberOfLines = 0;
    _content.font = [UIFont systemFontOfSize:15];
    _content.textColor=[PublicModel colorWithHexString:@"#648398"];
    [self.contentView addSubview:_content];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = WIDTH;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH , 0) collectionViewLayout:flowLayout];
    [self.contentView addSubview:self.collectionView];

    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    
    _lineBackImage = [[UIImageView alloc]init];
    _lineBackImage.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.contentView addSubview:_lineBackImage];
    
    _whiteImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, WIDTH, 30)];
    _whiteImage.backgroundColor = [UIColor whiteColor];
    [_lineBackImage addSubview:_whiteImage];
    
    _plLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 32, 30)];
    _plLabel.font = [UIFont systemFontOfSize:15];
    _plLabel.text = @"评论";
    _plLabel.textColor=[PublicModel colorWithHexString:@"#FF97B7"];
    [_whiteImage addSubview:_plLabel];
    
    _plCount = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 32, 30)];
    _plCount.font = [UIFont systemFontOfSize:13];
    _plCount.textColor=[PublicModel colorWithHexString:@"#648398"];
    [_whiteImage addSubview:_plCount];
    
    _pinkImage = [[UIImageView alloc]init];
    _pinkImage.backgroundColor = [PublicModel colorWithHexString:@"#FF97B7"];
    [_whiteImage addSubview:_pinkImage];
}


- (void)setModel:(PLHeaderModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"DefaultHead.png"]];
    self.name.text = model.member_name;
    self.time.text = model.publish_time;
    self.Views.text = [NSString stringWithFormat:@"浏览量:%ld",model.views];
    
    if (model.is_highlight.integerValue  == 0){
        self.jingLabel.hidden = YES;
    }else{
        self.jingLabel.hidden = NO;
    }
    if (model.is_hot.integerValue  == 0){
        self.reLabel.hidden = YES;
    }else{
        self.reLabel.hidden = NO;
    }
    if (model.is_top.integerValue == 0){
        self.dingLabel.hidden = YES;
    }else{
        self.dingLabel.hidden = NO;
    }
    
    if ([self theNumberOfStatus] == 0) {
        self.title.text = model.title;
    }else if([self theNumberOfStatus] == 1){
        self.title.text = [NSString stringWithFormat:@"     %@",model.title];
    }else if([self theNumberOfStatus] == 2){
        self.title.text = [NSString stringWithFormat:@"         %@",model.title];
    }else if([self theNumberOfStatus] == 3){
        self.title.text = [NSString stringWithFormat:@"             %@",model.title];
    }
        
    self.content.text = model.content;
    self.plCount.text = [NSString stringWithFormat:@"%ld条",model.reply_count];
    
    [self.collectionView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float cellY = 0;
    self.headerView.frame = CGRectMake(15, 15, 40, 40);
    
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect namerect = [self.name.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    self.name.frame = CGRectMake(63, 15, namerect.size.width, 13);
    
    NSDictionary *Viewsdic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect Viewsrect = [self.Views.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:Viewsdic context:nil];
    self.Views.frame = CGRectMake(WIDTH - 15 - Viewsrect.size.width,15,Viewsrect.size.width,20);
    
    self.time.frame = CGRectMake(63, 55 - 15, WIDTH-100, 15);
    
    NSDictionary *titledic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGRect titlerect = [self.title.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:titledic context:nil];
    
    self.title.frame = CGRectMake(15, 55 + 15, WIDTH - 30, titlerect.size.height);
    cellY = 55 + 15 + titlerect.size.height;
    
    
    if (self.dingLabel.isHidden == NO)
    {
        if(self.jingLabel.isHidden == NO)
        {
            if (self.reLabel.isHidden == NO) {
                self.dingLabel.frame = CGRectMake(0, 2, 18, 18);
                self.jingLabel.frame = CGRectMake(20, 2, 18, 18);
                self.reLabel.frame = CGRectMake(40, 2, 18, 18);
            }else{
                self.dingLabel.frame = CGRectMake(0, 2, 18, 18);
                self.jingLabel.frame = CGRectMake(20, 2, 18, 18);
            }
        }
        else
        {
            if (self.reLabel.isHidden == NO) {
                self.dingLabel.frame = CGRectMake(0, 2, 18, 18);
                self.reLabel.frame = CGRectMake(20, 2, 18, 18);
            }else{
                self.dingLabel.frame = CGRectMake(0, 2, 18, 18);
            }
        }
    }
    else
    {
        if(self.jingLabel.isHidden == NO)
        {
            if (self.reLabel.isHidden == NO) {
                self.jingLabel.frame = CGRectMake(0, 2, 18, 18);
                self.reLabel.frame = CGRectMake(20, 2, 18, 18);
            }else{
                self.jingLabel.frame = CGRectMake(0, 2, 18, 18);
            }
        }
        else
        {
            if (self.reLabel.isHidden == NO) {
                self.reLabel.frame = CGRectMake(0, 2, 18, 18);
            }
        }
    }

    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.content.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.content.frame = CGRectMake(15, cellY + 15, WIDTH - 30, rect.size.height);
    cellY = cellY + 15 + rect.size.height;
    
    self.collectionView.frame = CGRectMake(15, cellY + 15, WIDTH - 30, _model.collectionHeight);
    cellY += _model.collectionHeight;
    self.lineBackImage.frame = CGRectMake(0, cellY + 15, WIDTH, 45);
    
    NSDictionary *pldic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect plrect = [self.plCount.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:pldic context:nil];
    _pinkImage.frame = CGRectMake(15, 28, plrect.size.width + 34, 2);
}

#pragma mark - 点击头像进入关注界面
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"TableViewHeaderCell   点击了头像    %@",self.pushType);
    if (![self.pushType isEqualToString:@"GeRen"])
    {
        if (self.OnClickHeader) {
            self.OnClickHeader(self.model.member_id);
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.model.imageArray[indexPath.row];
    return CGSizeMake(WIDTH - 30, [dic[@"height"] floatValue]);
}

#pragma mark - CollectionView Delelgate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic = self.model.imageArray[indexPath.row];
    cell.dic = dic;
    return cell;
}

#pragma mark - UICollectionView delegate  点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.OnClickImage) {
        self.OnClickImage(indexPath);
    }
}
- (NSInteger)theNumberOfStatus
{
    NSInteger n = 0;
    if (self.model.is_highlight.integerValue == 1) {
        n += 1;
    }
    if (self.model.is_top.integerValue == 1) {
        n += 1;
    }
    if (self.model.is_hot.integerValue == 1) {
        n += 1;
    }
    return n;
}
@end

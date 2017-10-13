//
//  LDDiseaseCollectionView.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/22.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseCollectionView.h"
#import "PublicModel.h"
#import "LDUpCollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *mUpCollectionView;
@property (nonatomic, strong) UICollectionView *mBelowCollectionView;
@property (nonatomic, assign) NSInteger lastIndex;
@end

@implementation LDDiseaseCollectionView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lastIndex = 0;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createUpCollectionView];
    
    [self createBelowCollectionView];
}

- (void)createUpCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(90, 50);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.mUpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH , 50) collectionViewLayout:flow];
    [self.view addSubview:self.mUpCollectionView];
    self.mUpCollectionView.backgroundColor = [UIColor whiteColor];
    self.mUpCollectionView.delegate = self;
    self.mUpCollectionView.dataSource = self;
    self.mUpCollectionView.bounces = YES;
    self.mUpCollectionView.showsHorizontalScrollIndicator = NO;
    self.mUpCollectionView.showsVerticalScrollIndicator = NO;
    [self.mUpCollectionView registerClass:[LDUpCollectionViewCell class] forCellWithReuseIdentifier:@"upCell"];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
}

- (void)createBelowCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.mBelowCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, WIDTH , HEIGHT - 49 - 64 - 200 - 50) collectionViewLayout:flow];
    [self.view addSubview:self.mBelowCollectionView];
    self.mBelowCollectionView.backgroundColor = [UIColor whiteColor];
    self.mBelowCollectionView.pagingEnabled = YES;
    self.mBelowCollectionView.bounces = NO;
    self.mBelowCollectionView.delegate = self;
    self.mBelowCollectionView.dataSource = self;
    self.mBelowCollectionView.showsHorizontalScrollIndicator = NO;
    self.mBelowCollectionView.showsVerticalScrollIndicator = NO;
    [self.mBelowCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"belowCell"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mUpCollectionView])
    {
        if (_titleArray.count == 6) {
            return  CGSizeMake(90, 50);
        }else{
            NSString *str = _titleArray[indexPath.row];
            NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
            CGRect namerect = [str boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
            
            CGFloat w = 0;
            if (namerect.size.width > 54) {
                w = namerect.size.width + 37;
            }else{
                w = 90;
            }
            return  CGSizeMake(w, 50);
        }
    }
    else
    {
        return CGSizeMake(WIDTH,HEIGHT - 49 - 64 - 200 - 50);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mUpCollectionView])
    {
        LDUpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"upCell" forIndexPath:indexPath];
        cell.mTitle = self.titleArray[indexPath.row];
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"belowCell" forIndexPath:indexPath];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UIViewController *subVC = self.childViewControllers[indexPath.row];
        subVC.view.frame = CGRectMake(0, 0, WIDTH, self.view.frame.size.height - 50);
        [cell.contentView addSubview:subVC.view];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mUpCollectionView])
    {
       [self.mBelowCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.mBelowCollectionView])
    {
        NSInteger index = self.mBelowCollectionView.contentOffset.x / WIDTH;
        [self.mUpCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
        self.lastIndex = index;
    }
}

- (void)delayMethod
{
    [self.mUpCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.lastIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self.mUpCollectionView reloadData];
    [self.mBelowCollectionView reloadData];
}

@end

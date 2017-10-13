//
//  WJViewController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJViewController.h"
#import "UIButton+InitButton.h"
#import "WJTableViewController.h"
#import "PublicModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WJViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
// 记录下当前的页面的index
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UICollectionView *belowCollectionView;
@property (nonatomic, strong) UIImageView *redImage;
@property (nonatomic, strong) UIImage *backImage;

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)createView
{
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"fensede.png"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    self.backImage = [image resizableImageWithCapInsets:edgeInsets];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.belowCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+57, WIDTH , HEIGHT-64-57) collectionViewLayout:flow];
    [self.view addSubview:self.belowCollectionView];
    self.belowCollectionView.backgroundColor = [UIColor whiteColor];
    self.belowCollectionView.pagingEnabled = YES;
    self.belowCollectionView.bounces = NO;
    self.belowCollectionView.delegate = self;
    self.belowCollectionView.dataSource = self;
    self.belowCollectionView.showsHorizontalScrollIndicator = YES;
    [self.belowCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"belowCell"];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH, HEIGHT-64-57);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"belowCell" forIndexPath:indexPath];
    // 先移除 子视图的View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    WJTableViewController *subVC = self.childViewControllers[indexPath.row];
    subVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 57);
    subVC.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [cell.contentView addSubview:subVC.view];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.index = self.belowCollectionView.contentOffset.x / WIDTH;
    [self SetButtonStatus];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   self.redImage.frame = CGRectMake(self.belowCollectionView.contentOffset.x/_titleArray.count+ (WIDTH/_titleArray.count - WIDTH/_titleArray.count + 10) / 2,64 + 15, WIDTH/_titleArray.count - 10, 30);
}

- (void)SetButtonStatus
{
    for (int i = 0; i<_titleArray.count; i++)
    {
        UIButton *but = (UIButton *)[self.view viewWithTag:(i+1000)];
        if (i == self.index){
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [but setTitleColor:[PublicModel colorWithHexString:@"#B2BEC4"] forState:UIControlStateNormal];
        }
    }
}


- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    self.redImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH/_titleArray.count - WIDTH/_titleArray.count + 10) / 2, 64 + 15, WIDTH/_titleArray.count - 10, 30)];
    self.redImage.layer.cornerRadius = 15;
    self.redImage.layer.masksToBounds = YES;
    self.redImage.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0];
//    self.redImage.image =  self.backImage;
    [self.view addSubview:self.redImage];
    for (int i = 0; i<_titleArray.count; i++)
    {
        UIButton *left = [UIButton buttonWithTitle:_titleArray[i] frame:CGRectMake(WIDTH * ((float)i/_titleArray.count), 64, WIDTH/_titleArray.count, 57) target:self action:@selector(OnClickButton:)];
        left.backgroundColor = [UIColor clearColor];
        if (i== 0) {
            [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [left setTitleColor:[PublicModel colorWithHexString:@"#B2BEC4"] forState:UIControlStateNormal];
        }

        left.tag = i + 1000;
        [self.view addSubview:left];
    }
}


// 点击移动红色的还有CollectionView的偏移量
-(void)OnClickButton:(UIButton *)but
{
    self.index = (but.tag - 1000);
    self.belowCollectionView.contentOffset = CGPointMake(self.index * WIDTH, 0);
    self.redImage.frame = CGRectMake(but.frame.origin.x + (WIDTH/_titleArray.count - WIDTH/_titleArray.count + 10) / 2,64 + 15, WIDTH/_titleArray.count - 10, 30);
    [self SetButtonStatus];
}



@end

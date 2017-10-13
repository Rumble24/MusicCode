//
//  LookImage.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LookImage.h"
#import "SmallScrollView.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"
#import "ImageModel.h"
#import "SVProgressHUD.h"
#import "XWNaviTransition.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LookImage ()<UIScrollViewDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIScrollView *scroller;

@property (nonatomic, retain)UIPageControl *pageControl;

@end

@implementation LookImage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor blackColor];
    
    self.navigationController.delegate = self;
    
    /* 创 建 第 一 层  smallView */
    _scroller = [[UIScrollView alloc]initWithFrame:self.view.frame];    //用的UIView的初始化方法
    _scroller.backgroundColor =[UIColor blackColor];
    _scroller.pagingEnabled = YES; /*按 页 去 滑 动*/
    _scroller.bounces = YES;     /*设置边界回弹*/
    _scroller.showsHorizontalScrollIndicator = YES;  //隐藏水平滚动条
    _scroller.contentOffset = CGPointMake(self.index * WIDTH,0);  //当前页
    _scroller.delegate = self;
    [self.view addSubview:_scroller];
    _scroller.contentSize = CGSizeMake(WIDTH * self.imageArray.count, 0); /*重 要 属 性,设 置 之 后,scrollView就 可 以 滚 动 了*/
    
    
    for (int i = 0; i < self.imageArray.count; i++)
    {
        SmallScrollView  *smallScrollView= [[SmallScrollView alloc]initWithFrame:CGRectMake(WIDTH *i, 0, WIDTH, HEIGHT)];
        ImageModel *model = self.imageArray[i];
        
        if (i == self.index) {
            self.imageView = smallScrollView.imageView;
        }

        smallScrollView.model = model;
        UIImageView *firstImageOfSmallScrollView = smallScrollView.subviews[0];
        [firstImageOfSmallScrollView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        
        smallScrollView.maximumZoomScale = 2;
        smallScrollView.minimumZoomScale = 0.5;
        smallScrollView.delegate = self;
        smallScrollView.OnClickImage = ^()
        {
            [self.navigationController popViewControllerAnimated:YES];
        };
        smallScrollView.OnLongImage = ^(UIImage *image)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存到本地" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                [SVProgressHUD showImage:NULL status:@"保存成功~"];                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        };
    
        [_scroller addSubview:smallScrollView];
    }
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, HEIGHT - 50, WIDTH, 50)];
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];       //点的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:self.pageControl];
}

#pragma mark - 结束滚动的时候触发这个方法.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    for (UIScrollView *sView in scrollView.subviews){
        if ([sView isKindOfClass:[UIScrollView class]]){
            sView.zoomScale = 1.0;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = _scroller.contentOffset.x  /  WIDTH;
    
    self.index = self.pageControl.currentPage;
    
    if (self.OnScrollIndex) {
        self.OnScrollIndex(self.pageControl.currentPage);
    }
}
#pragma mark - 用来控制缩放的协议方法    函数return下面的不执行
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView *imageView = [scrollView.subviews objectAtIndex:0]; //返回当前图片
    return imageView;
}
// 控制缩放的中心
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *firstImage = scrollView.subviews[0];
    
    float W = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : WIDTH/2;
    float H = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 :scrollView.center.y;
    
    firstImage.center = CGPointMake(W,H);
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    self.scroller.scrollEnabled = NO;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    self.scroller.scrollEnabled = YES;
    if (scale < 1)
    {
        for (UIScrollView *sView in _scroller.subviews){
            if ([sView isKindOfClass:[UIScrollView class]]){
                // 把视图的尺寸恢复到原有尺寸
                [UIView animateWithDuration:0.2 animations:^{
                    sView.zoomScale = 1.0;
                    
                }];
            }
        }
    }
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XWNaviTransition transitionWithType:operation == UINavigationControllerOperationPush ? XWNaviOneTransitionTypePush : XWNaviOneTransitionTypePop];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:NO];
}
@end

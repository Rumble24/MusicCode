//
//  CircleNaviTransition.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/20.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "CircleNaviTransition.h"
#import "LookImage.h"
#import "ContentController.h"
#import "ImageCollectionViewCell.h"
#import "TableViewHeaderCell.h"

@interface CircleNaviTransition ()
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) XWNaviCircleTransitionType type;

@end

@implementation CircleNaviTransition

+ (instancetype)transitionWithType:(XWNaviCircleTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XWNaviCircleTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}
/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XWNaviCircleTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case XWNaviCircleTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
    
}

/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ContentController *fromVC = (ContentController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    LookImage *toVC = (LookImage *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 先拿到TableViewHeaderCell
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
    TableViewHeaderCell *nextCell = [fromVC.tableView cellForRowAtIndexPath:newPath];
    
    //拿到当前点击的cell的imageView
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[nextCell.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.mImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.mImageView convertRect:cell.mImageView.bounds toView: containerView];
    //设置动画前的各个控件的状态
    cell.mImageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
        
    }];
    
    //    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
    //        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
    //        toVC.view.alpha = 1;
    //    } completion:^(BOOL finished) {
    //        tempView.hidden = YES;
    //        toVC.imageView.hidden = NO;
    //        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
    //        [transitionContext completeTransition:YES];
    //    }];
}
/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LookImage *fromVC = (LookImage *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ContentController *toVC = (ContentController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 先拿到TableViewHeaderCell
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
    TableViewHeaderCell *nextCell = [toVC.tableView cellForRowAtIndexPath:newPath];
    
    //拿到当前点击的cell的imageView
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[nextCell.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    cell.mImageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        tempView.frame = [cell.mImageView convertRect:cell.mImageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.mImageView.hidden = NO;
            [tempView removeFromSuperview];
        }
        
    }];
    
    
    //    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
    //        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    //        fromVC.view.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        //由于加入了手势必须判断
    //        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    //        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
    //            //失败了隐藏tempView，显示fromVC.imageView
    //            tempView.hidden = YES;
    //            fromVC.imageView.hidden = NO;
    //        }else{//手势成功，cell的imageView也要显示出来
    //            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
    //            cell.imageView.hidden = NO;
    //            [tempView removeFromSuperview];
    //        }
    //    }];
}

@end

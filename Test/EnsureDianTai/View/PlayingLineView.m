//
//  PlayingLineView.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/22.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PlayingLineView.h"
#import "PublicModel.h"
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

@implementation PlayingLineView
{
    float _lineWidth;
    UIColor *_lineColor;
    NSMutableArray *_lineArray;
    NSMutableArray *_aniArray;
}

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth lineColor:(UIColor*)lineColor
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        _lineColor = lineColor;
        _lineArray = [[NSMutableArray alloc] initWithCapacity:30];
        _aniArray = [[NSMutableArray alloc] initWithCapacity:30];
        [self buildLayout];
    }
    return self;
}

-(void)buildLayout
{
    float margin = 7.793/2.0f * kScale;
    for (int i = 0; i < 30; i++)
    {
        //初始化layer
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.frame = self.bounds;
        [self.layer addSublayer:layer];
        
        //创建震动条
        CALayer*subLayer = [[CALayer alloc]init];
        
        //设置背景颜色
        subLayer.backgroundColor = [PublicModel colorWithHexString:@"E9F1D3"].CGColor;
        
        //设置宽高.
        subLayer.bounds = CGRectMake(0,0,7 * kScale,7* kScale);
        
        //设置震动层的位置
        subLayer.position = CGPointMake((i)*margin + i*_lineWidth, 106* kScale);
        
        //给定震动层的锚点
        subLayer.anchorPoint = CGPointMake(0,1);
        
        //将需要被赋值的震动层添加到复制层
        [layer addSublayer:subLayer];
        
        //创建震动条
        CALayer*subLayer1 = [[CALayer alloc]init];
        
        subLayer1.opacity = 0.3f;
        
        //设置背景颜色
        subLayer1.backgroundColor = [PublicModel colorWithHexString:@"E9F1D3"].CGColor;
        
        //设置宽高.
        subLayer1.bounds = CGRectMake(0,7.5 * kScale,7 * kScale,7* kScale);
        
        //设置震动层的位置
        subLayer1.position = CGPointMake((i)*margin + i*_lineWidth, 106* kScale + 7.5 * kScale);
        
        //给定震动层的锚点
        subLayer1.anchorPoint = CGPointMake(0,0);
        
        //将需要被赋值的震动层添加到复制层
        [layer addSublayer:subLayer1];
        

        [_lineArray addObject:subLayer];
        
        [_aniArray addObject:subLayer1];
    }    
}


-(void)addAnimationWith:(NSArray *)timeArray
{
    for (int i = 0; i<_lineArray.count; i++)
    {
        CALayer *subLayer = [_lineArray objectAtIndex:i];
        //创建关键帧动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
                
        //结束值
        animation.toValue = timeArray[i];
        
        //动画结束时是否执行逆动画
        animation.autoreverses = YES;
        
        //重复次数(无限)
        animation.repeatCount = MAXFLOAT;
        
        //添加到震动层
        [subLayer addAnimation:animation forKey:nil];
        
        CALayer *subLayer1 = [_aniArray objectAtIndex:i];
        
        //添加到震动层
        [subLayer1 addAnimation:animation forKey:nil];
    }
}

- (void)stopAllAnimation
{
    for (int i = 0; i<_lineArray.count; i++)
    {
        CALayer *subLayer = [_lineArray objectAtIndex:i];
        CALayer *subLayer1 = [_aniArray objectAtIndex:i];
//        CFTimeInterval pauseTime = [subLayer convertTime:CACurrentMediaTime() fromLayer:nil];
//        
//        //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
//        subLayer.timeOffset = pauseTime;
//        
//        //3.将动画的运行速度设置为0， 默认的运行速度是1.0
//        subLayer.speed = 0;
        
        [subLayer removeAllAnimations];
        [subLayer1 removeAllAnimations];
    }
}


@end

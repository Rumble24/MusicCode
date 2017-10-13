//
//  SmallScrollView.m
//  UI06_UIScrollView
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SmallScrollView.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SmallScrollView ()



@end

@implementation SmallScrollView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
            [self.imageView addGestureRecognizer:longPress];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.OnClickImage) {
        self.OnClickImage();
    }
}

- (void)setModel:(ImageModel *)model
{
    _model = model;
    
    CGFloat W = WIDTH;
    CGFloat H = (model.height.floatValue / model.width.floatValue) * WIDTH;
        
    self.imageView.frame = CGRectMake(0, 0, W, H);
    self.imageView.center = CGPointMake(WIDTH/ 2,self.center.y);
}

-(void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    // 通过手势的状态,避免重复的触发手势方法
    if (longPress.state==UIGestureRecognizerStateBegan) {
        
        if (self.OnLongImage) {
            self.OnLongImage(self.imageView.image);
        }      
    }
}


@end

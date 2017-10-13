//
//  PublishCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/24.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PublishCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PublishCell ()

@property (nonatomic, strong) UIImageView *deleteImage;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PublishCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageView];
        
        self.deleteImage = [[UIImageView alloc]init];
        self.deleteImage.image = [UIImage imageNamed:@"deleteImage.png"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        self.deleteImage.userInteractionEnabled = YES;
        [self.deleteImage addGestureRecognizer:tap];
        [self.contentView addSubview:self.deleteImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 10, 80, 120);
    
    self.deleteImage.frame = CGRectMake(73, 0, 14, 14);
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    if ([[dic allKeys]containsObject:@"image"])
    {
        self.imageView.image = dic[@"image"];
        self.deleteImage.hidden = YES;
    }
    else
    {
        self.imageView.image = dic[@"asset"];
        self.deleteImage.hidden = NO;
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.OnClickDelete) {
        self.OnClickDelete(self.dic);
    }
}
@end

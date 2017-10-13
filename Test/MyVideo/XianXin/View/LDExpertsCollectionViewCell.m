//
//  LDExpertsCollectionViewCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDExpertsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDExpertsCollectionViewCell ()
@property (nonatomic, strong) UIImageView *introduceImage;
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UILabel *introduceLabel;

@end

@implementation LDExpertsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backImage = [[UIImageView alloc]init];
        [self.backImage setContentMode:UIViewContentModeScaleAspectFill];
        self.backImage.clipsToBounds = YES;
        [self.contentView addSubview:self.backImage];
        
        self.introduceLabel = [[UILabel alloc]init];
        self.introduceLabel.font = [UIFont systemFontOfSize:14];
        self.introduceLabel.textAlignment = NSTextAlignmentCenter;
        self.introduceLabel.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:0.8f];
        self.introduceLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.introduceLabel];
        
        self.introduceImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.introduceImage];
        
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

// 1.文章  2.视频
- (void)setModel:(LDEpertsModel *)model
{
    _model = model;
    
    self.introduceLabel.text = model.title;
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],_model.imgurl]]];

    if ([_model.type isEqualToString:@"1"])
    {
        self.introduceImage.image = [UIImage imageNamed:@"EpertsText"];
    }
    else if([_model.type isEqualToString:@"2"])
    {
       self.introduceImage.image = [UIImage imageNamed:@"EpertsVideo"];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backImage.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);;
    
    self.introduceImage.frame = CGRectMake(((WIDTH - 40)/2 - 41)/2, (97 - 41)/2, 41, 41);
    
    self.introduceLabel.frame = CGRectMake(0, 97-20, (WIDTH - 40)/2, 20);
}














@end

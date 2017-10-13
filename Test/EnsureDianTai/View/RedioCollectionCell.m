//
//  RedioCollectionCell.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "RedioCollectionCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "LDPlayer.h"
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

@interface RedioCollectionCell ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *introduceLabel;

@end

@implementation RedioCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backImage = [[UIImageView alloc]init];
        self.backImage.image = [UIImage imageNamed:@"RadioBackImage.png"];
        [self.contentView addSubview:self.backImage];
        
        self.headerImage = [[UIImageView alloc]init];
        self.headerImage.layer.cornerRadius = 5.0f;
        [self.headerImage setContentMode:UIViewContentModeScaleAspectFill];
        self.headerImage.clipsToBounds = YES;
        [self.backImage addSubview:self.headerImage];
        
        self.introduceLabel = [[UILabel alloc]init];
        self.introduceLabel.font = [UIFont systemFontOfSize:15];
        self.introduceLabel.textAlignment = NSTextAlignmentCenter;
        self.introduceLabel.textColor = [PublicModel colorWithHexString:@"86D0BD"];
        [self.contentView addSubview:self.introduceLabel];
        
    }
    return self;
}
// 1.文章  2.视频
- (void)setModel:(LDPlayMusicModel *)model
{
    _model = model;
    
    self.introduceLabel.text = model.title;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],_model.imgurl]]];
    
    if([[LDPlayer sharePlayer].currentUrlStr isEqualToString:model.url])
    {
        self.backImage.frame = CGRectMake(-5*kScale, -5*kScale, 90*kScale, 90*kScale);
        self.headerImage.frame = CGRectMake(10*kScale, 8.7f *kScale,  70*kScale,  70*kScale);
    }
    else
    {
        self.backImage.frame = CGRectMake(0, 0, 80*kScale, 80*kScale);
        self.headerImage.frame = CGRectMake(10*kScale, 8.7f *kScale,  60*kScale,  60*kScale);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backImage.frame = CGRectMake(0, 0, 80*kScale, 80*kScale);
    
    self.headerImage.frame = CGRectMake(10*kScale, 8.7f *kScale,  60*kScale,  60*kScale);
    
    self.introduceLabel.frame = CGRectMake(0, 80*kScale, 80*kScale, 20);
}


@end

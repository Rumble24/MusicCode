//
//  LDUpCollectionViewCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/22.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDUpCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"


@interface LDUpCollectionViewCell ()
@property (nonatomic, strong) UILabel *mTitleLabel;
@end

@implementation LDUpCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _mImageView = [[UIImageView alloc]init];
        _mImageView.layer.cornerRadius = 17;
        _mImageView.layer.masksToBounds = YES;
        _mImageView.backgroundColor = [PublicModel colorWithHexString:@"93e0cc"];
        
        
        
//        UIImage *image = [UIImage imageNamed:@"DiseaseImage.png"];
//        // 设置端盖的值
//        CGFloat top = image.size.height * 0.5;
//        CGFloat left = image.size.width * 0.5;
//        CGFloat bottom = image.size.height * 0.5;
//        CGFloat right = image.size.width * 0.5;
//        
//        // 设置端盖的值
//        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
//        // 设置拉伸的模式
//        UIImageResizingMode mode = UIImageResizingModeStretch;
//        
//        // 拉伸图片
//        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
//        
//        _mImageView.image = newImage;
        [self.contentView addSubview:_mImageView];
        
        _mTitleLabel = [[UILabel alloc]init];
        _mTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mTitleLabel.textColor = [UIColor whiteColor];
        _mTitleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_mTitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.mTitleLabel.frame = self.contentView.frame;
    self.mImageView.frame = CGRectMake(11, 8, self.contentView.frame.size.width - 22, 34);
}

- (void)setMTitle:(NSString *)mTitle
{
    _mTitle = mTitle;
    _mTitleLabel.text = mTitle;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected == YES)
    {
       _mImageView.backgroundColor = [PublicModel colorWithHexString:@"52bea4"];
    }
    else
    {
        _mImageView.backgroundColor = [PublicModel colorWithHexString:@"93e0cc"];
    }
}

@end

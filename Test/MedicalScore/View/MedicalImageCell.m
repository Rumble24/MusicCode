//
//  MedicalImageCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MedicalImageCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MedicalImageCell ()



@end

@implementation MedicalImageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.mImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.mImageView];
        
//        self.deleteImage = [[UIImageView alloc]init];
//        self.deleteImage.image = [UIImage imageNamed:@"deleteImage.png"];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        self.deleteImage.userInteractionEnabled = YES;
//        [self.deleteImage addGestureRecognizer:tap];
//        [self.contentView addSubview:self.deleteImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mImageView.frame = CGRectMake(0, 10, 80, 120);
    
//    self.deleteImage.frame = CGRectMake(73, 0, 14, 14);
}

- (void)setModel:(ImageModel *)model
{
    _model = model;
    [_mImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];

}

//-(void)tapAction:(UITapGestureRecognizer *)tap
//{
//    if (self.OnClickDelete) {
//        self.OnClickDelete(self.model);
//    }
//}
@end

//
//  ImageCollectionViewCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/27.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PublicModel.h"

@interface ImageCollectionViewCell ()

@end

@implementation ImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _mImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_mImageView];
//        int R = (arc4random() % 256) ;
//        int G = (arc4random() % 256) ;
//        int B = (arc4random() % 256) ;
//        _imageView.backgroundColor =  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _mImageView.frame = CGRectMake(0, 0, [_dic[@"width"] floatValue], [_dic[@"height"]floatValue]);
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    [_mImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],dic[@"imgurl"]]]  placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[PublicModel getImagePath],dic[@"imageUrl"]]);
}








@end

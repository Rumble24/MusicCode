//
//  ChooseBackgroundCell.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ChooseBackgroundCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ChooseBackgroundCell ()

@property (nonatomic, strong) UIImageView *chooseImage;

@property (nonatomic, strong) UIView *downView;

@end

@implementation ChooseBackgroundCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.chooseImage = [[UIImageView alloc]init];
        self.chooseImage.layer.cornerRadius = 5.0f;
        [self.chooseImage setContentMode:UIViewContentModeScaleAspectFill];
        self.chooseImage.clipsToBounds = YES;
        [self.contentView addSubview:self.chooseImage];
        
        _downView = [[UIView alloc]init];
        _downView.hidden = YES;
        _downView.backgroundColor = [PublicModel colorWithHexString:@"7FDBC1"];
        [self.chooseImage addSubview:_downView];
        
        UIImageView *iView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/3.0f - 30 - 17* kScale)/2.0f, 6.5f * kScale, 17* kScale, 12* kScale)];
        iView.image = [UIImage imageNamed:@"NowChoose.png"];
        [_downView addSubview:iView];
    }
    return self;
}

- (void)setModel:(ChooseBackModel *)model
{
    _model = model;
    
    [self.chooseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],_model.imgurl]]];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ChatBackgroundView"] isEqualToString:_model.imgurl])
    {
        _downView.hidden = NO;
    }
    else
    {
        _downView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.chooseImage.frame = CGRectMake(0, 0, ScreenWidth/3.0f - 30, ScreenWidth/3.0f - 30);
    
    _downView.frame = CGRectMake(0, ScreenWidth/3.0f - 30 - 25 * kScale, ScreenWidth/3.0f - 30, 25 * kScale);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        _downView.hidden = NO;
        [[NSUserDefaults standardUserDefaults] setObject:_model.imgurl forKey:@"ChatBackgroundView"];
    }
    else
    {
       _downView.hidden = YES;
    }
}









@end

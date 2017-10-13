//
//  LDMusicViewCell.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/17.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDMusicViewCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "LDPlayer.h"
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
@interface LDMusicViewCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *playImage;

@end

@implementation LDMusicViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createTableCellView];        
    }
    return self;
}

- (void)createTableCellView
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 89, ScreenWidth, 1)];
    lineView.backgroundColor = RGBA(138, 167, 160, 0.5f);
    [self.contentView addSubview:lineView];
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.layer.cornerRadius = 5;
    _headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headerImageView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [PublicModel colorWithHexString:@"#0BA67F"];
    [self.contentView addSubview:_titleLabel];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [PublicModel colorWithHexString:@"#8AA7A0"];
    [self.contentView addSubview:_nameLabel];
    
    _playImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 27 - 15, 65/2.0f, 27, 25)];
    _playImage.image = [UIImage imageNamed:@"VideoHeadset.png"];
    _playImage.hidden = YES;
    [self.contentView addSubview:_playImage];
}

- (void)setModel:(LDPlayMusicModel *)model
{
    _model = model;
    
    
    _titleLabel.text = model.title;
    _nameLabel.text = model.author;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"ArticleDefaultIcon"]];
    
    
    if([[LDPlayer sharePlayer].currentUrlStr isEqualToString:model.url])
    {
        _playImage.hidden = NO;
    }
    else
    {
        _playImage.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerImageView.frame = CGRectMake(10, 10, 70, 70);
    _titleLabel.frame = CGRectMake(110, 20, ScreenWidth - 150, 25);
    _nameLabel.frame = CGRectMake(110, 45, ScreenWidth - 150, 35);
}




@end

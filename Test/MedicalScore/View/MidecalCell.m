//
//  MidecalCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MidecalCell.h"
#import "PublicModel.h"
#import "MedicalModel.h"
#import "UIImageView+WebCache.h"
#import "ImageModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MidecalCell ()

@property (nonatomic, strong) UIView *BackView;
@property (nonatomic, strong) UIImageView *mImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MidecalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
        [self createTableHeaderViewCellView];
        
    }
    return self;
}

- (void)createTableHeaderViewCellView
{
    _BackView = [[UIView alloc]init];
    _BackView.layer.cornerRadius = 5;
    _BackView.layer.masksToBounds = YES;
    _BackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_BackView];
    
    _mImageView = [[UIImageView alloc]init];
    [_BackView addSubview:_mImageView];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor=[PublicModel colorWithHexString:@"#66B4EB"];
    _contentLabel.textAlignment = 
    _contentLabel.numberOfLines = 0;
    [_BackView addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor=[PublicModel colorWithHexString:@"#66B4EB"];
    [_BackView addSubview:_timeLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _BackView.frame = CGRectMake(5, 0, WIDTH - 10, 125);
    _mImageView.frame = CGRectMake(15, 15,95, 95);
    
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect namerect = [_contentLabel.text boundingRectWithSize:CGSizeMake(WIDTH - 10 - 15*3 - 120, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    _contentLabel.frame = CGRectMake(125, 15, WIDTH - 10 - 15*3 - 95, namerect.size.height);
    
    _timeLabel.frame = CGRectMake(125, 125 - 35, WIDTH - 10 - 15*3 - 95, 20);
}


- (void)setModel:(MedicalModel *)model
{
    _model = model;
//    NSLog(@"%@,%@",model.content,model.record_date);
    ImageModel *imageModel = model.list[0];
    [_mImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],imageModel.imgurl]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    _contentLabel.text = model.content;
    _timeLabel.text = model.record_date;
}


















@end

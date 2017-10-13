//
//  UploadInformationCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/19.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "UploadInformationCell.h"
#import "PublicModel.h"
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface UploadInformationCell ()

@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIImageView *mImageView;
@property (nonatomic, strong) UIImageView *deleteImage;
@property (nonatomic, strong) CAShapeLayer *border;

@end

@implementation UploadInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createWJTableViewCellView];

    }
    return self;
}

- (void)createWJTableViewCellView
{
    self.mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 12, ScreenWidth - 50, 185)];
    [self.mImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.mImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.mImageView];
    
    self.deleteImage = [[UIImageView alloc]init];
    self.deleteImage.image = [UIImage imageNamed:@"UploadInformationAddDelegate"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.deleteImage.userInteractionEnabled = YES;
    [self.deleteImage addGestureRecognizer:tap];
    [self.contentView addSubview:self.deleteImage];
    
    self.centerImage = [[UIImageView alloc]init];
    [self.mImageView addSubview:self.centerImage];
}

- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor blackColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@9, @4];

    [view.layer addSublayer:border];
    
    self.border = border;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.centerImage.frame = CGRectMake((ScreenWidth - 120) / 2.0f, 110/2, 70, 70);
    
    self.deleteImage.frame = CGRectMake(ScreenWidth - 25 - 10, 2, 20, 20);
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    if ([[dic allKeys]containsObject:@"image"])
    {
        self.centerImage.image = [UIImage imageNamed:@"UploadInformationAdd"];
        self.mImageView.image = nil;
        self.deleteImage.hidden = YES;
        self.mImageView.backgroundColor = [PublicModel colorWithHexString:@"#F9FAFB"];
        [self addBorderToLayer:self.mImageView];
    }
    else
    {
        self.mImageView.image = dic[@"asset"];
        if (self.border) {
            [self.border removeFromSuperlayer];
        }
        self.deleteImage.hidden = NO;
        self.mImageView.backgroundColor = [UIColor whiteColor];
        self.centerImage.image = [UIImage imageNamed:@"UploadInformationFinish"];
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.OnClickDelete) {
        self.OnClickDelete(self.dic);
    }
}
@end

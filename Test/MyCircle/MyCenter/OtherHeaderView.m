//
//  OtherHeaderView.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/29.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "OtherHeaderView.h"
#import "PublicModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation OtherHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createWJTableViewCellView];
    }
    return self;
}

- (void)createWJTableViewCellView
{
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH - 100)/2, 5, 100, 100)];
    self.headerImage.layer.cornerRadius = 50;
    self.headerImage.layer.masksToBounds = YES;
    [self.headerImage setContentMode:UIViewContentModeScaleAspectFill];
    self.headerImage.clipsToBounds = YES;
    self.headerImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headerImage];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 115, WIDTH, 20)];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    self.nameLabel.textAlignment = 1;
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    
    self.pregnancyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, WIDTH, 14)];
    self.pregnancyLabel.font = [UIFont systemFontOfSize:14];
    self.pregnancyLabel.textAlignment = 1;
    self.pregnancyLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.pregnancyLabel];
    
    self.articleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 158, WIDTH/2-5, 45)];
    self.articleLabel.font = [UIFont systemFontOfSize:43];
    self.articleLabel.textAlignment = 1;
    self.articleLabel.textColor = [PublicModel colorWithHexString:@"FA7B6E"];
    [self addSubview:self.articleLabel];
    
    UILabel *tieziLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 158 + 45, WIDTH/2-5, 15)];
    tieziLabel.font = [UIFont systemFontOfSize:13];
    tieziLabel.text = @"帖子";
    tieziLabel.textAlignment = 1;
    tieziLabel.textColor = [PublicModel colorWithHexString:@"FA7B6E"];
    [self addSubview:tieziLabel];
    
    self.praiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 + 10, 158,  WIDTH/2-5, 45)];
    self.praiseLabel.textColor = [PublicModel colorWithHexString:@"2C9FF1"];
    self.praiseLabel.font = [UIFont systemFontOfSize:43];
    self.praiseLabel.textAlignment = 1;
    [self addSubview:self.praiseLabel];

    UILabel *postLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 + 10, 158 + 45, WIDTH/2-5, 15)];
    postLabel.font = [UIFont systemFontOfSize:13];
    postLabel.text = @"点赞";
    postLabel.textAlignment = 1;
    postLabel.textColor = [PublicModel colorWithHexString:@"2C9FF1"];
    [self addSubview:postLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((WIDTH - 1)/2, 165, 1, 30)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
}
@end

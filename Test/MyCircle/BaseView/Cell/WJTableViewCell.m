//
//  WJTableViewCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GetPostModel.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WJTableViewCell ()

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *reLabel;
@property (nonatomic, strong) UILabel *jingLabel;
@property (nonatomic, strong) UILabel *dingLabel;

@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UIImageView *typeImage;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UIImageView *contentImage1;

@property (nonatomic, strong) UIImageView *contentImage2;

@property (nonatomic, strong) UIImageView *contentImage3;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *viewLabel;

@property (nonatomic, strong) UIButton *zanBut;

@property (nonatomic, strong) UIButton *commentBut;

@property (nonatomic, strong) NSArray *imgArray;

@end

@implementation WJTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.isCanClickHeader = YES;
        
        [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
        [SVProgressHUD setMinimumDismissTimeInterval:0.5f];

        [self createWJTableViewCellView];
        
    }
    return self;
}

- (void)createWJTableViewCellView
{
    self.contentView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    self.backImage = [[UIImageView alloc]init];
    self.backImage.layer.cornerRadius = 5;
    self.backImage.layer.masksToBounds = YES;
    self.backImage.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backImage];
    
    self.headerView = [[UIImageView alloc]init];
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.masksToBounds = YES;
    [self.headerView setContentMode:UIViewContentModeScaleAspectFill];
    self.headerView.clipsToBounds = YES;
    [self.contentView addSubview:self.headerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap];
    
    self.name = [[UILabel alloc]init];
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.textColor=[PublicModel colorWithHexString:@"#66B4EB"];
    [self.contentView addSubview:self.name];
    
    self.title = [[UILabel alloc]init];
    self.title.font = [UIFont systemFontOfSize:18];
    self.title.textColor = [PublicModel colorWithHexString:@"#333333"];
    self.title.numberOfLines = 0;
    [self.title sizeToFit];
    [self.contentView addSubview:self.title];
    
    self.reLabel = [[UILabel alloc]init];
    self.reLabel.backgroundColor =[UIColor redColor];
    self.reLabel.text = @"热";
    self.reLabel.textAlignment = NSTextAlignmentCenter;
    self.reLabel.font = [UIFont systemFontOfSize:14];
    self.reLabel.layer.cornerRadius = 3;
    self.reLabel.textColor = [UIColor whiteColor];
    self.reLabel.layer.masksToBounds = YES;
    [self.title addSubview:self.reLabel];
    
    self.jingLabel = [[UILabel alloc]init];
    self.jingLabel.backgroundColor = [PublicModel colorWithHexString:@"#e5c645"];
    self.jingLabel.font = [UIFont systemFontOfSize:14];
    self.jingLabel.layer.cornerRadius = 3;
    self.jingLabel.layer.masksToBounds = YES;
    self.jingLabel.text = @"精";
    self.jingLabel.textColor = [UIColor whiteColor];
    self.jingLabel.textAlignment = NSTextAlignmentCenter;
    [self.title addSubview:self.jingLabel];
    
    self.dingLabel = [[UILabel alloc]init];
    self.dingLabel.backgroundColor = [PublicModel colorWithHexString:@"#74baec"];
    self.dingLabel.layer.cornerRadius = 3;
    self.dingLabel.layer.masksToBounds = YES;
    self.dingLabel.textColor = [UIColor whiteColor];
    self.dingLabel.font = [UIFont systemFontOfSize:14];
    self.dingLabel.text = @"顶";
    self.dingLabel.textAlignment = NSTextAlignmentCenter;
    [self.title addSubview:self.dingLabel];
    
    self.typeImage = [[UIImageView alloc]init];
    UIImage *typeimage = [UIImage imageNamed:@"postType.png"];
    NSInteger leftCapWidth = typeimage.size.width * 0.5f;
    NSInteger topCapHeight = typeimage.size.height * 0.5f;
    self.typeImage.image = [typeimage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.contentView addSubview:self.typeImage];
    
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.font = [UIFont systemFontOfSize:10];
    self.typeLabel.textAlignment = NSTextAlignmentRight;
    self.typeLabel.textColor=[PublicModel colorWithHexString:@"#ffbacf"];
    [self.contentView addSubview:self.typeLabel];
    
    self.content = [[UILabel alloc]init];
    self.content.font = [UIFont systemFontOfSize:15];
    self.content.numberOfLines = 0;
    self.content.textColor=[PublicModel colorWithHexString:@"#648398"];
    [self.contentView addSubview:self.content];
    
    self.contentImage1 = [[UIImageView alloc]init];
    [self.contentImage1 setContentMode:UIViewContentModeScaleAspectFill];
    self.contentImage1.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImage1];
    
    self.contentImage2 = [[UIImageView alloc]init];
    [self.contentImage2 setContentMode:UIViewContentModeScaleAspectFill];
    self.contentImage2.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImage2];
    
    self.contentImage3 = [[UIImageView alloc]init];
    [self.contentImage3 setContentMode:UIViewContentModeScaleAspectFill];
    self.contentImage3.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImage3];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [self.contentView addSubview:self.timeLabel];
    
    self.viewLabel = [[UILabel alloc]init];
    self.viewLabel.font = [UIFont systemFontOfSize:12];
    self.viewLabel.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [self.contentView addSubview:self.viewLabel];
    
    self.zanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zanBut.titleLabel.font = [UIFont systemFontOfSize: 12];
    [self.zanBut addTarget:self action:@selector(dianZan:) forControlEvents:1<<6];
    [self.zanBut setTitleColor:[PublicModel colorWithHexString:@"#648398"] forState:UIControlStateNormal];
    [self.zanBut setImage:[UIImage imageNamed:@"xiaodezan.png"] forState:UIControlStateNormal];
    self.zanBut.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.zanBut];
    
    self.commentBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBut.titleLabel.font = [UIFont systemFontOfSize: 12];
    [self.commentBut setTitleColor:[PublicModel colorWithHexString:@"#648398"] forState:UIControlStateNormal];
    [self.commentBut setImage:[UIImage imageNamed:@"xiaodepl.png"] forState:UIControlStateNormal];
    [self.commentBut addTarget:self action:@selector(commentButtonAction) forControlEvents:1<<6];
    self.commentBut.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.commentBut];
}


- (void)setModel:(GetPostModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"DefaultHead.png"]];
    
    self.imgArray= [model.images componentsSeparatedByString:@","];
    
    self.content.text = model.content;

    if(_imgArray.count == 0)
    {
        self.contentImage1.hidden = YES;
        self.contentImage2.hidden = YES;
        self.contentImage3.hidden = YES;
    }
    else if (_imgArray.count == 1)
    {
        NSString *str =self.imgArray[0];
        if ([PublicModel isBlankString:str])
        {
            self.contentImage1.hidden = YES;
            self.contentImage2.hidden = YES;
            self.contentImage3.hidden = YES;
        }
        else
        {
            self.contentImage1.hidden = NO;
            self.contentImage2.hidden = YES;
            self.contentImage3.hidden = YES;
            NSArray *image1 = [self.imgArray[0] componentsSeparatedByString:@"-"];
            [self.contentImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getBigImagePath],image1[0]]]  placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        }
    }
    else if(_imgArray.count == 2)
    {
        self.contentImage1.hidden = NO;
        self.contentImage2.hidden = NO;
        self.contentImage3.hidden = YES;
        NSArray *image1 = [self.imgArray[0] componentsSeparatedByString:@"-"];
        [self.contentImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getMiddenImagePath],image1[0]]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        NSArray *image2 = [self.imgArray[1] componentsSeparatedByString:@"-"];
        [self.contentImage2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getMiddenImagePath],image2[0]]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    }
    else if(_imgArray.count >= 3)
    {
        self.contentImage1.hidden = NO;
        self.contentImage2.hidden = NO;
        self.contentImage3.hidden = NO;
        NSArray *image1 = [self.imgArray[0] componentsSeparatedByString:@"-"];
        [self.contentImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],image1[0]]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        NSArray *image2 = [self.imgArray[1] componentsSeparatedByString:@"-"];
        [self.contentImage2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],image2[0]]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        NSArray *image3 = [self.imgArray[2] componentsSeparatedByString:@"-"];
        [self.contentImage3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],image3[0]]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    }
    
    self.name.text = model.member_name;
    
    if ([PublicModel isBlankString:model.community_name])
    {
        self.typeImage.hidden = YES;
        self.typeLabel.hidden = YES;
    }
    else
    {
        self.typeImage.hidden = NO;
        self.typeLabel.hidden = NO;
        self.typeLabel.text = model.community_name;
    }
    
    if (model.is_highlight.integerValue  == 0){
        self.jingLabel.hidden = YES;
    }else{
        self.jingLabel.hidden = NO;
    }
    if (model.is_hot.integerValue  == 0){
        self.reLabel.hidden = YES;
    }else{
        self.reLabel.hidden = NO;
    }
    if (model.is_top.integerValue == 0){
        self.dingLabel.hidden = YES;
    }else{
        self.dingLabel.hidden = NO;
    }
    
    if ([self theNumberOfStatus] == 0) {
        self.title.text = model.title;
    }else if([self theNumberOfStatus] == 1){
        self.title.text = [NSString stringWithFormat:@"     %@",model.title];
    }else if([self theNumberOfStatus] == 2){
        self.title.text = [NSString stringWithFormat:@"         %@",model.title];
    }else if([self theNumberOfStatus] == 3){
        self.title.text = [NSString stringWithFormat:@"             %@",model.title];
    }
    
    self.timeLabel.text = model.publish_time;
    
    self.viewLabel.text = [NSString stringWithFormat:@"浏览量 %@",[PublicModel getCurrentNumber:model.views]];
    
    [self.zanBut setTitle:[PublicModel getCurrentNumber:model.zan_count] forState:UIControlStateNormal];
    
    [self.commentBut setTitle:[PublicModel getCurrentNumber:model.reply_count]  forState:UIControlStateNormal];
    
    if(self.model.is_zan == 0)
    {
        [self.zanBut setImage:[UIImage imageNamed:@"xiaodezan.png"] forState:UIControlStateNormal];
    }
    else if(self.model.is_zan == 1)
    {
        [self.zanBut setImage:[UIImage imageNamed:@"xiaodezanicon.png"] forState:UIControlStateNormal];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float cellY = 0;
    self.backImage.frame = CGRectMake(5, 0, WIDTH - 10, self.contentView.frame.size.height - 10);
    
    self.headerView.frame = CGRectMake(15, 15, 40, 40);
    
    self.name.frame = CGRectMake(63, 15, WIDTH - 78, 13);
    
    NSDictionary *typedic = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
    CGRect typerect = [self.typeLabel.text boundingRectWithSize:CGSizeMake(WIDTH, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:typedic context:nil];
    self.typeLabel.frame = CGRectMake(WIDTH - (typerect.size.width + 24), 15, typerect.size.width + 10, 14);
    self.typeImage.frame = CGRectMake(WIDTH - (typerect.size.width + 22), 15, typerect.size.width + 8, 14);
    
    self.timeLabel.frame = CGRectMake(63, 15+20, WIDTH - 63 - 20,20);
    
    cellY = 45 + 15;
    
    NSDictionary *titledic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect titlerect = [self.title.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:titledic context:nil];
        
    float  LY = 2;
    if(titlerect.size.height > 20)
    {
        self.title.frame = CGRectMake(15, cellY, WIDTH - 30, 43);
        cellY = 43 + cellY + 10;
        LY = 2;

    }else{
        self.title.frame = CGRectMake(15, cellY, WIDTH - 30, titlerect.size.height);
        cellY = titlerect.size.height + cellY + 10;
    }
    

    if (self.dingLabel.isHidden == NO)
    {
        if(self.jingLabel.isHidden == NO)
        {
            if (self.reLabel.isHidden == NO) {
                self.dingLabel.frame = CGRectMake(0, LY, 18, 18);
                self.jingLabel.frame = CGRectMake(20, LY, 18, 18);
                self.reLabel.frame = CGRectMake(40, LY, 18, 18);
            }else{
                self.dingLabel.frame = CGRectMake(0, LY, 18, 18);
                self.jingLabel.frame = CGRectMake(20, LY, 18, 18);
            }
        }
        else
        {
            if (self.reLabel.isHidden == NO) {
                self.dingLabel.frame = CGRectMake(0, LY, 18, 18);
                self.reLabel.frame = CGRectMake(20, LY, 18, 18);
            }else{
                self.dingLabel.frame = CGRectMake(0, LY, 18, 18);
            }
        }
    }
    else
    {
        if(self.jingLabel.isHidden == NO)
        {
            if (self.reLabel.isHidden == NO) {
                self.jingLabel.frame = CGRectMake(0, LY, 18, 18);
                self.reLabel.frame = CGRectMake(20, LY, 18, 18);
            }else{
                self.jingLabel.frame = CGRectMake(0, LY, 18, 18);
            }
        }
        else
        {
            if (self.reLabel.isHidden == NO) {
                self.reLabel.frame = CGRectMake(0, LY, 18, 18);
            }
        }
    }
    
    if(_imgArray.count == 0)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.content.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
        cellY = cellY + rect.size.height + 10;
    }
    else if (_imgArray.count == 1)
    {
        NSString *str =self.imgArray[0];
        if ([PublicModel isBlankString:str])
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.content.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
            cellY = cellY + rect.size.height + 10;
        }
        else
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.model.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
            cellY = cellY + rect.size.height + 10;
            self.contentImage1.frame = CGRectMake(15, cellY, WIDTH - 30, 165);
            NSLog(@"%@",self.content.text);
            cellY = cellY + 175;
        }
    }
    else if(_imgArray.count == 2)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.model.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
        cellY = cellY + rect.size.height + 10;
        self.contentImage1.frame = CGRectMake(15, cellY, (WIDTH - 40)/3, (WIDTH - 40)/3);
        self.contentImage2.frame = CGRectMake(15 + (WIDTH - 40)/3 +5, cellY, (WIDTH - 40)/3, (WIDTH - 40)/3);
        cellY = cellY + (WIDTH - 40)/3 + 5;
    }
    else if(_imgArray.count >= 3)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.content.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
        cellY = cellY + rect.size.height + 10;
        self.contentImage1.frame = CGRectMake(15, cellY, (WIDTH - 40)/3, (WIDTH - 40)/3);
        self.contentImage2.frame = CGRectMake(15 + (WIDTH - 40)/3 + 5, cellY, (WIDTH - 40)/3, (WIDTH - 40)/3);
        self.contentImage3.frame = CGRectMake(15 + (WIDTH - 40)/3 * 2 + 10, cellY, (WIDTH - 40)/3, (WIDTH - 40)/3);
        cellY = cellY + (WIDTH - 40)/3 + 5;
    }

    NSDictionary *viewdic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect viewrect = [self.viewLabel.text boundingRectWithSize:CGSizeMake(WIDTH - 63 - 15, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:viewdic context:nil];
    self.viewLabel.frame = CGRectMake(63 + 135, cellY, viewrect.size.width, 15);
    
    self.zanBut.frame = CGRectMake(WIDTH - 115, cellY, 50, 15);
    
    self.commentBut.frame = CGRectMake(WIDTH - 65, cellY, 50, 15);
}


#pragma mark - 点赞
- (void)dianZan:(UIButton *)button
{
    if([PublicModel isBlankString:[PublicModel getUserid]] || [PublicModel isBlankString:[PublicModel getToken]])
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = [PublicModel getUserid];
    dic[@"token"] = [PublicModel getToken];
    dic[@"post_id"] = self.model.id;
    dic[@"type"] = @(1);
    
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    if(self.model.is_zan == 0)
    {
        [WJNetTool POST:[PublicModel getDianZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            self.model.is_zan = 1;
            self.model.zan_count += 1;
            [UIView animateWithDuration:0.1f animations:^{
                self.zanBut.frame = CGRectMake(WIDTH - 115, self.zanBut.frame.origin.y, 60, 18);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1f animations:^{
                    self.zanBut.frame = CGRectMake(WIDTH - 115, self.zanBut.frame.origin.y, 50, 15);
                } completion:^(BOOL finished) {
                    [self.zanBut setImage:[UIImage imageNamed:@"xiaodezanicon.png"] forState:UIControlStateNormal];
                    [self.zanBut setTitle:[NSString stringWithFormat:@"%ld",self.model.zan_count] forState:UIControlStateNormal];
                }];
            }];
        } failure:^(NSError *error) {
        }];
    }
    else if(self.model.is_zan == 1)
    {
        [WJNetTool POST:[PublicModel getDeletePostZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            self.model.is_zan = 0;
            self.model.zan_count -= 1;

            [UIView animateWithDuration:0.1f animations:^{
                self.zanBut.frame = CGRectMake(WIDTH - 115, self.zanBut.frame.origin.y, 60, 18);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1f animations:^{
                    self.zanBut.frame = CGRectMake(WIDTH - 115, self.zanBut.frame.origin.y, 50, 15);
                } completion:^(BOOL finished) {
                   [self.zanBut setImage:[UIImage imageNamed:@"xiaodezan.png"] forState:UIControlStateNormal];
                    [self.zanBut setTitle:[NSString stringWithFormat:@"%ld",self.model.zan_count] forState:UIControlStateNormal];
                }];
            }];
        } failure:^(NSError *error) {
             [SVProgressHUD showImage:NULL status:@"取消点赞失败~"];
        }];
    }
}

#pragma mark - 点击头像进入关注界面
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.isCanClickHeader)
    {
        NSLog(@"WJTableViewCell       点击了头像");
        if (self.OnClickHeader) {
            self.OnClickHeader(self.model.member_id);
        }
    }
    else
    {
        NSLog(@"头像不可以点击");
    }
}
- (void)commentButtonAction
{
    if (self.OnClickComment) {
        self.OnClickComment();
    }
}


- (NSInteger)theNumberOfStatus
{
    NSInteger n = 0;
    if (self.model.is_highlight.integerValue == 1) {
        n += 1;
    }
    if (self.model.is_top.integerValue == 1) {
        n += 1;
    }
    if (self.model.is_hot.integerValue == 1) {
        n += 1;
    }
    return n;
}

@end

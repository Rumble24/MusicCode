//
//  TwoPlHeaderCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/5.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//
#import "TableViewCell.h"
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "PLModel.h"
#import "WJNetTool.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "TwoPlHeaderCell.h"

@interface TwoPlHeaderCell ()
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *zanBut;
@property (nonatomic, strong) UIButton *plBut;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *lineImage;

@end

@implementation TwoPlHeaderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createTableHeaderViewCellView];
        
    }
    return self;
}

- (void)createTableHeaderViewCellView
{
    _headerView = [[UIImageView alloc]init];
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.masksToBounds = YES;
    [self.headerView setContentMode:UIViewContentModeScaleAspectFill];
    self.headerView.clipsToBounds = YES;
    [self.contentView addSubview:self.headerView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap];
    
    
    _name = [[UILabel alloc]init];
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.textColor=[PublicModel colorWithHexString:@"#66B4EB"];
    [self.contentView addSubview:_name];
    
    _time = [[UILabel alloc]init];
    _time.font = [UIFont systemFontOfSize:13];
    _time.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [self.contentView addSubview:_time];
    
    _zanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _zanBut.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _zanBut.titleLabel.font = [UIFont systemFontOfSize: 13];
    [_zanBut setTitleColor:[PublicModel colorWithHexString:@"#648398"] forState:UIControlStateNormal];
    [_zanBut addTarget:self action:@selector(OnClickZan) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_zanBut];
    
    _plBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _plBut.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _plBut.titleLabel.font = [UIFont systemFontOfSize: 13];
    [_plBut setTitleColor:[PublicModel colorWithHexString:@"#648398"] forState:UIControlStateNormal];
    [_plBut addTarget:self action:@selector(OnClickPL) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_plBut];
    
    _content = [[UILabel alloc]init];
    _content.numberOfLines = 0;
    _content.font = [UIFont systemFontOfSize:15];
    _content.textColor=[PublicModel colorWithHexString:@"#648398"];
    [self.contentView addSubview:_content];
    
    _lineImage = [[UIImageView alloc]init];
    _lineImage.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.contentView addSubview:_lineImage];
}

- (void)setModel:(PLModel *)model
{
    _model = model;
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],model.imgurl]]  placeholderImage:[UIImage imageNamed:@"DefaultHead.png"]];
    self.name.text = model.member_name;
    self.time.text = model.re_time;
    [self.plBut setTitle:[NSString stringWithFormat:@"%ld",model.reply_count] forState:UIControlStateNormal];
    [self.zanBut setTitle:[NSString stringWithFormat:@"%ld",model.zan_count] forState:UIControlStateNormal];
    
    self.content.text = model.content;
    
    if(model.is_zan == 0)
    {
        [_zanBut setImage:[UIImage imageNamed:@"xiaodezan.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_zanBut setImage:[UIImage imageNamed:@"xiaodezanicon.png"] forState:UIControlStateNormal];
    }
    
    if(model.is_reply == 0)
    {
        [_plBut setImage:[UIImage imageNamed:@"contentPL.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_plBut setImage:[UIImage imageNamed:@"plicon.png"] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float cellY = 0;
    self.headerView.frame = CGRectMake(15, 15, 40, 40);
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect namerect = [self.name.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    self.name.frame = CGRectMake(63, 15, namerect.size.width, 13);
    self.time.frame = CGRectMake(63, 55 - 15, WIDTH-100, 15);
    
    NSDictionary *pldic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect plrect = [self.plBut.titleLabel.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:pldic context:nil];
    self.plBut.frame = CGRectMake(WIDTH - 15 - plrect.size.width - 40, 55- 20, plrect.size.width + 40, 15);
    
    NSDictionary *zandic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect zanrect = [self.zanBut.titleLabel.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:zandic context:nil];
    self.zanBut.frame = CGRectMake(WIDTH - 15 - plrect.size.width - zanrect.size.width - 85, 55- 20, zanrect.size.width + 40, 15);
    
    cellY = 75;
    
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.content.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.content.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
    cellY = cellY + 15 + rect.size.height;
    
    _lineImage.frame = CGRectMake(15, cellY, WIDTH - 30, 1);
}


#pragma mark - 点击头像进入关注界面
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"TwoPlHeaderCell 点击了头像");
    if (self.OnClickHeader) {
        self.OnClickHeader(self.model.member_id);
    }
}

- (void)OnClickZan
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
    dic[@"post_id"] = self.model.post_id;
    dic[@"type"] = @(2);
    dic[@"reply_id"] =  self.model.id;
    
    NSString *dicStr = [PublicModel dictionaryToJson:dic];
    NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
    if(self.model.is_zan == 0)
    {
        [WJNetTool POST:[PublicModel getDianZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [_zanBut setImage:[UIImage imageNamed:@"xiaodezanicon.png"] forState:UIControlStateNormal];
            self.model.is_zan = 1;
            self.model.zan_count += 1;
            [_zanBut setTitle:[PublicModel getCurrentNumber:self.model.zan_count] forState:UIControlStateNormal];
        } failure:^(NSError *error) {
//            NSLog(@"点赞失败=%@",error.domain);
        }];
    }
    else if(self.model.is_zan == 1)
    {
        [WJNetTool POST:[PublicModel getDeletePostZanURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [_zanBut setImage:[UIImage imageNamed:@"xiaodezan.png"] forState:UIControlStateNormal];
            self.model.is_zan = 0;
            self.model.zan_count -= 1;
            [_zanBut setTitle:[PublicModel getCurrentNumber:self.model.zan_count] forState:UIControlStateNormal];
        } failure:^(NSError *error) {
//            NSLog(@"取消点赞失败=%@",error.domain);
        }];
    }
}

- (void)OnClickPL
{
    if (self.OnClickComment) {
        self.OnClickComment(self.model.member_id,self.model.id,self.model.member_name);
    }
}
@end

//
//  MyDzCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyDzCell.h"
#import "PublicModel.h"
#import "MyDzModel.h"
#import "UIImageView+WebCache.h"
#import "TTTAttributedLabel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MyDzCell ()<TTTAttributedLabelDelegate>
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *plContent;
@property (nonatomic, strong) UIView *tieziView;
@property (nonatomic, strong) UIImageView *tieziImage;
@property (nonatomic, strong) UILabel *tieziTitle;
@property (nonatomic, strong) UILabel *tiezicontent;
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation MyDzCell



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
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 5)];
    _lineView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.contentView addSubview:_lineView];
    
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
    
    self.plContent = [[UILabel alloc]init];
    self.plContent.numberOfLines = 0;
    self.plContent.font = [UIFont systemFontOfSize:15];
    self.plContent.textColor=[PublicModel colorWithHexString:@"#648398"];
    [self.contentView addSubview:self.plContent];
    
    _tieziView = [[UIView alloc]init];
    _tieziView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.contentView addSubview:_tieziView];
    
    _tieziImage = [[UIImageView alloc]init];
    [_tieziImage setContentMode:UIViewContentModeScaleAspectFill];
    _tieziImage.clipsToBounds = YES;
    [_tieziView addSubview:_tieziImage];
    
    _tieziTitle = [[UILabel alloc]init];
    _tieziTitle.font = [UIFont systemFontOfSize:15];
    _tieziTitle.textColor=[PublicModel colorWithHexString:@"#648398"];
    [_tieziView addSubview:_tieziTitle];
    
    _tiezicontent = [[UILabel alloc]init];
    _tiezicontent.font = [UIFont systemFontOfSize:13];
    _tiezicontent.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [_tieziView addSubview:_tiezicontent];
    
    _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
    _aLable.lineBreakMode = NSLineBreakByTruncatingTail;
    _aLable.font = [UIFont systemFontOfSize:13];
    _aLable.delegate = self;
    _aLable.linkAttributes = @{NSForegroundColorAttributeName:[PublicModel colorWithHexString:@"#66B4EB"],NSUnderlineStyleAttributeName:@(1)};
    _aLable.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(1)};
    [self.contentView addSubview:_aLable];
}

- (void)setModel:(MyDzModel *)model
{
    _model = model;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],model.imgurl]] placeholderImage:[UIImage imageNamed:@"DefaultHead.png"]];
    
    self.name.text = model.member_name;
    self.time.text = model.re_time;
    self.plContent.text = model.content;
    
    self.imgArray= [model.images componentsSeparatedByString:@","];
    
    if(_imgArray.count == 0)
    {
        _tieziImage.hidden = YES;
    }
    else if (_imgArray.count == 1)
    {
        NSString *str =self.imgArray[0];
        if ([PublicModel isBlankString:str])
        {
            _tieziImage.hidden = YES;
        }
        else
        {
            _tieziImage.hidden = NO;
            NSArray *image1 = [self.imgArray[0] componentsSeparatedByString:@"-"];
            [_tieziImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],image1[0]]]];
        }
    }
    else
    {
        _tieziImage.hidden = NO;
        NSArray *image1 = [self.imgArray[0] componentsSeparatedByString:@"-"];
        [_tieziImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicModel getSmallImagePath],image1[0]]]];
    }
    
    _tieziTitle.text = model.title;
    _tiezicontent.text = model.post_content;
    
    if ([PublicModel isBlankString:model.to_member_name])
    {
        _aLable.hidden = YES;
    }
    else
    {
        _aLable.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"%@:回复%@:%@",model.member_name,model.to_member_name,model.to_content];
        NSUInteger length = model.member_name.length;
        
//        NSLog(@"%@",text);
        
        NSRange nameRange = {0,(int)length};
        
        NSRange toNameRange = {(int)length + 3,(int)model.to_member_name.length};
        
        [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            
            
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:13];
            
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            
            if (font) {
                
                {
                    //文字颜色
                    [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                                    value:[UIColor redColor]
                                                    range:nameRange];
                    //文字颜色
                    [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                                    value:[UIColor redColor]
                                                    range:toNameRange];
                    CFRelease(font);
                    
                }
            }
            return mutableAttributedString;
        }];
        
        [self.aLable addLinkToAddress:@{@"userId":model.member_id,@"name":model.member_name}  withRange:nameRange];
        
        [self.aLable addLinkToAddress:@{@"userId":model.to_member_id,@"name":model.to_member_name}  withRange:toNameRange];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _lineView.frame = CGRectMake(0, 0, WIDTH, 5);
    
    float cellY = 5 + 15;
    self.headerView.frame = CGRectMake(15, cellY, 40, 40);
    
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect namerect = [self.name.text boundingRectWithSize:CGSizeMake(10000, 13) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    self.name.frame = CGRectMake(63, cellY, namerect.size.width, 13);
    
    self.time.frame = CGRectMake(63, 55 - 10, WIDTH-100, 15);
    
    cellY  = cellY + 40 + 10;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.plContent.text boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.plContent.frame = CGRectMake(15, cellY, WIDTH - 30, rect.size.height);
    cellY = cellY + rect.size.height + 10;
    
    if (![PublicModel isBlankString:self.model.to_member_name])
    {
        _aLable.frame = CGRectMake(15,cellY, WIDTH - 30, 23);
        cellY = cellY + 23;
    }
    
    self.tieziView.frame = CGRectMake(15, cellY, WIDTH - 30, 70);
    
    if (_imgArray.count == 0)
    {
        self.tieziTitle.frame = CGRectMake(10, 10, WIDTH - 50, 15);
        self.tiezicontent.frame = CGRectMake(10, 30, WIDTH - 50, 70 - 25 - 10 - 5);
    }
    else if(_imgArray.count == 1)
    {
        NSString *str =self.imgArray[0];
        if ([PublicModel isBlankString:str])
        {
            self.tieziTitle.frame = CGRectMake(10, 10, WIDTH - 50, 15);
            self.tiezicontent.frame = CGRectMake(10, 30, WIDTH - 50, 70 - 25 - 10 - 5);
        }
        else
        {
            self.tieziImage.frame = CGRectMake(0, 0, 70, 70);
            self.tieziTitle.frame = CGRectMake(80, 10, WIDTH - 120, 15);
            self.tiezicontent.frame = CGRectMake(80, 30, WIDTH - 120, 70 - 25 - 10 - 5);
        }
    }
    else
    {
        self.tieziImage.frame = CGRectMake(0, 0, 70, 70);
        self.tieziTitle.frame = CGRectMake(80, 10, WIDTH - 120, 15);
        self.tiezicontent.frame = CGRectMake(80, 30, WIDTH - 120, 70 - 25 - 10 - 5);
    }
    
    
}

#pragma mark - 点击头像进入关注界面
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了头像");
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    NSLog(@"addressClick%@",addressComponents);
}
@end

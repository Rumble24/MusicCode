//
//  TwoPlCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/5.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "TwoPlCell.h"
#import "TwoPLModel.h"
#import "TTTAttributedLabel.h"
#import "PublicModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TwoPlCell ()<TTTAttributedLabelDelegate>
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@property (nonatomic, strong) UIImageView *lineImage;
@end

@implementation TwoPlCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
        _aLable.numberOfLines = 0;
        _aLable.lineBreakMode = NSLineBreakByTruncatingTail;
        _aLable.font = [UIFont systemFontOfSize:13];
        _aLable.delegate = self;
        _aLable.linkAttributes = @{NSForegroundColorAttributeName:[PublicModel colorWithHexString:@"#66B4EB"],NSUnderlineStyleAttributeName:@(1)};
        _aLable.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(1)};
        [self.contentView addSubview:_aLable];
        
        _lineImage = [[UIImageView alloc]init];
        _lineImage.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
        [self.contentView addSubview:_lineImage];
    }
    return self;
}


- (void)setModel:(TwoPLModel *)model
{
    _model = model;
    
    NSString *text = [NSString stringWithFormat:@"%@:回复%@:%@",model.member_name,model.to_member_name,model.content];
    NSUInteger length = model.member_name.length;
    
//    NSLog(@"%@",text);
    
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDictionary *pldic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect plrect = [self.aLable.text boundingRectWithSize:CGSizeMake(WIDTH - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:pldic context:nil];
    _aLable.frame = CGRectMake(10, 10, WIDTH - 20, plrect.size.height);
    
    _lineImage.frame = CGRectMake(15, 10 + plrect.size.height + 9, WIDTH - 30, 1);
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
//    NSLog(@"addressClick%@",addressComponents);
}



@end

//
//  XinShuaiTextController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiTextController.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createScrollerView];
}


- (void)createScrollerView
{
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64 - 200 - 50);
    
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
    NSString *text = @"     先天性心脏病是先天性畸形中最常见的一类，约占各种先天畸形的28%，指在胚胎发育时期由于心脏及大血管的形成障碍或发育异常而引起的解剖结构异常，或出生后应自动关闭的通道未能闭合（在胎儿属正常）的情形。先天性心脏病发病率不容小视，占出生活婴的0.4%～1%，这意味着我国每年新增先天性心脏病患者15～20万。\n       少部分先天性心脏病在5岁前有自愈的机会，另外有少部分患者畸形轻微、对循环功能无明显影响，而无需任何治疗，但大多数患者需手术治疗校正畸形。\n病因\n      一般认为妊娠早期（5～8周）是胎儿心脏发育最重要的时期，先天性心脏病发病原因很多，遗传因素仅占8%左右，而占92%的绝大多数则为环境因素造成，如妇女妊娠时服用药物、感染病毒、环境污染、射线辐射等都会使胎儿心脏发育异常。尤其妊娠前3个月感染风疹病毒，会使孩子患上先天性心脏病的风险急剧增加。\n临床表现\n       先天性心脏病的种类很多，其临床表现主要取决于畸形的大小和复杂程度。复杂而严重的畸形在出生后不久即可出现严重症状，甚至危及生命。需要注意的是一些简单的畸形如室间隔缺损、动脉导管未闭等，早期可以没有明显症状，但疾病仍然会潜在地发展加重，需要及时诊治，以免失去手术机会。主要症状有：\n       1．经常感冒、反复呼吸道感染，易患肺炎。\n       2．生长发育差、消瘦、多汗。\n       3．吃奶时吸吮无力、喂奶困难，或婴儿拒食、呛咳，平时呼吸急促。\n       4．儿童诉说易疲乏、体力差。\n       5．口唇、指甲青紫或者哭闹或活动后青紫，杵状指趾（甲床如锤子一样隆起）。\n       6．喜欢蹲踞、晕厥、咯血。\n       7．听诊发现心脏有杂音。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                     options:NSCaseInsensitiveSearch];
        
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        
        if (font) {
            {
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange1];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange2];
            }
        }
        
        
        //高度计算
        size = [TTTAttributedLabel sizeThatFitsAttributedString:mutableAttributedString
                                                withConstraints:CGSizeMake(SCREEN_WIDTH - 20, CGFLOAT_MAX)
                                         limitedToNumberOfLines:0];
        return mutableAttributedString;
    }];
    
    self.aLable.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, size.height);
    
    [self.scrollerView addSubview:self.aLable];
    
    self.scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, size.height);
}


- (TTTAttributedLabel *)aLable
{
    if (!_aLable)
    {
        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 200)];
        _aLable.lineBreakMode = NSLineBreakByWordWrapping;
        _aLable.numberOfLines = 0;
        _aLable.lineSpacing = 10;
        _aLable.textColor = [PublicModel colorWithHexString:@"52BEA4"];
        _aLable.font = [UIFont systemFontOfSize:13];
    }
    return _aLable;
}
@end


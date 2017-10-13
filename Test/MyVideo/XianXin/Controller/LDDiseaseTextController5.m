//
//  LDDiseaseTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseTextController5.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseTextController5 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation LDDiseaseTextController5

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
    
    NSString *text = @"        苯丙酮尿症（PKU）是一种常见的氨基酸代谢病，是由于苯丙氨酸（PA）代谢途径中的酶缺陷，使得苯丙氨酸不能转变成为酪氨酸，导致苯丙氨酸及其酮酸蓄积，并从尿中大量排出。本病在遗传性氨基酸代谢缺陷疾病中比较常见，其遗传方式为常染色体隐性遗传。表现不均一，主要临床特征为智力低下、精神神经症状、湿疹、皮肤抓痕征及色素脱失和鼠气味等、脑电图异常。如果能得到早期诊断和早期治疗，则前述表现可不发生，智力正常，脑电图异常也可得到恢复。\n病因\n        苯丙氨酸是人体必需的氨基酸之一。正常人每日需要的摄入量约为200～500毫克，其中1/3供合成蛋白，2/3则通过肝细胞中苯丙氨酸羟化酶（PAH）的转化为酪氨酸，以合成甲状腺素、肾上腺素和黑色素等。苯丙氨酸转化为酪氨酸的过程中，除需PAH外，还必须有四氢生物蝶呤（BH4）作为辅酶参与。基因突变有可能造成相关酶的活性缺陷，致使苯丙氨酸发生异常累积。\n临床表现\n        生长发育迟缓\n        除躯体生长发育迟缓外，主要表现在智力发育迟缓。表现在智商低于同龄正常儿，生后4～9个月即可出现。重型者智商低于50，语言发育障碍尤为明显，这些表现提示大脑发育障碍。\n        神经精神表现\n        由于有脑萎缩而有小脑畸形，反复发作的抽搐，但随年龄增大而减轻。肌张力增高，反射亢进。常有兴奋不安、多动和异常行为。\n        皮肤毛发表现\n        皮肤常干燥，易有湿疹和皮肤划痕症。由于酪氨酸酶受抑，使黑色素合成减少，故患儿毛发色淡而呈棕色。\n        其他\n        由于苯丙氨酸羟化酶缺乏，苯丙氨酸从另一通路产生苯乳酸和苯乙酸增多，从汗液和尿中排出而有霉臭味（或鼠气味）。";
    
    
       __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"生长发育迟缓"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"神经精神表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange6  = [[mutableAttributedString string] rangeOfString:@"皮肤毛发表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange7  = [[mutableAttributedString string] rangeOfString:@"其他"
                                                                      options:NSCaseInsensitiveSearch];
        
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        
        UIFont *boldSystemFont1 = [UIFont boldSystemFontOfSize:13];
        CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont1.pointSize, NULL);
        
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
                CFRelease(font);
            }
        }
        
        if (font1) {
            {
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange4];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange5];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange6];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange7];
                CFRelease(font1);
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

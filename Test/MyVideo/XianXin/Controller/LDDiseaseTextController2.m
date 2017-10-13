//
//  LDDiseaseTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseTextController2.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseTextController2 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation LDDiseaseTextController2

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
    
    NSString *text = @"     蚕豆病是葡萄糖-6-磷酸脱氢酶（G6PD）缺乏症的一个类型，表现为进食蚕豆后引起溶血性贫血。溶血具体机制不明，同一地区G6PD缺乏者仅少数人发病，而且也不是每年进食蚕豆都发病。蚕豆病在我国西南、华南、华东和华北各地均有发现，而以广东、四川、广西、湖南、江西为最多。3岁以下患者占70％，男性占90％。成人患者比较少见，但也有少数病例至中年或老年才首次发病。由于G6PD缺乏属遗传性，所以40％以上的病例有家族史。本病常发生于初夏蚕豆成熟季节。绝大多数病例因进食新鲜蚕豆而发病。本病是因南北各地气候不同而发病有迟有早。\n病因\n     在遗传性G6PD缺乏的基础上接触新鲜蚕豆导致急性溶血。\n       但蚕豆病发病情况颇为复杂，如蚕豆病只发生于G6PD缺乏者，但并非所有的G6PD缺乏者吃蚕豆后都发生溶血；曾经发生蚕豆病患者每年吃蚕豆，但不一定每年都发病；发病者溶血和贫血的程度与所食蚕豆量的多少并无平行关系；成年人的发病率显著低于小儿。由此可以推测，除了红细胞缺乏G6PD以外，必然还有其他因素与发病有关。可见，蚕豆病发生溶血的机制比G6PD缺乏所致的药物性溶血性贫血复杂，尚有待进一步探讨。\n临床表现      \n蚕豆病起病急遽，大多在进食新鲜蚕豆后1～2天内发生溶血，最短者只有2小时，最长者可相隔9天。如因吸入花粉而发病者，症状可在数分钟内出现。潜伏期的长短与症状的轻重无关。\n     本病的贫血程度和症状大多很严重。症状有全身不适、疲倦乏力、畏寒、发热、头晕、头痛、厌食、恶心、呕吐、腹痛等。巩膜轻度黄染，尿色如浓红茶或甚至如酱油。一般病例症状持续2～6天。最重者出现面色极度苍白，全身衰竭，脉搏微弱而速，血压下降，神志迟钝或烦躁不安，少尿或闭尿等急性循环衰竭和急性肾衰竭的表现。如果不及时纠正贫血、缺氧和电解质平衡失调，可以致死。\n        G6PD缺乏症又是新生儿病理性黄疸的主要原因。据中山医大的一项统计表明，患G6PD缺乏症的新生儿中，约50%的患儿会出现新生儿黄疸，其中约12%可发展为核黄疸，导致脑部损害，引起智力低下。\n诊治原则\n      G6PD缺乏症在无诱因不发病时，与正常人一样，无需特殊处理。防治的关键在于预防，严格遵照以下健康处方，预防发作。其次是对妊娠晚期孕妇或新生儿服用小剂量苯巴比妥，可有效减低新生儿核黄疸的发生。输血是本病急性发作时最有效的疗法，其次是纠正酸中毒、处理肾衰。轻中度溶血患者一般用补液治疗。";
    
    
       __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"诊治原则"
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
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange3];
                CFRelease(font);
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

//
//  LDDiseaseTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseTextController1.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseTextController1 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation LDDiseaseTextController1

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
    
    NSString *text = @"         遗传代谢病是因维持机体正常代谢所必需的某些由多肽和（或）蛋白组成的酶、受体、载体及膜泵生物合成发生遗传缺陷，即编码这类多肽（蛋白）的基因发生突变而导致的疾病，又称遗传代谢异常或先天代谢缺陷。\n        遗传代谢病一部分原因是由基因遗传导致，还有一部分是后天基因突变造成，发病期不仅仅是新生儿，覆盖全年龄阶段。\n 病因 \n        现认为其基本代谢缺陷是肝脏不能正常合成血浆铜蓝蛋白，铜与铜蓝蛋白的结合力下降以致自胆汁中排出铜量减少。人铜蓝蛋白基因位于3q23-25，其基因突变与本病相关，目前发现6种移码突变导致编码蛋白功能障碍铜蓝蛋白无法与铜结合。铜是人体所必需的微量元素之一，人体新陈代谢所需的许多重要的酶，如过氧化物歧化酶、细胞色素C氧化酶、酪氨基酶、赖氨酸氧化酶和铜蓝蛋白等，都需铜离子的参与合成。但机体内铜含量过多、高浓度的铜会使细胞受损和坏死，导致脏器功能损伤。其细胞毒性可能使铜与蛋白质、核酸过多结合，或使各种膜的脂质氧化，或是产生了过多的氧自由基，破坏细胞的线粒体、溶酶体等。\n临床表现\n       神经系统异常、代谢性酸中毒和酮症、严重呕吐、肝脏肿大或肝功能不全、特殊气味、容貌怪异、皮肤和毛发异常、眼部异常、耳聋等，多数遗传代谢病伴有神经系统异常，在新生儿期发病者可表现为急性脑病，造成痴呆、脑瘫、甚至昏迷、死亡等严重并发的症状。\n1．尿液\n     异常气味、酮体屡次阳性等提示有代谢缺陷病的可能性。\n2．低血糖\n      新生儿低血糖可以是由摄人食物中的某些成分所诱发，也可能是因为内在代谢缺陷而不能保持血糖水平，或者由于两种因素的共同作用。当新生儿低血糖发生于进食以后、补给葡萄糖的效果不显；或伴有明显的重症酮中毒和其他代谢紊乱；或经常发作时，均提示遗传性代谢缺陷的可能性。\n3．高氨血症\n       除新生儿败血症和肝炎等所引致的肝功能衰竭以外，新生儿期的高氨血症常常是遗传代谢病所造成，且起病大都急骤。患儿出生时正常而在喂食奶类数日后逐渐出现嗜睡、拒食、呕吐、肌力减退、呻吟呼吸、惊厥和昏迷，甚至死亡。有时可见到交替性肢体强直和不正常动作等。许多代谢缺陷可导致高氨血症，由尿素循环酶缺陷引起者常伴有轻度酸中毒；而由于支链氨基酸代谢紊乱引起的则伴中、重度代谢性酸中毒。\n并发症       \n      遗传代谢病可引起以下并发症：\n 1．肝脏损害\n      肝脏是最常见的受累器官，多表现为慢性肝炎、肝硬化，反复出现疲乏、食欲差，呕吐、黄疸、浮肿或腹水等。有少数表现为急性肝炎，甚至迅速发展至急性肝功能衰竭。轻者仅见肝脾大而无临床症状。约15%的患儿在出现肝病症状前后同时发生溶血性贫血，一般是一过性的，但亦可发生严重溶血合并爆发性肝功能衰竭，甚至死亡。\n2．神经精神损害\n      神经系统损害仅次于肝损害，其症状出现亦多晚于肝损害。早期主要是构语困难（纳吃）、动作笨拙或震颤、不自主运动、表情呆板、肌张力改变等，到晚期精神症状更为明显，常有行为异常和智能障碍，颅脑CT和MRI可显示基底节目低密度灶，严重时可累及丘脑、脑干和小脑 。\n3．肾脏损害\n      大都继发于肝损害，少数可作为首发症状，主要表现为肾小管重吸收功能障碍，如蛋白尿、糖尿、氨基酸尿和肾小管酸中毒表现，少数患儿可有Fanconi综合征症状。少数患者可并发甲状旁腺功能减低，葡萄糖不耐受、胰酶分泌不足、体液或细胞免疫功能低下等。";
    
    
       __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"并发症"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"1．尿液"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"2．低血糖"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange6  = [[mutableAttributedString string] rangeOfString:@"3．高氨血症"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange7  = [[mutableAttributedString string] rangeOfString:@"1．肝脏损害"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange8  = [[mutableAttributedString string] rangeOfString:@"2．神经精神损害"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange9  = [[mutableAttributedString string] rangeOfString:@"3．肾脏损害"
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
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange3];
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
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange8];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange9];

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

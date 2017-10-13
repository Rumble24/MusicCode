//
//  LDDiseaseTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseTextController4.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseTextController4 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation LDDiseaseTextController4

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createScrollerView];
}


- (void)createScrollerView
{
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64 - 200 - 50);
    
    self.scrollerView.showsHorizontalScrollIndicator = YES;
    self.scrollerView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.scrollerView];
    
    NSString *text = @"     先天性肾上腺皮质增生症（CAH）是较常见的常染色体隐性遗传病，由于皮质激素合成过程中所需酶的先天缺陷所致。皮质醇合成不足使血中浓度降低，由于负反馈作用刺激垂体分泌促肾上腺皮质激素（ACTH）增多，导致肾上腺皮质增生并分泌过多的皮质醇前身物质如11-去氧皮质醇和肾上腺雄酮等。而发生一系列临床症状。不同种族CAH发病率有很多差别。\n病因\n      由于皮质激素合成过程中所需酶的先天缺陷所致。目前能识别的六型，分别为：21-羟化酶缺陷、11β-羟化酶缺陷、17-羟化酶缺陷、3β羟脱氢酶缺陷、皮质酮甲基氧化酶缺陷及先天性类脂质性肾上腺增生。\n临床表现\n      21-羟化酶缺乏和3羟脱氢酶缺乏有男性化和失盐表现。出现低血钠、高血钾、循环衰竭、失盐危象,可发生于生后数周内，危及生命。根据临床表现的严重程度分为典型和非典型。典型包括（失盐型、单纯男性化）。反映了21-羟化酶缺陷不同程度的一般规律。\n      失盐型\n      为临床表现最重的一型。除了雄激素过多引起的男性化表现外，有明确的失盐表现。患者由于21-羟化酶活性完全缺乏，孕酮的21羟化过程严重受损，导致醛固酮分泌不足。醛固酮的缺乏引起肾脏、结肠和汗腺钠丢失。21-羟化酶缺陷引起的皮质醇分泌不足又加重了醛固酮缺陷的作用，盐皮质激素和糖皮质激素同时缺陷更易引起休克和严重的低钠血症。\n      另外，堆积的类固醇前体物质会直接拮抗盐皮质激素受体，加重盐皮质激素缺陷表现，特别是未接受治疗的患者尤为重要。已知孕酮有明确的抗盐皮质激素作用。尚无证据表明17-羟孕酮有直接或间接抗盐皮质激素的作用。\n      失盐的临床表现可以是一些不特异的症状，如食欲差、呕吐、嗜睡和体重增加缓慢。严重患者通常在出生后1～4周内出现低钠血症、高钾血症、高肾素血症和低血容量休克等肾上腺危象表现。如果不能得到正确及时的诊治，肾上腺危象会导致患者死亡。对于男性失盐型婴儿问题尤为严重，因为他们没有女性婴儿的外生殖器两性畸形，在这些患儿出现脱水和休克之前医生没有警惕CAH的诊断。随着年龄的增长，在婴幼儿期发生过严重失盐表现的CAH病例钠平衡能力会得以改善，醛固酮合成会更加有效。\n      单纯男性化\n      与失盐型比较，除没有严重失盐表现外，其他雄激素过多的临床表现大致相同。占经典型病例的1/4。\n      非经典型\n      以前也称为迟发型21-羟化酶缺陷症，患者只有轻度雄激素过多的临床表现。女性患者在出生时外生殖器正常或轻度阴蒂肥大，没有外生殖器两性畸形。肾上腺类固醇前体物质仅轻度升高，17-羟孕酮水平在杂合子携带者和经典型病例之间。ACTH1～24兴奋试验后（60分钟时）17-羟孕酮一般在10ng/ml以上，如果只测定基础血清17-羟孕酮水平，会使患者漏诊。轻度雄激素过多的症状和体征差异很大，很多受累个体会没有症状。最常见的症状为儿童阴毛提早出现，或年轻女性中表现为严重囊性痤疮、多毛症、多囊卵巢、月经稀发甚至闭经。非经典型21-羟化酶缺陷症女性患者也存在生育能力下降，程度比经典型患者轻。";
    
    
       __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"失盐型"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"单纯男性化"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange6  = [[mutableAttributedString string] rangeOfString:@"非经典型"
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

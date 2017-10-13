//
//  LDDiseaseTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDDiseaseTextController3.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDDiseaseTextController3 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation LDDiseaseTextController3

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
    
    NSString *text = @"发病原因\n       甲状腺功能低下症是甲状腺素分泌缺乏或不足而出现的综合征，甲状腺功能低下病因包括：\n       1.甲状腺实质性病变，如甲状腺炎，外科手术或放射性同位素治疗造成的腺组织破坏过多，发育异常等。\n       2.甲状腺素合成障碍，如长期缺碘、长期抗甲状腺药物治疗、先天性甲状腺素合成障碍、可能由于一种自身抗体（TSH受体阻断抗体）引起的特发性甲状腺功能低下等。\n       3.垂体或下丘脑病变。根据发病年龄不同可分为克汀病及粘液水肿。\n发病类型\n       甲状腺功能低下症临床上按发病年龄分为3型：\n       1.功能减退始于胎儿期或出生后不久的新生儿，严重影响大脑和身体生长发育，称呆小病或“克汀病”。\n       2.功能减退始于发育前儿童者称为幼年甲减。\n       3.功能减退始于成人期者称为成人甲减。严重时，病人皮下组织出现非凹陷性水肿，称为粘液性水肿，更为严重时，可出现粘液性水肿昏迷。\n       成人甲低（甲减）属于脏腑功能减退之病证，阳虚生内寒为其主要机制。辨证主要分清以何脏为主，在肾以腰凉肢冷、耳鸣耳聋、记忆力减退、反应迟钝、毛发脱落、阳痿、月经不调为主要症状；在脾以面色苍白、厌食、便秘、腹胀、腹水为突出表现；在肺以少气懒言、皮肤干燥、易裂无光、体温下降为常见症状；在心则以胸闷胸痛、心慌不宁，脉沉结代为主要脉证。临床上要与“水肿”、“便秘”、“厥证”等病鉴别。\n临床表现\n       1.一般表现\n       怕冷、皮肤干燥少汗、粗糙、泛黄、发凉、毛发稀疏、干枯、指甲脆、有裂纹、疲劳、瞌睡、记忆力差、智力减退、反应迟钝、轻度贫血、体重增加。\n       2.特殊表现\n       颜面苍白而蜡黄、面部浮肿、目光呆滞、眼睑浮肿、表情淡漠、少言寡语、言则声嘶、吐词含混。\n       3.心血管系统\n       心虑缓慢、心音低弱、心脏呈普遍性扩大、常伴有心包积液、也有疾病后心肌纤维肿胀、粘液性糖蛋白（PAS染色阳性）沉积以及间质纤维化称甲减性心肌病变。\n       4.生殖系统\n       男性可出现性功能底下，性成熟推迟、副性征落后，性欲减退、阳痿和睾丸萎缩；女性可有月经不调、经血过多或闭经，一般不孕。无论对男女病人的生育都会产生影响。\n       5.肌肉与关节系统\n       肌肉收缩与松弛均缓慢延迟、常感肌肉疼痛、僵硬、骨质代谢缓慢、骨形成与吸收均减少、关节不灵、有强直感、受冷后加重、有如慢性关节炎、偶见关节腔积液。\n       6.消化系统\n       患者食欲减退、便秘、腹胀、甚至出现麻痹性肠梗阻、半数左右的患者有完全性胃酸缺乏。\n       7.内分泌系统\n       男性阳痿、女性月经过多、久病不治者亦饿闭经、肾上腺皮质功能偏低、血和尿皮质醇降低。\n       8.精神神经系统\n       记忆力减退、智力低下、反应迟钝、多瞌睡、精神抑郁、有时多虑有精神质表现、严重者发展为猜疑性精神分裂症、后期多痴呆、环幻觉木僵或昏睡。";
    
    
       __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"发病原因"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"发病类型"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"1.一般表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"2.特殊表现"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange6  = [[mutableAttributedString string] rangeOfString:@"3.心血管系统"
                                                                            options:NSCaseInsensitiveSearch];
        
        NSRange fontRange7  = [[mutableAttributedString string] rangeOfString:@"4.生殖系统"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange8  = [[mutableAttributedString string] rangeOfString:@"5.肌肉与关节系统"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange9  = [[mutableAttributedString string] rangeOfString:@"6.消化系统"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange10  = [[mutableAttributedString string] rangeOfString:@"7.内分泌系统"
                                                                      options:NSCaseInsensitiveSearch];
        
        NSRange fontRange11  = [[mutableAttributedString string] rangeOfString:@"8.精神神经系统"
                                                                      options:NSCaseInsensitiveSearch];
        
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        
        UIFont *boldSystemFont1 = [UIFont boldSystemFontOfSize:13];
        CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont1.pointSize, NULL);
        
        if (font) {
            {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange1];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange2];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange3];
                CFRelease(font);
            }
        }
        
        if (font1) {
            {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange4];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange5];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange6];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange7];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange8];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange9];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange10];
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font1
                                                range:fontRange11];

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

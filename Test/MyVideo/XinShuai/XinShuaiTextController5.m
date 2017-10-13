//
//  XinShuaiTextController5.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "XinShuaiTextController5.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController5 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController5

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
    
    NSString *text = @"     主动脉狭窄是由左心室出口至主动脉起始部间发生狭窄，可划分为瓣膜狭窄、瓣膜上狭窄和瓣膜下狭窄等三种类型。\n       基本信息\n       疾病名称：主动脉狭窄\n       疾病分类：心外科\n       1．病情较轻时不出现。但是，病情超过中等程度以上时，随病情出现呼吸困难或失神。\n       2．不出现黏膜发绀。\n       3．股动脉脉搏出现迟缓，因此脉压变得狭窄且微细，变得感知困难。\n       4．可在第3～4肋间的胸骨缘听到最强3/6～6/6度的收缩期输出性杂音，并在同一部位感触到震颤。\n症状\n       症状：男性多见，单纯风湿性主动脉瓣狭窄少见，大多同时合并有关闭不全和（或）二尖瓣病变。\n       左心室代偿期：轻、中度主动脉瓣狭窄，可多年无症状。尸解发现约5%主动脉瓣狭窄患者可无明显自觉症状而突然猝死。\n       左心室失代偿期：严重主动脉瓣狭窄的特征性症状有心绞痛、晕厥和心力衰竭。\n治疗方案\n       1．无症状轻度主动脉瓣狭窄患者需定期密切随访：①有风湿活动者应抗风湿治疗；②预防感染性心内膜炎，在进行牙科、胃肠道和生殖泌尿道手术及器械检查时。应进行抗生素预防。\n       2．有症状主动脉瓣狭窄者处理：①限制体力活动防止晕厥加重或猝死；②伴室性心动过速高度房室传导阻滞，严重窦性心动过缓时，按抗心律失常药物治疗；③有胸痛者需作冠状动脉造影，以诊断伴发的冠心病，此种情况应用硝酸甘油舌下含服时。注意剂量宜小，防止在原先存在心排血量减少基础上剂量过大引起外周动脉扩张，导致晕厥发生；或因动脉压下降使冠脉血流更为减少；④左心功能不全时可用利尿药。但用量不宜过大，以免引起心排血量减少。\n       3．经皮球囊主动脉瓣成形术和人工主动脉瓣置换术适应证：①有反复发作晕厥、心绞痛史或经药物已控制的左心衰竭者。②主动脉瓣口面积<0.7cm：跨瓣压力阶差≥50mmHg。③瓣膜本身发育完全并由交界处粘连引起的先天或后天性狭窄。④瓣膜无明显钙化：可伴有轻度关闭不全。\n预后\n       主动脉狭窄预后与左心室－主动脉之间的压力阶差有关。某些极轻度的瓣口狭窄，患者可终身无症状；轻度瓣口狭窄的患者，可有20～30年的无症状期；中度狭窄的患者，可有10～20年的无症状期；重度狭窄的患者也可有较长的缓慢进行的病程。但多合并有严重的并发症，如晕厥或心绞痛，当出现这两种并发症时，患者平均寿命有2～3年，某些可发生猝死主动脉狭窄的患者最终可发生充血性心力衰竭，在出现心衰后均寿命2～3年。主动脉瓣狭窄的患者约20%可发生猝死。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"基本信息"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"症状"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"治疗方案"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"预后"
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
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange4];
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

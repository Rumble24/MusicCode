//
//  XinShuaiTextController1.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiTextController1.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController1 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController1

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
    
    NSString *text = @"     动脉导管原本系胎儿时期肺动脉与主动脉间的正常血流通道，由于此时肺呼吸功能障碍，来自右心室的肺动脉血经导管进入降主动脉，而左心室的血液则进入升主动脉，故动脉导管为胚胎时期特殊循环方式所必需。出生后，肺膨胀并承担气体交换功能，肺循环和体循环各司其职，不久导管因废用即自选闭合。如持续不闭合而形成动脉导管未闭，应施行手术，中断其血流。\n      动脉导管未闭是一种较常见的先天性心血管畸形，占先天性心脏病总数的12%～15%，女性约两倍于男性。约10%的病例并存其他心血管畸形。\n病因\n        遗传是主要的内因。在胎儿期任何影响心脏胚胎发育的因素均可能造成心脏畸形，如孕母患风疹、流行性感冒、腮腺炎、柯萨奇病毒感染、糖尿病、高钙血症等，孕母接触放射线；孕母服用抗癌药物或甲糖宁等药物。\n临床表现\n        动脉导管未闭的临床表现主要取决于主动脉至肺动脉分流血量的多少以及是否产生继发肺动脉高压和其程度。轻者可无明显症状，重者可发生心力衰竭。常见的症状有劳累后心悸、气急、乏力，易患呼吸道感染和生长发育迟缓。晚期肺动脉高压严重，产生逆向分流时可出现下半身发绀。\n        动脉导管未闭体检时，典型的体征是胸骨左缘第2肋间听到响亮的连续性机器样杂音，伴有震颤。肺动脉瓣第2音亢进，但常被响亮的杂音所掩盖。分流量较大者，在心尖区尚可听到因二尖瓣相对性狭窄产生的舒张期杂音。测血压时收缩压多在正常范围，而舒张压降低，因而脉压增宽，四肢血管有水冲脉和枪击音。\n        婴幼儿可仅听到收缩期杂音。晚期出现肺动脉高压时，杂音变异较大，可仅有收缩期杂音，或收缩期杂音亦消失而代之以肺动脉瓣关闭不全的舒张期杂音。\n预后\n        动脉导管闭合术中大出血所致的手术死亡率，视导管壁质地、采用闭合导管的手术方式以及手术者技术的高低等而异，一般应在1%以内。导管单纯结扎术或钳闭术有术后导管再通可能，其再通率一般在1%以上，加垫结扎术后复通率低于前二者。\n        动脉导管闭合术的远期效果，视术前有否肺血管继发性病变及其程度。在尚未发生肺血管病变之前接受手术的病人可完全康复，寿命如常人。肺血管病变严重呈不可逆转者，术后肺血管阻力仍高，右心负荷仍重，效果较差。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"预后"
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

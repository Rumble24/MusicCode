//
//  XinShuaiTextController6.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "XinShuaiTextController6.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController6 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController6

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
    
    NSString *text = @"     主动脉窦动脉瘤，是一种罕见的心血管先天性畸形，男性多于女性，是由于主动脉窦基底环上的主动脉壁局部发育不良，缺乏中层弹性组织，致局部管壁薄弱，在高压血流冲击下逐渐膨出而形成主动脉窦瘤。瘤体顶端最薄弱，最终被冲破。主动脉窦瘤好发于右冠状动脉窦，且大多数破入右心室；其次为无冠状动脉窦，多数破入右心房；较少发生于左冠状动脉窦。\n病因\n      1．先天性因素：在胚胎发育时期，主动脉窦部组织发育不全，有薄弱部分，合并室缺时，右冠窦邻近的右室漏斗部失去支持，在受到高压血流的冲击即可发生瘤体破裂。室缺可能是窦瘤形成的一个重要因素。\n      2．后天性因素：目前普遍认为后天性因素还有由于感染性心内膜炎、梅毒等引起的窦瘤破裂。\n临床表现\n      主动脉窦动脉瘤破裂前一般无症状。破裂多发生在20～67岁之间，男性多见。约40%有突发心前区疼痛史，常于剧烈活动时发生，随即出现心悸、气急，可迅速恶化至心力衰竭。较多的患者发病缓慢，劳累后气急、心悸、乏力等逐渐加重，以致丧失活动能力。\n      1．未破裂的主动脉瓣窦动脉瘤不呈现临床症状，破裂后才呈现症状。少数患者由于破口甚小，仅有小量左向右分流，很长时间内患者可无自觉症状，这些患者常因心脏杂音而偶然发现，通过超声心动图、右心导管检查及主动脉造影而诊断。\n      2．发病年龄多数在20～40岁之间，约有1/3的患者起病急骤，在剧烈劳动时突然感觉心前区或上腹部剧烈疼痛、胸闷和呼吸困难，病情类似心绞痛。病情迅速恶化者，发病后数日即可死于右心衰竭。\n      3．多数病例破口较小，起病后可有数周、数月或数年的缓解期，然后呈现右心衰竭症状。\n治疗\n      主动脉窦动脉瘤无论破裂与否均应手术切除。\n      急性破裂者需先短期积极治疗心力衰竭，如不能控制，则尽早手术。在体外循环心停搏下切开右心室或右心房。从裂口两侧分别剪开瘤壁至距入口3mm处，于颈部环形剪除瘤壁，然后沿纤维瓣环作褥式或8字缝合，两侧垫衬心包片或涤纶片，再连续缝合加固。如合并室间隔缺损，需一并缝合或用补片修补。如伴有主动脉瓣关闭不全，另经升主动脉切口，将宽大过多的右主动脉瓣叶折叠悬吊，缝合固定于管壁。必要时，施行主动脉瓣替换术。有人直接切开升主动脉根部将动脉瘤从窦基底部翻出切除缝补。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"治疗"
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

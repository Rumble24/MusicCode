//
//  XinShuaiTextController2.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiTextController2.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController2 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController2

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
    
    NSString *text = @"     肺动脉口狭窄以肺动脉瓣狭窄最为常见，约占90%，其次为漏斗部狭窄，脉动脉干及其分支狭窄则很少见。肺动脉口狭窄一般指肺动脉瓣狭窄。\n      肺动脉瓣狭窄发病率约占先天性心脏病的8%～10%，肺动脉狭窄以单纯肺动脉瓣狭窄最为常见，约占90%，其次为漏斗部狭窄，脉动脉干及其分支狭窄则很少见，但可继发或并发瓣下狭窄，它可单独存在或作为其他心脏畸形的组成部分，如法洛四联症、卵圆孔未闭等。若跨瓣压差<30%mmHg，一般不会出现明显的临床症状。\n病因\n     各类肺动脉狭窄其胚胎发育障碍原因不一，在胚胎发育第6周，动脉干开始分隔成为主动脉与肺动脉，在肺动脉腔内膜开始形成三个瓣膜的原始结节，并向腔内生长，继而吸收变薄形成三个肺动脉瓣，如瓣膜在成长过程发生障碍，如孕妇发生宫内感染尤其是风疹病毒感染时三个瓣叶交界融合成为一个圆顶状突起的鱼嘴状口，即形成肺动脉瓣狭窄。\n     肺动脉瓣发育的同时，心球的圆锥部被吸收成为右心室流出道（即漏斗部），如发育障碍形成流出道环状肌肉肥厚或肥大肌束横跨室壁与间隔间即形成右心室流出道漏斗型狭窄。另外胚胎发育过程中，第6对动脉弓发育成为左、右肺动脉，其远端与肺小动脉相连接，近端与肺动脉干相连，如发育障碍即形成脉动脉分支或肺动脉干狭窄。\n临床表现\n     本病男女之比约为3∶2，发病年龄大多在10～20岁之间，症状与肺动脉狭窄密切相关，轻度肺动脉狭窄病人一般无症状，但随着年龄的增大症状逐渐显现，主要表现为劳动耐力差、乏力和劳累后心悸、气急等症状。重度狭窄者可有头晕或剧烈运动后昏厥发作，晚期病例出现颈静脉怒张、肝脏肿大和下肢水肿等右心衰竭的症状，如并存房间隔缺损或卵圆窝未闭，可见口唇或末梢指（趾）端发绀和杵状指（趾）。\n治疗\n     轻度肺动脉狭窄病人临床上无症状，可正常生长发育并适应正常的生活能力可不需手术治疗，中等度肺动脉狭窄病人，一般在20岁左右出现活动后心悸气急状态，如不采取手术治疗，随着年龄的增长必然会导致右心室负荷过重出现右心衰竭症状，从而丧失生活和劳动能力，对极重度肺动脉狭窄病人常在幼儿期出现明显症状，如不及时治疗常可在幼儿期死亡。\n     20世纪80年代之前，外科手术行肺动脉瓣切开术是治疗该病的惟一手段，该方法是在体外循环下，切开狭窄的瓣环。但随着医学的发展，经皮球囊肺动脉瓣膜成形术已经成为单纯性肺动脉瓣狭窄的首选治疗方法。";
    
    
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

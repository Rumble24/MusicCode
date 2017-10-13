//
//  XinShuaiTextController7.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "XinShuaiTextController7.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController7 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController7

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
    
    NSString *text = @"     法洛四联症（TOF）是一种常见的先天性心脏畸形。其基本病理为室间隔缺损、肺动脉狭窄、主动脉骑跨和右心室肥厚。法洛四联症在儿童发绀型心脏畸形中居首位。法洛四联症患儿的预后主要取决定肺动脉狭窄程度及侧支循环情况，重症者有25%～35%在1岁内死亡，50%病人死于3岁内，70%～75%死于10岁内，90%病人会夭折。主要是由于慢性缺氧引起，红细胞增多症，导致继发性心肌肥大和心力衰竭而死亡。\n病因\n     VanPraagh认为法洛四联症的四种畸形是右室漏斗部或圆锥发育不良的后果，即当胚胎第4周时动脉干未反向转动，主动脉保持位于肺动脉的右侧，圆锥隔向前移位，与正常位置的窦部室间隔未能对拢，因而形成发育不全的漏斗部和嵴下型室间隔缺损，即膜周型室间隔缺损。若肺动脉圆锥发育不全，或圆锥部分完全缺如，则形成肺动脉瓣下型室间隔缺损，即干下型室间隔缺损。\n临床表现\n     法洛四联症病儿的预后主要决定于肺动脉狭窄程度及侧支循环情况，重症四联症有25%～35%在1岁内死亡，50%病人死于3岁内，70%～75%死于10岁内，90%病人会夭折，主要是由于慢性缺氧引起，红细胞增多症，导致继发性心肌肥大和心力衰竭而死亡。\n     1．症状\n     1）发绀：多在生后3～6个月出现，也有少数到儿童或成人期才出现。发绀在运动和哭闹时加重，平静时减轻。\n     （2）呼吸困难和缺氧性发作：多在生后6个月开始出现，由于组织缺氧，活动耐力较差，动则呼吸急促，严重者可出现缺氧性发作、意识丧失或抽搐。\n     （3）蹲踞：为法洛四联症病儿临床上一种特征性姿态。蹲踞可缓解呼吸困难和发绀。\n     2．体征\n     患儿生长发育迟缓，常有杵状指、趾，多在发绀出现数月或数年后发生。胸骨左缘第2～4肋间可听到粗糙的喷射样收缩期杂音，常伴收缩期细震颤。极严重的右心室流出道梗阻或肺动脉闭锁病例可无心脏杂音。在胸前部或背部有连续性杂音时，说明有丰富的侧支血管存在，肺动脉瓣第二心音明显减弱或消失。\n治疗\n     临床上手术治疗有以下几种方法：\n     1．四联症矫正术：仰卧位，全麻，胸部正中切口，一般主张应用中度低温体外循环，新生儿则主张在深低温停循环和低流量体外循环下进行。一般采用4℃冷血心脏停搏液行冠状动脉灌注诱导心脏停搏进行心肌保护。心内矫正操作包括室间隔缺损修补、妥善解除右室流出道梗阻。\n     2．姑息手术：肺血管发育很差、左心室发育小以及婴儿冠状动脉畸形影响应用右心室流出道补片者，均应先行姑息性手术，以后再行二期纠治手术。姑息手术的选择：①对年龄大的儿童多采用锁骨下动脉－肺动脉吻合术，或右心室流出道补片加宽术，后者适于两侧肺动脉过于狭小的病例。②3个月以内的婴儿则采用升主动脉－肺动脉吻合术或中心分流术。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"治疗"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"1．症状"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"2．体征"
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

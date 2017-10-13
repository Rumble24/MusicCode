//
//  XinShuaiTextController3.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "XinShuaiTextController3.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController3 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController3

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
    
    NSString *text = @"     房间隔缺损（ASD）为临床上常见的先天性心脏畸形，是原始房间隔在胚胎发育过程中出现异常，致左、右心房之间遗留孔隙。房间隔缺损可单独发生，也可与其他类型的心血管畸形并存，女性多见，男女之比约1:3。由于心房水平存在分流，可引起相应的血流动力学异常。\n病因\n       在胚胎发育的第4周，心房由从其后上壁发出并向心内膜垫方向生长的原始房间隔分为左、右心房，随着心内膜垫的生长并逐渐与原始房间隔下缘接触、融合，最后关闭两者之间残留的间隙（原发孔）。在原发孔关闭之前，原始房间隔中上部逐渐退化、吸收，形成一新的通道即继发孔，在继发孔形成后、原发隔右侧出现向下生长的间隔即继发隔，形成一单瓣遮盖继发孔，但二者之间并不融合，形成卵圆孔，血流可通过卵圆孔从右心房向左心房分流。\n       卵圆孔于出生后逐渐闭合，但在约20%的成人中可遗留细小间隙，由于有左房面活瓣组织覆盖，正常情况下可无分流。如在胚胎发育过程中，原始房间隔下缘不能与心内膜垫接触，则在房间隔下部残留一间隙，形成原发孔房间隔缺损。而原始房间隔上部吸收过多、继发孔过大或继发隔生长发育障碍，则二者之间不能接触，出现继发孔房间隔缺损。\n临床表现\n       多数继发孔房间隔缺损的儿童除易患感冒等呼吸道感染外可无症状，活动亦不受限制，一般到青年时期才表现有气急、心悸、乏力等。40岁以后绝大多数病人症状加重，并常出现心房纤颤、心房扑动等心律失常和充血性心衰表现，也是死亡的重要原因\n治疗\n       1岁以上的继发孔型房间隔缺损罕有自发性闭合者，对于无症状的患儿，如缺损小于5mm可以观察，如有右心房、右心室增大一般主张在学龄前进行手术修补。约有5%婴儿于出生后1年内并发充血性心力衰竭。内科治疗效果不佳者也可施行手术。成年人如缺损小于5mm、无右心房室增大者可临床观察，不做手术。成年病例如存在右心房室增大可手术治疗，合并有心房纤颤者也可同时手术，但肺血管阻力大于12单位、出现右向左分流和发绀者则禁忌手术。\n       有一部分继发孔房间隔缺损如位置合适，可行微创的经心导管介入治疗。经股静脉插管，将镍钛合金的封堵器夹在房间隔缺损处，闭合房间隔缺损达到治疗目的。不用开胸手术。\n       继发孔房间隔缺损常经胸骨正中入路于体外循环下直视修补，右前外侧切口也可提供良好的手术显露，但需排除合并有其他类型心脏畸形。小的继发孔型房间隔缺损可直接缝合，如缺损大则需用心包片或涤纶补片修补，完成修补前左心房注水以防止心脏复跳后出现空气栓塞十分重要。\n       静脉窦型房间隔缺损修补较为复杂，一般经上腔静脉直接插入引流管以增加缺损显露，修补中必须辨别右上肺静脉开口并避开窦房结，将补片缝于右肺静脉入口前沿的右房壁上，以保证肺静脉引流入左心房，如有必要则需补片加宽上腔静脉入口，防止静脉回流受阻。\n       年龄大的房间隔缺损病例术后窦性心动过缓发生率较高，可用异丙肾上腺素或阿托品增快心率，术中安置临时起搏电极为有效措施。\n预后\n       未手术的房间隔缺损病人自然病程与缺损的类型、分流量大小及是否合并有其他类型的心脏畸形有关，多数可生长至成年，但寿命缩短，病人死于充血性心力衰竭。\n       单纯继发孔型房间隔缺损手术死亡率低于1%。手术后由于血流动力学的改善，病人症状明显减轻或消失，其长期生存率与正常人对比无显著差异。成年患者特别是合并有心功能不全、心律失常或肺动脉高压者，手术死亡率相对较高，有时尽管成功接受了手术修补，已有的肺动脉高压和右心室肥大依然存在，但病人心脏功能可得以改善，其长期存活率也明显高于未手术病例";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"病因"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"临床表现"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange3 = [[mutableAttributedString string] rangeOfString:@"治疗"
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

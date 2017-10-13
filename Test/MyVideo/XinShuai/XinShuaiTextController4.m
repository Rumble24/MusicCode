//
//  XinShuaiTextController4.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//


#import "XinShuaiTextController4.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XinShuaiTextController4 ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiTextController4

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
    
    NSString *text = @"     室间隔缺损指室间隔在胚胎时期发育不全，形成异常交通，在心室水平产生左向右分流。室间隔缺损是最常见的先天性心脏病，约占先心病的20%，可单独存在，也可与其他畸形并存。缺损常在0.1～3cm，位于膜部者则较大，肌部者则较小，后者又称Roger病。缺损若<0.5cm则分流量较小，多无临床症状。缺损小者心脏大小可正常，缺损大者左心室较右心室增大明显。\n病因\n      根据缺损的位置，可分为五种类型：\n      1．室上嵴上缺损：位于右心室流出道、室上嵴上方和主、肺动脉瓣之下，少数病例合并主、肺动脉瓣关闭不全。\n      2．室上嵴下缺损：位于室间隔膜部，此型最多见，占60%～70%。\n      3．隔瓣后缺损：位于右心室流入道，三尖瓣隔瓣后方，约占20%。\n      4．肌部缺损：位于心尖部，为肌小梁缺损，收缩期室间隔心肌收缩使缺损变小，所以左向右分流量小。\n      5．共同心室：室间隔膜部及肌部均未发育，或为多个缺损，较少见。\n临床表现\n      在心室水平产生左至右的分流，分流量多少取决于缺损大小。缺损大者，肺循环血流量明显增多，回流入左心房室，使左心负荷增加，左心房室增大，长期肺循环血流量增多导致肺动脉压增加，右心室收缩期负荷也增加，右心室可增大，最终进入阻塞性肺动脉高压期，可出现双向或右至左分流。\n      缺损小者，可无症状。缺损大者，症状出现早且明显，以致影响发育。有气促、呼吸困难、多汗、喂养困难、乏力和反复肺部感染，严重时可发生心力衰竭。有明显肺动脉高压时可出现发绀。本病易罹患感染性心内膜炎。\n治疗\n      1．内科治疗：主要防治感染性心内膜炎、肺部感染和心力衰竭。\n      2．外科治疗：直视下可行缺损修补术。缺损小、X线与心电图正常者不需手术；若有或无肺动脉高压，以左向右分流为主，手术以4～10岁效果最佳；若症状出现早或有心力衰竭，也可在婴幼儿期手术；显著肺动脉高压，有双向或右向左分流为主者，不宜手术。\n 预后\n      本病为先天性疾病，无有效预防措施，应做到早发现、早诊断、早治疗。对于室间隔缺损不大者预后良好，其自然寿命甚至可达70岁以上；缺损小的甚至有可能在10岁以前自行关闭。缺损大者1～2岁时即可发生心力衰竭，有肺动脉高压者预后差。及时地进行手术治疗一般可以达到和正常人无异的效果。";
    
    
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

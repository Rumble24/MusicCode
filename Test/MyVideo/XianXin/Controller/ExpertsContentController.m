//
//  ExpertsContentController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ExpertsContentController.h"
#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ExpertsContentController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation ExpertsContentController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createScrollerView];
}


- (void)createScrollerView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"江剑辉";
    
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
    NSString *text = @"\n简介\n     江剑辉，男，1965年生，于1989年作为主要成员之一参与创建广州市新生儿筛查中心（国内首批三个新生儿筛查中心之一），现任广东省妇幼保健院小儿遗传代谢病诊治中心主任。\n     1988年毕业于中山大学临床医学专业，小儿内科主任医师，教授，硕士生导师，暨南大学儿科临床医学硕士专业学位指导教师。\n     担任卫生部聘任全国新生儿疾病筛查专家组成员、代谢病诊疗组副组长，中华预防医学会新生儿疾病筛查学组副组长,中国优生科协苯丙酮尿症（PKU）治疗和康复专业组副组长，广东优生优育协会新生儿疾病筛查专业委员会主任委员，广东健康教育协会妇幼保健健康教育理事会常务理事，欧洲遗传代谢病学会（SSIEM）会员，广州公益事业促进会常务副会长。\n研究领域\n     从事遗传代谢病筛查、串联质谱筛查、临床诊治和筛查网络管理工作27年，对遗传代谢病（先天性甲低、苯丙酮尿症（PKU）、G6PD缺乏症、先天性肾上腺皮质增生症、地中海贫血、串联质谱筛查的氨基酸代谢病、有机酸血症、脂肪酸代谢病、激素与内分泌代谢紊乱疾病等）早期诊治有丰富经验，对运用新陈代谢学术解决疾病、促进健康有多年实践经验和独到体会。\n教育经历\n1988年毕业于中山医科大学临床医学系（六年制）；\n1991-1992年在北京大学第一临床医学院妇儿医院接受“长期新生儿临床专业”及科研培训；\n2004年于澳大利亚阿德莱德妇儿医院学习遗传代谢病筛查、串联质谱筛查和诊治；\n2005年于北欧四国遗传代谢病筛查学术访问交流；\n2009年于德国汉堡医疗中心学习遗传代谢病筛查、串联质谱筛查和诊治。\n主要论文\n       1.参与卫生部《新生儿疾病筛查管理办法》、《新生儿疾病筛查技术规范》、省市《新生儿疾病筛查管理办法》等起草和定稿；\n2.在国内外相关学术期刊发表筛查SCI论文、专业论文30余篇；\n参编《新生儿疾病筛查》、《遗传代谢病》、《苯丙酮尿症特殊饮食治疗》等专著；\n3.广州地区新生儿G6PD缺乏的早期诊断及其防治；\n4.广州市18年新生儿先天性甲低苯丙酮尿症和葡萄糖-6-磷酸脱氢酶缺乏症筛查；\n5.积极开展遗传性代谢缺陷病新生儿筛查和高危儿筛。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"简介"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"研究领域"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"教育经历"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"主要论文"
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
                                                range:fontRange4];
                //字体
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                                value:(__bridge id)font
                                                range:fontRange5];
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

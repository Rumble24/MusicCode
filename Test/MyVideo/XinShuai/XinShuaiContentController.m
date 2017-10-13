//
//  XinShuaiContentController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "XinShuaiContentController.h"

#import "PublicModel.h"
#import "TTTAttributedLabel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface XinShuaiContentController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TTTAttributedLabel *aLable;
@end

@implementation XinShuaiContentController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createScrollerView];
}


- (void)createScrollerView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"李田昌";
    
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
    NSString *text = @"\n学习经历\n1.1980年9月至1985年7月 滨州医学院医疗系，获学士学位\n2.1993年9月至1996年7月 北京大学第一医院心内科胡大一教授硕士研究生，获硕士学位\n3.1998年2月至1998年7月 印度Manipal Heart Foundation学习冠心病介入诊疗技术\n4.1998年11月至1999年1月先后在美国Layola大学医学中心、Chicago大学医学中心和Stanford大学医学中心学习冠心病介入诊疗技术\n5.1999年9月至2002年7月 首都医科大学附属北京同仁医院胡大一教授博士研究生\n工作经历\n1.1985年7月至1991年3月，山东滨州地区人民医院心内科工作，历任住院医师和主治医师；\n2.1993年至1994年7月 北京大学第一医院心内科，研究生；\n3.1994年7月至2000年12月 首都医科大学附属北京朝阳医院心脏中心，历任主治医师和副主任医师；\n4.2000年12月至2008年，首都医科大学北京同仁医院心血管疾病诊疗中心，主任医师，心血管中心副主任，博士研究生导师；\n5.2009年12月至今，中国人民解放军海军总医院心脏中心，主任医师，心脏中心主任兼心内科主任，博士研究生导师。\n社会任职\n1.中国人民解放军心血管专业技术委员会常委；\n2.中国人民解放军海军第九届心管专业技术委员会主任委员；\n3.中国医师协会神经调控专业委员会常委；\n4.中华医学会心血管疾病介入诊疗培训中心委员；\n5.中国医师协会心血管分会结构性心脏病专家委员会常委；\n6.中华医学会心血管内科分会委员；\n7.北京医学会心血管分会委员；\n8.北京中西医结合会心血管分会委员。\n专业特长\n      多年来，一直工作在心内科临床工作第一线，擅长心内科疾病的诊疗和处理，尤其是冠心病的现代治疗和射频消融治疗心律失常。1995年以来，共参加了800多例次心内电生理检查和射频消融术，其中独立主持完成350多例次：独立完成或指导他人完成选择性冠状动脉造影25000多例次；独立完成或指导他人完成选择性冠状动脉球囊成形术（PTCA）及支架置入15000多例次；1995年率先在国内开展了全天候模式的急性心肌梗死的急诊介入治疗；1998年率先在国内开展了经皮激光心肌血管重建术，并辅助心外科完成经胸激光心肌血管重建（PTMR）21例；1996年较早地在国内开展了先天性心脏病房间隔缺损和动脉导管未闭的介入治疗工作，2005年较早地在国内开展了先天性心脏病室间隔缺损的介入治疗，迄今，共完成先心病介入治疗650多例次。\n     先后获得国家科技进步二等奖一项，卫生部科技进步二等奖2项，卫生部科技进步三等奖2项，北京市科技进步二等奖2项，北京市科技进步三等奖2项，中华科技进步三等奖1项。\n      在从事心血管疾病介入诊疗20年多的时间里，为所在医院培养了近30名冠心病介入诊疗骨干，为来所在医院进修学习的全国各级医院培养了240多名技术骨干，利用业余时间帮助全国160多家医院开展了心血管疾病介入诊疗工作。";
    
    
    __block CGSize size;
    
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange fontRange1 = [[mutableAttributedString string] rangeOfString:@"学习经历"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange2 = [[mutableAttributedString string] rangeOfString:@"工作经历"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange4 = [[mutableAttributedString string] rangeOfString:@"社会任职"
                                                                     options:NSCaseInsensitiveSearch];
        
        NSRange fontRange5 = [[mutableAttributedString string] rangeOfString:@"专业特长"
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

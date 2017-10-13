//
//  GetPostCell.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/25.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "GetPostModel.h"
#import "PublicModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation GetPostModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

// 防止出现空值
- (void)setNilValueForKey:(NSString *)key
{
    
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 两个问题为什么plus没问题？  为什么没有。。。
- (CGFloat)cellHeight
{
    if (!_cellHeight)
    {
        _cellHeight = 45 + 15;
        
        NSString *titleStr = @"";
        if ([self theNumberOfStatus] == 0) {
            titleStr = self.title;
        }else if([self theNumberOfStatus] == 1){
            titleStr = [NSString stringWithFormat:@"     %@",self.title];
        }else if([self theNumberOfStatus] == 2){
            titleStr = [NSString stringWithFormat:@"         %@",self.title];
        }else if([self theNumberOfStatus] == 3){
            titleStr = [NSString stringWithFormat:@"             %@",self.title];
        }
        
        NSDictionary *titledic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect titlerect = [titleStr boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:titledic context:nil];
        
        if(titlerect.size.height > 20)
        {
            _cellHeight += 43 + 10;
            
        }else{
            _cellHeight += titlerect.size.height + 10;
        }
        
        NSArray *imgArray = [self.images componentsSeparatedByString:@","];
        if(imgArray.count == 0)
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            _cellHeight += rect.size.height + 10 + 30;
        }
        else  if (imgArray.count == 1)
        {
            NSString *str = imgArray[0];
            if ([PublicModel isBlankString:str])
            {
                NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                _cellHeight += rect.size.height + 10 + 30;
            }
            else
            {
                NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                _cellHeight += 175 + 30 + rect.size.height + 10;
            }
        }
        else if(imgArray.count == 2)
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            _cellHeight += (WIDTH - 40)/3 + 5 + 30 + rect.size.height + 10;
        }
        else if(imgArray.count >= 3)
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            _cellHeight += (WIDTH - 40)/3 + 5 + 30 + rect.size.height + 10;
        }
    }
    
    return _cellHeight;
}

- (NSInteger)theNumberOfStatus
{
    NSInteger n = 0;
    if (self.is_highlight.integerValue == 1) {
        n += 1;
    }
    if (self.is_top.integerValue == 1) {
        n += 1;
    }
    if (self.is_hot.integerValue == 1) {
        n += 1;
    }
    return n;
}





@end

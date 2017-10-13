//
//  MyDzModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MyDzModel.h"
#import "PublicModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MyDzModel

- (CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        _cellHeight += 70+rect.size.height + 10 + 70 + 10;
        
        if (![PublicModel isBlankString:self.to_content])
        {
            _cellHeight += 23;
        }
    }
    return _cellHeight;
}
@end

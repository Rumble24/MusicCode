//
//  PLModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PLModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PLModel

- (CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        _cellHeight = _cellHeight + rect.size.height + 16 + 75;
    }
    return _cellHeight;
}
@end

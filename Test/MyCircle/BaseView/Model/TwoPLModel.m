//
//  TwoPLModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/5.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "TwoPLModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation TwoPLModel
- (CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        NSString *str = [NSString stringWithFormat:@"%@:回复%@:%@",self.member_name,self.to_member_name,self.content];
        
        NSDictionary *pldic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect plrect = [str boundingRectWithSize:CGSizeMake(WIDTH - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:pldic context:nil];
        _cellHeight = plrect.size.height + 20;
        
    }
    return _cellHeight;
}
@end

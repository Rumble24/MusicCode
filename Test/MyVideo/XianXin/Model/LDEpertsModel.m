//
//  LDEpertsModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDEpertsModel.h"

@implementation LDEpertsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {        
        self.des = (NSString *)value;
    }
}
@end

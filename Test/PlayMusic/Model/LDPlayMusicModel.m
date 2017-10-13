//
//  LDPlayMusicModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDPlayMusicModel.h"

@implementation LDPlayMusicModel


// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end

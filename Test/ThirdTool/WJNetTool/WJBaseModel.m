//
//  WJBaseModel.m
//  WJBSApp
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 王景伟. All rights reserved.
//

#import "WJBaseModel.h"

@implementation WJBaseModel

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


@end

//
//  ImageModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
// 防止出现空值
- (void)setNilValueForKey:(NSString *)key
{
}

- (NSNumber *)width
{
    if (_width.floatValue == 0) {
        return @(750);
    }
    return _width;
}


- (NSNumber *)height
{
    if (_height.floatValue == 0) {
        return @(750);
    }
    return _height;
}

@end

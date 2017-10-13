//
//  MedicalModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MedicalModel.h"
#import "ImageModel.h"

@implementation MedicalModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"list"])
    {
        for (NSDictionary *dic in (NSArray *)value)
        {
            ImageModel *model = [[ImageModel alloc]initWithDic:dic];
            [self.list addObject:model];            
        }        
    }
    else if([key isEqualToString:@"description"])
    {
        self.content = value;
    }
    else if([key isEqualToString:@"record_date"])
    {
         self.record_date = value;
    }
    else if([key isEqualToString:@"id"])
    {
        self.dangan_id = value;
    }
}

- (NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}
@end

//
//  MedicalModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJBaseModel.h"

@interface MedicalModel : WJBaseModel

@property (nonatomic, strong) NSString *dangan_id;
@property (nonatomic, strong) NSString *record_date;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *content;

@end

//
//  MemberModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/30.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJBaseModel.h"

@interface MemberModel : WJBaseModel
// 名字
@property (nonatomic, strong) NSString *nickname;
// 头像
@property (nonatomic, strong) NSString *imgurl;
// 孕周
@property (nonatomic, strong) NSNumber *week;
@property (nonatomic, strong) NSNumber *day;
@end

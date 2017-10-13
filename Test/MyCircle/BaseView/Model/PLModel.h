//
//  PLModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJBaseModel.h"
#import <UIKit/UIKit.h>
@interface PLModel : WJBaseModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) NSString *member_name;
@property (nonatomic, strong) NSString *post_id;
@property (nonatomic, strong) NSString *re_time;
@property (nonatomic, strong) NSString *parent_id;

@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, assign) NSInteger zan_count;
@property (nonatomic, assign) NSInteger is_zan;
@property (nonatomic, assign) NSInteger is_reply;

@property (nonatomic, assign) CGFloat cellHeight;
@end

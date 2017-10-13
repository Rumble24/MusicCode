//
//  MyPlModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJBaseModel.h"
#import <UIKit/UIKit.h>

@interface MyPlModel : WJBaseModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) NSString *member_name;
@property (nonatomic, strong) NSString *publish_name;
@property (nonatomic, strong) NSString *pulish_time;
@property (nonatomic, strong) NSString *re_time;
@property (nonatomic, strong) NSString *reply_id;
@property (nonatomic, strong) NSString *parent_id;

@property (nonatomic, strong) NSString *post_content;
@property (nonatomic, strong) NSString *post_id;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *to_content;
@property (nonatomic, strong) NSString *to_member_id;
@property (nonatomic, strong) NSString *to_member_name;

@property (nonatomic, assign) CGFloat cellHeight;
@end

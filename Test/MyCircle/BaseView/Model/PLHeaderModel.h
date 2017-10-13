//
//  PLHeaderModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//
#import "WJBaseModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PLHeaderModel : WJBaseModel
@property (nonatomic, assign) NSInteger is_collection;
@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, assign) NSInteger zan_count;
@property (nonatomic, strong) NSString *community_name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, assign) NSInteger is_zan;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) NSString *member_name;
@property (nonatomic, strong) NSString *publish_time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger views;

@property (nonatomic, strong) NSNumber *is_highlight;
@property (nonatomic, strong) NSNumber *is_hot;
@property (nonatomic, strong) NSNumber *is_top;



@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageModelArray;
@property (nonatomic, strong) NSMutableArray *positionArray;
@property (nonatomic, assign) CGFloat collectionHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end

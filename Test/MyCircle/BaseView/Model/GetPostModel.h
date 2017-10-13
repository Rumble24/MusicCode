//
//  GetPostCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/25.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetPostModel : NSObject
//所属圈子
@property (nonatomic, strong) NSString *community_name;
//内容
@property (nonatomic, strong) NSString *content;
//帖子id
@property (nonatomic, strong) NSString *id;
//帖子包含的图片
@property (nonatomic, strong) NSString *images;
//名字
@property (nonatomic, strong) NSString *member_name;
//
@property (nonatomic, strong) NSString *publish_time;
//评论数
@property (nonatomic, assign) NSInteger reply_count;
//标题
@property (nonatomic, strong) NSString *title;
//浏览次数
@property (nonatomic, assign) NSInteger views;
//点赞的次数
@property (nonatomic, assign) NSInteger zan_count;
@property (nonatomic, assign) NSInteger is_zan;
@property (nonatomic, strong) NSString *imgurl;
// 发帖人的id
@property (nonatomic, strong) NSString *member_id;


//是否精华帖
@property (nonatomic, strong) NSNumber *is_highlight;
@property (nonatomic, strong) NSNumber *is_hot;
@property (nonatomic, strong) NSNumber *is_top;


@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

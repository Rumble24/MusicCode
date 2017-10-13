//
//  PLController.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/27.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLController : UIViewController

@property (nonatomic, copy) void (^PLSuccess)();
@property (nonatomic, strong) NSString *name;

// 1 评论帖子
@property (nonatomic, strong) NSString *tieZiId;
@property (nonatomic, strong) NSString *toMemberID;

//  2评论评论
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *parent_id;
@property (nonatomic, strong) NSString *reply_id;

// 评论帖子 只穿帖子id   评论评论 的时候传（1级两个都一样） parent_id  reply_id
@end

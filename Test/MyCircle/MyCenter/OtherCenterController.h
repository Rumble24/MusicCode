//
//  OtherCenterController.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/29.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherCenterController : UIViewController

@property (nonatomic, copy) NSString *otherUserId;

// 用来判断是哪个页面跳转过来的  1.从街道点击过来的  2.从聊天页面点击过来的   3.从帖子点击过来的
@property (nonatomic, assign) NSInteger type;

@end

//
//  CircleNaviTransition.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/20.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, XWNaviCircleTransitionType) {
    XWNaviCircleTransitionTypePush = 0,
    XWNaviCircleTransitionTypePop
};

@interface CircleNaviTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(XWNaviCircleTransitionType)type;
- (instancetype)initWithTransitionType:(XWNaviCircleTransitionType)type;

@end

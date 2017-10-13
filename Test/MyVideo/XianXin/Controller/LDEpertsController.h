//
//  LDEpertsController.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/6/23.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDEpertsController : UITableViewController
@property (nonatomic, copy) void (^OnClickButton)(NSInteger index,NSArray *modelArray);

@end

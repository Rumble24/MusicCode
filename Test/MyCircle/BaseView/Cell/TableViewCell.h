//
//  TableViewCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PLModel;

@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) PLModel *model;
@property (nonatomic, copy) void (^OnClickComment)(NSString *memberId,NSString *replyId,NSString *memberName);
@property (nonatomic, copy) void (^OnClickHeader)(NSString *otherUserId);

@end

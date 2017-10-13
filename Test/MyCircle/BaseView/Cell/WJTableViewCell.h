//
//  WJTableViewCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetPostModel;
@interface WJTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isCanClickHeader;
@property (nonatomic, strong) GetPostModel *model;
@property (nonatomic, copy) void (^OnClickComment)();
@property (nonatomic, copy) void (^OnClickHeader)(NSString *otherUserId);

@end

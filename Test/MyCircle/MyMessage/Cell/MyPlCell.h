//
//  MyPlCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/7.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "TableViewCell.h"
@class MyPlModel;
@interface MyPlCell : UITableViewCell
@property (nonatomic, strong) MyPlModel *model;
@property (nonatomic, copy) void (^OnClickComment)(MyPlModel *model);
@end

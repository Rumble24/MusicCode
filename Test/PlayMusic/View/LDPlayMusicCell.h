//
//  LDPlayMusicCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDPlayMusicModel.h"

@interface LDPlayMusicCell : UITableViewCell

@property (nonatomic, strong) LDPlayMusicModel *model;

@property (nonatomic, copy) void (^NeedReloadData)();

@end

//
//  UploadInformationCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/19.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadInformationCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, copy) void (^OnClickDelete)(NSDictionary *dic);
@end

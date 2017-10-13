//
//  PublishCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/24.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PublishCell : UICollectionViewCell
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, copy) void (^OnClickDelete)(NSDictionary *dic);
@end

//
//  MedicalContentController.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalModel.h"

@interface MedicalContentController : UIViewController

@property (nonatomic, strong) MedicalModel *model;

@property (nonatomic, copy) void (^OnClickImage)();

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UICollectionView *chooseImageView;
@end

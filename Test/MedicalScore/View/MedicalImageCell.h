//
//  MedicalImageCell.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface MedicalImageCell : UICollectionViewCell

@property (nonatomic, strong) ImageModel *model;
//@property (nonatomic, strong) UIImageView *deleteImage;
//@property (nonatomic, copy) void (^OnClickDelete)(ImageModel *dic);
@property (nonatomic, strong) UIImageView *mImageView;
@end

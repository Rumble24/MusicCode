//
//  ImageModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJBaseModel.h"
#import <UIKit/UIKit.h>

@interface ImageModel : WJBaseModel

@property (nonatomic, strong) NSString *file_id;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSString *imgurl;
//@property (nonatomic, strong) NSDictionary *dic;

@end

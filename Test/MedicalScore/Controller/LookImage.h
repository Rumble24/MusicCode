//
//  LookImage.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookImage : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, strong)NSMutableArray *imageArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void (^OnScrollIndex)(NSInteger index);
@end

//
//  SmallScrollView.h
//  UI06_UIScrollView
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface SmallScrollView : UIScrollView

@property (nonatomic, strong) ImageModel *model;

@property (nonatomic, copy) void (^OnClickImage)();

@property (nonatomic, copy) void (^OnLongImage)(UIImage *image);

@property (nonatomic, strong) UIImageView *imageView;

@end

//
//  LDRadioBackView.h
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/21.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDPlayMusicModel.h"

@interface LDRadioBackView : UIView

@property (nonatomic, copy) void (^NeedReloadData)();

@property (nonatomic, strong) LDPlayMusicModel *model;

@property (nonatomic, strong) UIImageView *centerImage;
@end

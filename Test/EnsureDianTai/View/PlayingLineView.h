//
//  PlayingLineView.h
//  Test
//
//  Created by 宜必鑫科技 on 2017/8/22.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingLineView : UIView

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth lineColor:(UIColor*)lineColor;
-(void)addAnimationWith:(NSArray *)timeArray;
- (void)stopAllAnimation;
@end

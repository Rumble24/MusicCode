//
//  CxyButton.m
//  Cxy_CustomBtn
//
//  Created by 华美赛佳 on 2017/3/16.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import "CxyButton.h"

@implementation CxyButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        
        return self.titleRect;
    }
    
    
    return [super titleRectForContentRect:contentRect];

}


-(CGRect)imageRectForContentRect:(CGRect)contentRect{

    if (!CGRectIsEmpty(self.imageRect)&&!CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }

    
    return [super imageRectForContentRect:contentRect];
}


@end

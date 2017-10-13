//
//  YBXClearView.m
//  ChoosePhoto
//
//  Created by CHENG on 17/1/20.
//  Copyright © 2017年 YBX. All rights reserved.
//

#import "YBXClearView.h"

@implementation YBXClearView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // View settings
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(24.0, 24.0);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, 12, 12, 11.5, 0, 2 *M_PI, 0);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0);
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Checkmark
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);
    
    CGContextMoveToPoint(context, 6.0, 12.0);
    CGContextAddLineToPoint(context, 10.0, 16.0);
    CGContextAddLineToPoint(context, 18.0, 8.0);
    
    CGContextStrokePath(context);

}



@end

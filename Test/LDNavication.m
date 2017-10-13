//
//  LDNavication.m
//  Test
//
//  Created by 宜必鑫科技 on 2017/9/25.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDNavication.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LDNavication

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, WIDTH, 64);
        self.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:224.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, WIDTH - 100, 44)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBut.frame = CGRectMake(0, 20, 44, 44);
        [self.leftBut setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
        [self addSubview:self.leftBut];
        
        self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBut.frame = CGRectMake(0, WIDTH - 44, 44, 44);
        [self addSubview:self.rightBut];
    }
    return  self;
}



@end

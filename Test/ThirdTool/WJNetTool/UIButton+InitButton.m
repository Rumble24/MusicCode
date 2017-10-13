//
//  UIButton+InitButton.m
//  UI14_XML_JSON
//
//  Created by lzhr on 15/3/6.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "UIButton+InitButton.h"
#import "PublicModel.h"

@implementation UIButton (InitButton)

+ (instancetype)buttonWithTitle:(NSString *)title
                          frame:(CGRect)frame
                         target:(id)target
                         action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[PublicModel colorWithHexString:@"#648398"] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end

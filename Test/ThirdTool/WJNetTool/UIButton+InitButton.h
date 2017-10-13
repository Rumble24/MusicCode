//
//  UIButton+InitButton.h
//  UI14_XML_JSON
//
//  Created by lzhr on 15/3/6.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (InitButton)

+ (instancetype)buttonWithTitle:(NSString *)title
                          frame:(CGRect)frame
                         target:(id)target
                         action:(SEL)action;


@end

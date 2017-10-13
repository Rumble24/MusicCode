//
//  WJTextView.h
//  WJBSApp
//
//  Created by dllo on 16/7/30.
//  Copyright © 2016年 王景伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTextView : UITextView
/** 占位文字 */
@property(nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;

@end

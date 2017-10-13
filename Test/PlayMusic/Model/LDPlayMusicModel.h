//
//  LDPlayMusicModel.h
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/4.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LDPlayMusicModel : NSObject

// 作者
@property (nonatomic, strong) NSString *author;
//
@property (nonatomic, strong) NSNumber *browse_num;
// 文件总大小
@property (nonatomic, strong) NSString *file_size;
// 背景图片
@property (nonatomic, strong) NSString *imgurl;
//
@property (nonatomic, strong) NSString *source;
// 
@property (nonatomic, strong) NSString *title;
//
@property (nonatomic, strong) NSNumber *total_time;
//
@property (nonatomic, strong) NSString *url;
//
@property (nonatomic, strong) NSString *ID;
//
@property (nonatomic, strong) NSString *lable;

@property (nonatomic, strong) NSNumber *RN;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

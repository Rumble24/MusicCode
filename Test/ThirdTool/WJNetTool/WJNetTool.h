//
//  WJNetTool.h
//  WJBSApp
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 王景伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(id resuposeObject);  //上传下载 会用到task

typedef void (^failureBlock) (NSError *error);

// 返回值的类型 有时候返回值会不一样
typedef NS_ENUM(NSUInteger, WJResponseStyle) {
    WJJSON,
    WJDATA,
    WJXML,
};

// body的类型
typedef NS_ENUM(NSUInteger, WJBodyStyle) {
    WJBodyString,
    WJBodyJSON,
};

@interface WJNetTool : NSObject

+ (void)GET:(NSString *)url
       body:(id)body
     header:(NSDictionary *)header
   response:(WJResponseStyle)responseStyle
    success:(successBlock)success
    failure:(failureBlock)failure;


+ (void)POST:(NSString *)url
       body:(id)body
   bodyStyle:(WJBodyStyle)bodyStyle
     header:(NSDictionary *)header
   response:(WJResponseStyle)responseStyle
    success:(successBlock)success
    failure:(failureBlock)failure;

- (void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                          succeedBlock:(void (^)(NSDictionary *dict))succeedBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;


@end

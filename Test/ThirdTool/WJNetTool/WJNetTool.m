//
//  WJNetTool.m
//  WJBSApp
//
//  Created by dllo on 16/7/13.
//  Copyright © 2016年 王景伟. All rights reserved.
//

#import "WJNetTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation WJNetTool

+ (void)GET:(NSString *)url body:(id)body header:(NSDictionary *)header response:(WJResponseStyle)responseStyle success:(successBlock)success failure:(failureBlock)failure
{
    // 1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.设置请求头
    if (header) {
        for (NSString *key in header) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    // HTTPS
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    // 3.返回值类型
    switch (responseStyle) {
        case WJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case WJDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case WJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 4.设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 5. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6.使用AFN进行网络请求
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

+ (void)POST:(NSString *)url
        body:(id)body
   bodyStyle:(WJBodyStyle)bodyStyle
      header:(NSDictionary *)header
    response:(WJResponseStyle)responseStyle
     success:(successBlock)success
     failure:(failureBlock)failure
{
    // 1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2. 设置Body的数据类型
    switch (bodyStyle) {
        case WJBodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case WJBodyString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        default:
            break;
    }
    
    // 3.设置请求头
    if (header) {
        for (NSString *key in header) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    // HTTPS
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    // 4.返回值类型
    switch (responseStyle) {
        case WJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case WJDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case WJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 5.设置响应数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 6. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 7.使用AFN进行网络请求
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(![responseObject isKindOfClass:[NSDictionary class]])
        {
            NSError *error = [NSError errorWithDomain:@"返回值不是一个字典" code:100 userInfo:nil];
            failure(error);
            [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showImage:NULL status:@"出现未知错误~"];
            return;
        }
        NSDictionary *dic = responseObject;
        
        if (![dic[@"status"] isEqualToString:@"0"])
        {
            NSError *error = [NSError errorWithDomain:dic[@"msg"] code:100 userInfo:nil];
            failure(error);
            [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showImage:NULL status:dic[@"msg"]];
            return;
        }
        
        if (responseObject) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"抱歉，网络堵车啦~"];
    }];
    
}


/**
 *  多图上传
 */
- (void)startMultiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)images parameterOfimages:(NSString *)parameter parametersDict:(NSDictionary *)parameters succeedBlock:(void (^)(NSDictionary *dict))succeedBlock failedBlock:(void (^)(NSError *error))failedBlock
{
    if (images.count == 0) {
        NSLog(@"图片数组计数为零");
        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
        }
    }
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //以下三项manager的属性根据需要进行配置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        for (UIImage *image in images)
        {
            NSData *imageData = [self compressOriginalImage:image toMaxDataSizeKBytes:100];
            NSString *fileNmae = [self typeForImageData:imageData];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileNmae mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        succeedBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failedBlock(error);
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showImage:NULL status:@"抱歉，网络堵车啦~"];
            [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
        }
    }];
}


- (NSString *)typeForImageData:(NSData *)data
{
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"image/jpeg";
            
        case 0x89:
            
            return @"image/png";
            
        case 0x47:
            
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"image/tiff";
            
    }
    return nil;
}
#pragma mark - 压缩图片
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    UIImage *OriginalImage = image;
    
    // 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    
    // 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
    while (dataKBytes > size)
    {
        while (dataKBytes > size && maxQuality > 0.1f)
        {
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if(dataKBytes <= size )
            {
                return data;
            }
        }
        OriginalImage =[self compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.8];
        image = OriginalImage;
        data = UIImageJPEGRepresentation(image, 1.0);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.9f;
    }
    return data;
}

#pragma mark - 改变图片的大小
-(UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth
{
    CGSize imageSize = image.size;
    CGFloat Originalwidth = imageSize.width;
    CGFloat Originalheight = imageSize.height;
    CGFloat targetHeight = Originalheight / Originalwidth * targetWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end

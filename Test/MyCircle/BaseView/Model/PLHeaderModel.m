//
//  PLHeaderModel.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/26.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PLHeaderModel.h"
#import "PublicModel.h"
#import "ImageModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PLHeaderModel


- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray= [NSMutableArray array];
        NSArray *array = [_images componentsSeparatedByString:@","];
        

        if(array.count == 0)
        {
            return _imageArray;
        }
        
        if (array.count == 1)
        {
            NSString *str = array[0];
            if ([PublicModel isBlankString:str])
            {
                return _imageArray;
            }
        }
        
        for (int i = 0; i < array.count; i++)
        {
            NSArray *image1 = [array[i] componentsSeparatedByString:@"-"];
            if (image1.count == 1)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"imgurl"] = image1[0];
                dic[@"width"] = [NSString stringWithFormat:@"%f",(WIDTH - 30)];
                dic[@"height"] = [NSString stringWithFormat:@"%d",330];
                [_imageArray addObject:dic];
            }
            else
            {
                NSArray *imagesize = [image1[1] componentsSeparatedByString:@"*"];
                float imageOW = [imagesize[0] floatValue];
                float imageOH = [imagesize[1] floatValue];
                float imageW,imageH;
                if (imageOW/2 > (WIDTH - 30))
                {
                    imageW = (WIDTH - 30);
                    imageH = (imageOH *imageW) / imageOW;
                }
                else
                {
                    imageW = imageOW/2;
                    imageH = imageOH/2;
                }
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"imgurl"] = image1[0];
                dic[@"width"] = [NSString stringWithFormat:@"%f",imageW];
                dic[@"height"] = [NSString stringWithFormat:@"%f",imageH];
                [_imageArray addObject:dic];
            }
        }
    }
    
    return _imageArray;
}

- (NSMutableArray *)imageModelArray
{
    if (!_imageModelArray)
    {
        _imageModelArray= [NSMutableArray array];
        
        for (NSDictionary *dic in self.imageArray)
        {
            ImageModel *model = [[ImageModel alloc]initWithDic:dic];
            [_imageModelArray addObject:model];
        }
    }
    return _imageModelArray;
}

- (NSMutableArray *)positionArray
{
    if (!_positionArray)
    {
        _positionArray= [NSMutableArray array];
        
        CGFloat height;
        if (self.is_highlight == 0)
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
            CGRect rect = [self.title boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            height = 55 + 15 + rect.size.height + 15;
        }
        else
        {
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
            CGRect rect = [self.title boundingRectWithSize:CGSizeMake(WIDTH - 42, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            height = 55 + 15 + rect.size.height + 15;
        }
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        height = height + 15 + rect.size.height;
        
        
        CGFloat dicHeight = 0.0;
        for (NSDictionary *dic in self.imageArray)
        {
            NSNumber *height = [NSNumber numberWithFloat:(dicHeight + [dic[@"height"] floatValue] / 2.0f)];
            [_positionArray addObject:height];
            dicHeight += [dic[@"height"] floatValue];
        }
        
    }
    return _positionArray;
}


- (CGFloat)collectionHeight
{
    _collectionHeight = 0;
    for (int i = 0; i < self.imageArray.count; i++)
    {
        NSDictionary *dic = self.imageArray[i];
        float imageH = [dic[@"height"] floatValue];
        _collectionHeight += imageH;
    }
    return _collectionHeight;
}

- (CGFloat)cellHeight
{
    if (self.is_highlight == 0)
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        CGRect rect = [self.title boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        _cellHeight = 55 + 15 + rect.size.height + 15;
    }
    else
    {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        CGRect rect = [self.title boundingRectWithSize:CGSizeMake(WIDTH - 42, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        _cellHeight = 55 + 15 + rect.size.height + 15;
    }
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.content boundingRectWithSize:CGSizeMake(WIDTH - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _cellHeight = _cellHeight + 15 + rect.size.height;

    _cellHeight += self.collectionHeight + 45;
    return _cellHeight;
}

@end

//
//  QBImagePickerController.h
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/30.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class WJImagePickerController;

@protocol WJImagePickerControllerDelegate <NSObject>

- (void)GetAssetArray:(NSMutableArray*)array;

@end


@interface WJImagePickerController : UIViewController

/// 最大个数
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;

@property (assign, nonatomic) id <WJImagePickerControllerDelegate> delegate;

@property (nonatomic, copy) void (^ChooseImages)(NSMutableArray *array);

@end

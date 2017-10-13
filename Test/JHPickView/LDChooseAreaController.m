//
//  LDChooseAreaController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/3.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "LDChooseAreaController.h"
#import "JHPickView.h"


@interface LDChooseAreaController ()<JHPickerDelegate>

@end

@implementation LDChooseAreaController

- (void)viewDidLoad
{
    [super viewDidLoad];
    JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
    picker.delegate = self ;
    picker.arrayType = AreaArray;
    [self.view addSubview:picker];
}

#pragma mark - JHPickerDelegate

-(void)PickerSelectorIndixString:(NSString *)str
{
    NSLog(@"%@",str);  
}

- (void)PickerHideView
{
    [self dismissViewControllerAnimated:NO completion:NULL];
}
@end

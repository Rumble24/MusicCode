//
//  MedicalController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MedicalController.h"
#import "MedicalBaseController.h"
#import "UIButton+InitButton.h"
#import "WJPublishPicVC.h"
#import "PublicModel.h"
#import "PublicMedicalRecord.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MedicalController ()

@end

@implementation MedicalController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self CreteView];
    
}

- (void)CreteView
{
    self.titleArray = @[@"产检化验单",@"产检报告单",@"B超单"];
    
    self.title = @"医疗档案";
    
    UIButton *button = [UIButton buttonWithTitle:@"上传" frame:CGRectMake(0, 0, 50, 50) target:self action:@selector(OnClickRightBut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    MedicalBaseController *vc1 = [[MedicalBaseController alloc]init];
    vc1.type = @"1";
    [self addChildViewController:vc1];
    
    MedicalBaseController *vc2 = [[MedicalBaseController alloc]init];
    vc2.type = @"2";
    [self addChildViewController:vc2];
    
    MedicalBaseController *vc3 = [[MedicalBaseController alloc]init];
    vc3.type = @"3";
    [self addChildViewController:vc3];
}

- (void)OnClickRightBut
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"上传产检化验单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PublicMedicalRecord *Pic = [[PublicMedicalRecord alloc]init];
        Pic.type = @"1";
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"上传产检报告单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PublicMedicalRecord *Pic = [[PublicMedicalRecord alloc]init];
        Pic.type = @"2";
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"上传B超单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PublicMedicalRecord *Pic = [[PublicMedicalRecord alloc]init];
        Pic.type = @"3";
        [self.navigationController pushViewController:Pic animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{}];
}


- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}



@end

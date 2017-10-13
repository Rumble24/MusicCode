//
//  MedicalContentController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "MedicalContentController.h"
#import "PublicModel.h"

#import "MedicalImageCell.h"
#import "ImageModel.h"

#import "WJImagePickerController.h"

#import "WJNetTool.h"

#import "SVProgressHUD.h"

#import "LookImage.h"

#import "UIButton+InitButton.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MedicalContentController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UICollectionView *chooseImageView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation MedicalContentController
static NSString *const publishCell = @"mPublishCell";
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createView];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:@"医疗档案" frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(backToRoot)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageArray = self.model.list;
    
    self.title = @"详情";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 5)];
    lineView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.view addSubview:lineView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(puRightAction)];
    [item setTintColor:[PublicModel colorWithHexString:@"#66B4EB"]];
    self.navigationItem.rightBarButtonItem = item;
    
    NSString *content = [NSString stringWithFormat:@"备注:%@",self.model.content];
    NSDictionary *namedic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    CGRect namerect = [content boundingRectWithSize:CGSizeMake(WIDTH - 30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:namedic context:nil];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5+64, WIDTH - 30, namerect.size.height + 10)];
    label.text = content;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor=[PublicModel colorWithHexString:@"#B2BEC4"];
    [self.view addSubview:label];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(80, 130);
    self.chooseImageView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 5+64 + namerect.size.height + 10, WIDTH - 30, 300) collectionViewLayout:flowLayout];
    [self.view addSubview:self.chooseImageView];
    self.chooseImageView.backgroundColor = [UIColor whiteColor];
    self.chooseImageView.delegate = self;
    self.chooseImageView.dataSource = self;
    self.chooseImageView.showsVerticalScrollIndicator = NO;
    self.chooseImageView.scrollEnabled = NO;
    self.chooseImageView.clipsToBounds = NO;
    [self.chooseImageView registerClass:[MedicalImageCell class] forCellWithReuseIdentifier:publishCell];
}

#pragma mark - CollectionView Delelgate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:publishCell forIndexPath:indexPath];
    cell.model = self.model.list[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndexPath = indexPath;
    
    LookImage *vc = [[LookImage alloc]init];
    vc.imageArray = self.imageArray;
    vc.index = indexPath.row;
    vc.OnScrollIndex = ^(NSInteger index) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        _currentIndexPath = indexPath;
    };
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

//  点击删除
- (void)puRightAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要删除这条档案吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self ensureDelete];
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)ensureDelete
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    dic[@"id"] = self.model.dangan_id;
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getDeleteMedicalRecordURL]   body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        if(self.OnClickImage)
        {
            self.OnClickImage();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showImage:NULL status:@"删除失败~"];
    }];
}
@end

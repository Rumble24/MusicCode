//
//  PublicMedicalRecord.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/5/16.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "PublicMedicalRecord.h"
#import "WJTextView.h"
#import "UIButton+InitButton.h"
#import "AFNetworking.h"
#import "WJImagePickerController.h"
#import "PublishCell.h"
#import "WJNetTool.h"
#import "PublicModel.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PublicMedicalRecord ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,WJImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) WJTextView *textView;
@property (nonatomic, strong) UICollectionView *chooseImageView;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSDictionary *imageDic;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) UIAlertController *typeAleart;
@property (nonatomic, strong) NSString *community_id;
@end

@implementation PublicMedicalRecord

static NSString *const publishCell = @"mPublishCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    
    [self createView];
}

- (void)createView
{
    self.imageArray = [NSMutableArray array];
    self.imageDic = @{@"image":[UIImage imageNamed:@"addImage.png"]};
    [self.imageArray addObject:self.imageDic];
    
    self.title = @"上传医疗档案";
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.view.clipsToBounds = NO;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(puRightAction)];
    [item setTintColor:[PublicModel colorWithHexString:@"#66B4EB"]];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.textView = [[WJTextView alloc]initWithFrame:CGRectMake(15, 64 + 5, WIDTH - 30, HEIGHT - 69 - 310)];
    _textView.alwaysBounceVertical = YES;
    _textView.delegate = self;
    _textView.placeholder = @"内容(200字以内)";
    self.editing = YES;
    self.textView.userInteractionEnabled = YES;
    [self.view addSubview:self.textView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(80, 130);
    self.chooseImageView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, HEIGHT - 300, WIDTH - 30, 300) collectionViewLayout:flowLayout];
    [self.view addSubview:self.chooseImageView];
    self.chooseImageView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.chooseImageView.delegate = self;
    self.chooseImageView.dataSource = self;
    self.chooseImageView.showsVerticalScrollIndicator = NO;
    self.chooseImageView.scrollEnabled = NO;
    self.chooseImageView.clipsToBounds = NO;
    [self.chooseImageView registerClass:[PublishCell class] forCellWithReuseIdentifier:publishCell];
    
}

#pragma mark -- UITextFieldDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    //判读是否有文字  设置发表按钮的状态
    self.navigationItem.rightBarButtonItem.enabled = [self RightBarButtonEnble];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0)
        return YES;
    
    NSInteger existedLength = textView.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = text.length;
    if (existedLength - selectedLength + replaceLength > 200) {
        [SVProgressHUD showImage:NULL status:@"内容只可以是200字以内哦~"];
        return NO;
    }
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //拖拽时 结束编辑 退出键盘
    [self.textView endEditing:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.textView endEditing:YES];
}
- (BOOL)RightBarButtonEnble
{
    if(self.textView.hasText && self.imageArray.count > 1)
    {
        return YES;
    }
    return NO;
}







#pragma mark - CollectionView Delelgate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PublishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:publishCell forIndexPath:indexPath];
    cell.dic = self.imageArray[indexPath.row];
    cell.OnClickDelete = ^(NSDictionary *dic)
    {
        [self.imageArray removeObject:dic];
        if (self.imageArray.count < 8) {
            if (![self.imageArray containsObject:self.imageDic])
            {
                [self.imageArray addObject:self.imageDic];
            }
        }
        [self.chooseImageView reloadData];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.imageArray containsObject:self.imageDic]) {
        if(indexPath.row == self.imageArray.count - 1)
        {
            WJImagePickerController *vc = [[WJImagePickerController alloc]init];
            vc.maximumNumberOfSelection = 9 - self.imageArray.count;
            vc.delegate = self;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:navc animated:YES completion:nil];
        }
    }
}

- (void)GetAssetArray:(NSMutableArray *)array
{
    [self.imageArray removeObject:self.imageDic];
    for (UIImage *image in array)
    {
        NSDictionary *dic = @{@"asset":image};
        [self.imageArray addObject:dic];
    }
    if (self.imageArray.count < 8) {
        [self.imageArray addObject:self.imageDic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chooseImageView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = [self RightBarButtonEnble];
    });
}

//  点击发表请求数据
- (void)puRightAction
{
    if (self.textView.text.length > 200) {
        [SVProgressHUD showImage:NULL status:@"字数必须在200字以内"];
        return;
    }
    [SVProgressHUD show];
    NSMutableArray *uploadImage= [NSMutableArray array];
    for (NSDictionary *dic in self.imageArray)
    {
        if ([[dic allKeys]containsObject:@"asset"])
        {
            [uploadImage addObject:dic[@"asset"]];
        }
    }
    WJNetTool *net = [[WJNetTool alloc]init];
    [net startMultiPartUploadTaskWithURL:[PublicModel uploadFile] imagesArray:uploadImage parameterOfimages:@"123" parametersDict:nil succeedBlock:^(NSDictionary *dict) {
        
        NSArray *array = dict[@"data"][@"imgs"];
        NSMutableString *imgsStr = [[NSMutableString alloc]init];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            NSString *imgStr = [NSString stringWithFormat:@"%@,",dic[@"file_id"]];
            [imgsStr appendString:imgStr];
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
        dic[@"description"] = self.textView.text;
        dic[@"images"] = (NSString *)imgsStr;
        dic[@"type"] = self.type;
        
        NSString *dicStr = [PublicModel dictionaryToJson:dic];
        
        NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
        
        [WJNetTool POST:[PublicModel getAddMedicalRecordURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [SVProgressHUD dismiss];
            
            [self postMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
        }];
    } failedBlock:^(NSError *error) {
    }];
}


- (void)postMessage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateMedicalRecord" object:NULL userInfo:NULL];
}
@end

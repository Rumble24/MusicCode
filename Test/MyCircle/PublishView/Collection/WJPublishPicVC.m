//
//  WJPublishPicVC.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/4/24.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "WJPublishPicVC.h"
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

@interface WJPublishPicVC ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,WJImagePickerControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *classBut;
@property (nonatomic, strong) WJTextView *textView;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UIButton *chooseButton;
@property (nonatomic, strong) UICollectionView *chooseImageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSDictionary *imageDic;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) UIAlertController *typeAleart;
@property (nonatomic, strong) NSString *community_id;
@end

@implementation WJPublishPicVC

static NSString *const publishCell = @"publishCell";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    
    [self getPostType];
    [self createView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}


- (void)createView
{
    self.imageArray = [NSMutableArray array];
    self.imageDic = @{@"image":[UIImage imageNamed:@"addImage.png"]};
    [self.imageArray addObject:self.imageDic];
    
    self.view.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    
    self.title = @"发表孕妈贴";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:self action:@selector(puRightAction)];
    [item setTintColor:[PublicModel colorWithHexString:@"#66B4EB"]];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 5, WIDTH, HEIGHT - 69 - 210)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, WIDTH - 20 - WIDTH/5 - 10, 44)];
    self.textField.delegate = self;
    self.textField.placeholder = @"标题(25字以内)";
    [self.textField setValue:[UIColor grayColor]forKeyPath:@"_placeholderLabel.textColor"];
    [view addSubview:self.textField];
    
    self.classBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classBut.frame = CGRectMake(WIDTH - WIDTH/5+1, 0, WIDTH/5-1, 44);
    [self.classBut setTitle:@"所有" forState:UIControlStateNormal];
    [self.classBut setTitleColor:[PublicModel colorWithHexString:@"#66B4EB"] forState:UIControlStateNormal];
    [self.classBut addTarget:self action:@selector(OnClickTypeBut) forControlEvents:1<<6];
    self.classBut.titleLabel.font = [UIFont systemFontOfSize: 15];
    [view addSubview:self.classBut];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, 1)];
    lineView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH - WIDTH/5, 5, 1, 34)];
    lineView1.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [view addSubview:lineView1];
    
    self.textView = [[WJTextView alloc]initWithFrame:CGRectMake(15, 44 + 1, WIDTH - 30, HEIGHT - 69 - 45 - 210)];
    _textView.alwaysBounceVertical = YES; // 让他可以一直滚动
    _textView.delegate = self;
    _textView.placeholder = @"内容(1000字以内)";
    self.textView.userInteractionEnabled = YES;
    [view addSubview:self.textView];

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(80, 130);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.chooseImageView = [[UICollectionView alloc]initWithFrame:CGRectMake(25, HEIGHT - 190, WIDTH - 50, 130) collectionViewLayout:flowLayout];
    [self.view addSubview:self.chooseImageView];
    self.chooseImageView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.chooseImageView.delegate = self;
    self.chooseImageView.dataSource = self;
    self.chooseImageView.showsHorizontalScrollIndicator = NO;
    [self.chooseImageView registerClass:[PublishCell class] forCellWithReuseIdentifier:publishCell];
    
}

#pragma mark -- UITextFieldDelegate
- (void)textViewDidChange:(UITextView *)textView{
    //判读是否有文字  设置发表按钮的状态
    self.navigationItem.rightBarButtonItem.enabled = [self RightBarButtonEnble];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.navigationItem.rightBarButtonItem.enabled = [self RightBarButtonEnble];
    if (string.length == 0)
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 25) {
        [SVProgressHUD showImage:NULL status:@"标题只可以是25字以内哦~"];
        return NO;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0)
        return YES;
    
    NSInteger existedLength = textView.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = text.length;
    if (existedLength - selectedLength + replaceLength > 1000) {
        [SVProgressHUD showImage:NULL status:@"内容只可以是1000字以内哦~"];
        return NO;
    }
    return YES;
}
- (BOOL)RightBarButtonEnble
{
    if(self.textField.hasText && self.textView.hasText)
    {
        return YES;
    }
    return NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //拖拽时 结束编辑 退出键盘
    [self.textView endEditing:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.textView endEditing:YES];
}


- (void)OnClickTypeBut
{
    [self presentViewController:self.typeAleart animated:YES completion:^{}];
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
            vc.maximumNumberOfSelection = 10 - self.imageArray.count;
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
    if (self.imageArray.count < 9) {
        [self.imageArray addObject:self.imageDic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chooseImageView reloadData];
    });
}

//  点击发表请求数据
- (void)puRightAction
{
    [SVProgressHUD show];
    if(self.imageArray.count == 1)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
        dic[@"title"] = self.textField.text;
        dic[@"content"] = self.textView.text;
        dic[@"community_id"] = self.community_id;
        
        NSString *dicStr = [PublicModel dictionaryToJson:dic];        
        NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
        
        [WJNetTool POST:[PublicModel getPublishURL] body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
            [SVProgressHUD dismiss];
            [self postMessage];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
        }];
    }
    else
    {
        WJNetTool *net = [[WJNetTool alloc]init];
        NSMutableArray *uploadImage= [NSMutableArray array];
        for (NSDictionary *dic in self.imageArray)
        {
            if ([[dic allKeys]containsObject:@"asset"])
            {
                [uploadImage addObject:dic[@"asset"]];
            }
        }
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
            dic[@"title"] = self.textField.text;
            dic[@"content"] = self.textView.text;
            dic[@"images"] = (NSString *)imgsStr;
            dic[@"community_id"] = self.community_id;
            
            NSString *dicStr = [PublicModel dictionaryToJson:dic];
            
            NSString *bodyStr = [NSString stringWithFormat:@"action=%@",dicStr];
            
            [WJNetTool POST:[PublicModel getPublishURL]  body:bodyStr bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
                [SVProgressHUD dismiss];
                [self postMessage];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSError *error) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }];
        } failedBlock:^(NSError *error) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    }
}

- (void)getPostType
{
    [WJNetTool POST:[PublicModel getMyPostTypeURL] body:NULL bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        NSDictionary *dic = (NSDictionary *)resuposeObject;
        self.typeArray = dic[@"data"][@"list"];
        self.typeAleart = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"所有" style:UIAlertActionStyleCancel handler:nil];
        [self.typeAleart  addAction:cancelAction];

        for (int i = 0; i<self.typeArray.count; i++)
        {
            NSDictionary *dic = self.typeArray[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:dic[@"name"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                self.community_id = dic[@"community_id"];
                [self.classBut setTitle:dic[@"name"] forState:UIControlStateNormal];
            }];

            [self.typeAleart addAction:action];
        }
    } failure:^(NSError *error) {
    }];
}

- (void)postMessage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateMyCircleFirend" object:NULL userInfo:NULL];
}

@end

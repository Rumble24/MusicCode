//
//  QBImagePickerController.m
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/30.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "WJImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "QBAssetsCollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WJImagePickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/// 所有资源的文件夹
@property (nonatomic, strong, readwrite) ALAssetsLibrary *assetsLibrary;
/// 图片的数组
@property (nonatomic, copy, readwrite) NSArray *assetsArray;
/// 创建一个CollectionView
@property (nonatomic, strong) UICollectionView *allImageCollectionView;
/// 保存选择的多张图片
@property (nonatomic, strong) NSMutableArray *selectALAssets;
/// 创建右面的按钮
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation WJImagePickerController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAssetsGroupsWithcompletion:^(NSArray *assetsGroups) {
        self.assetsArray = assetsGroups;
        [self.allImageCollectionView reloadData];
    }];
    NSString *str = [NSString stringWithFormat:@"完成(%ld/%ld)",self.selectALAssets.count,self.maximumNumberOfSelection];
    
    [self.rightButton setTitle:str forState:0];
    self.navigationItem.rightBarButtonItem.enabled = [self rightButtonEnabled];
}

#pragma mark - 便利所有的图片得到
- (void)loadAssetsGroupsWithcompletion:(void (^)(NSArray *assetsGroups))completion
{
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop)
     {
         if (assetsGroup)
         {
             //遍历相册中所有的资源(照片,视频)
             [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                 if (result)
                 {
                     //将资源存储到数组中
                     [assetsGroups addObject:result];
                 }
             }];
         }
         
         if (completion) {
             // 需要反向便利
             NSArray* reversedArray = [[assetsGroups reverseObjectEnumerator] allObjects];
             completion(reversedArray);
         }
         
     } failureBlock:^(NSError *error) {
         NSLog(@"Error: %@", [error localizedDescription]);
     }];
    
}


#pragma mark - 如果是单选那么点击一个就选中返回。如果是多个那么需要加入数组
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置不让系统改变坐标
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setConfig];
    
    [self createView];
    
    self.selectALAssets = [NSMutableArray array];
}

- (void)setConfig
{
    self.title = @"选择图片";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 100, 25);
    self.rightButton.backgroundColor = [UIColor colorWithRed:50/255.0 green:175/255.0 blue:75/255.0 alpha:1.0];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.rightButton setTitle:@"完成" forState:0];
    [self.rightButton addTarget:self action:@selector(done:) forControlEvents:1<<6];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}


#pragma mark -  确定按钮
- (void)done:(id)sender
{
    if (self.maximumNumberOfSelection > 0)
    {
        
        NSMutableArray *array = [NSMutableArray array];
        //异步执行队列任务
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            
            for (ALAsset *asset  in self.selectALAssets)
            {
                UIImage *image =  [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                [array addObject:image];
            }
            [self.delegate GetAssetArray:array];
        });
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark -  取消按钮
- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - 创建collectionView
- (void)createView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    // 上左右缩进10.
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((WIDTH - 20)/4, (WIDTH - 20)/4);
    
    
    self.allImageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) collectionViewLayout:layout];
    self.allImageCollectionView.backgroundColor = [UIColor whiteColor];
    self.allImageCollectionView.delegate=self;
    self.allImageCollectionView.dataSource=self;
    [self.allImageCollectionView registerClass:[QBAssetsCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    if (self.maximumNumberOfSelection > 1) {
        self.allImageCollectionView.allowsMultipleSelection = YES;
    }
    [self.view addSubview:self.allImageCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QBAssetsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    cell.showsOverlayViewWhenSelected = YES;
    cell.asset = self.assetsArray[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.assetsArray[indexPath.row];
    
    [self.selectALAssets addObject:asset];
    
    NSString *str = [NSString stringWithFormat:@"完成(%ld/%ld)",self.selectALAssets.count,self.maximumNumberOfSelection];
    
    [self.rightButton setTitle:str forState:0];
    self.navigationItem.rightBarButtonItem.enabled = [self rightButtonEnabled];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.assetsArray[indexPath.row];
    
    [self.selectALAssets removeObject:asset];
    
    NSString *str = [NSString stringWithFormat:@"完成(%ld/%ld)",self.selectALAssets.count,self.maximumNumberOfSelection];
    
    [self.rightButton setTitle:str forState:0];
    self.navigationItem.rightBarButtonItem.enabled = [self rightButtonEnabled];
}

- (BOOL)rightButtonEnabled
{
    if (self.selectALAssets.count <= self.maximumNumberOfSelection) {
        return YES;
    }
    return NO;
}
@end




























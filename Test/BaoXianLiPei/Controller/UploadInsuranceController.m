//
//  UploadInsuranceController.m
//  CircleOfFriends
//
//  Created by 宜必鑫科技 on 2017/7/19.
//  Copyright © 2017年 宜必鑫科技. All rights reserved.
//

#import "UploadInsuranceController.h"
#import "UIButton+InitButton.h"
#import "UploadInformationCell.h"
#import "LDLabel.h"
#import "WJImagePickerController.h"
#import "PublicModel.h"
#import "WJNetTool.h"
#import "SVProgressHUD.h"
#import "TTTAttributedLabel.h"
//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface UploadInsuranceController ()<UITableViewDelegate,UITableViewDataSource,WJImagePickerControllerDelegate,TTTAttributedLabelDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *informationLabel;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSDictionary *imageDic;

@end

@implementation UploadInsuranceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadNewData];
    
    [self createView];
}

- (void)createView
{
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"上传理赔照片";
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    
    self.imageArray = [NSMutableArray array];
    self.imageDic = @{@"image":[UIImage imageNamed:@"addImage.png"]};
    [self.imageArray addObject:self.imageDic];
    
    UIButton *leftBtn = [UIButton buttonWithTitle:NULL frame:CGRectMake(0, 0, 44, 44) target:self action:@selector(OnClickLeftBtn)];
    [leftBtn setImage:[UIImage imageNamed:@"backBtn.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(puRightAction)];
    [item setTintColor:[PublicModel colorWithHexString:@"#66B4EB"]];
    self.navigationItem.rightBarButtonItem = item;
    
    self.headerView = [[UIView alloc]init];
    self.informationLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 0)];
    self.informationLabel.delegate = self;
    self.informationLabel.textColor = [PublicModel colorWithHexString:@"#52BEA4"];
    self.informationLabel.numberOfLines = 0;
    self.informationLabel.backgroundColor = [UIColor whiteColor];
    self.informationLabel.font = [UIFont systemFontOfSize:15];
    
    self.type = @"2";
    
    if ([self.type isEqualToString:@"1"])
    {
        self.informationLabel.text =@"1、理赔申请书；(点击下载)\n2、保险单或投保证明；\n3、受益人身份证明、关系证明和受益人银行卡材料；\n4、户籍注销证明、死亡证明或法医尸检报告；若为宣告死亡应提供人民法院出具的宣告死亡证明文件；\n5、医院诊疗相关资料（门诊、住院病历；检查报告单；手术记录单等）；\n6、事故相关证明材料；\n7、连带被保险人与被保险人关系证明，被保险人银行卡材料（仅连带被保险人身故时提供）；\n8、保险人认可的伤残鉴定机构出具的被保险人全残鉴定报告（仅被保险人全残时提供）。";
    }
    else if ([self.type isEqualToString:@"2"])
    {
        self.informationLabel.text = @"1、理赔申请书；(点击下载)\n2、保险单或投保证明；\n3、被保险人身份证明和银行卡材料；\n4、被保险人诊疗相关资料（门诊、住院病历；检查报告单；手术记录单等）；\n5、被保险人事故相关证明材料。";
    }
    else if ([self.type isEqualToString:@"3"])
    {
        self.informationLabel.text = @"1、理赔申请书；(点击下载)\n2、保险单或投保证明；\n3、连带被保险人与被保险人的关系证明，被保险人银行卡材料；\n4、本公司认可的医院出具的附有病理显微镜检查、血液检验及其他科学方法检验报告的疾病诊断证明书（仅先天性畸形责任时提供）；\n5、指定医院出具的连带被保险人特定遗传性代谢疾病可疑阳性证明材料及病历（仅特定遗传性代谢疾病诊查责任时提供）；\n6、指定医院出具的连带被保险人特定遗传性代谢疾病诊断/确诊报告书及病历，诊断报告书包括但不限于以下几种：\n（1）CAH报告单\n（2）G6PD缺乏症报告单\n（3）PKU-GCMS检测报告单\n（4）PKU-串联质谱报告单\n（5）PKU-肌酐检测报告单\n（6）PKU-尿蝶呤检测报告单\n（7）高苯丙氨酸血基因诊断报告单\n（8）甲功三项报告单（或甲功五项报告单）";
    }

    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.informationLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.informationLabel.frame = CGRectMake(10, 0, ScreenWidth - 20, rect.size.height + 20);
    
    NSRange nameRange = {9,4};
    [self.informationLabel addLinkToURL:[NSURL URLWithString:[PublicModel getDowanLoadLine]] withRange:nameRange];

    
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, rect.size.height + 30);
    self.headerView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height + 20, ScreenWidth, 10)];
    lineView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    [self.headerView addSubview:lineView];
    [self.headerView addSubview:self.informationLabel];
    
       
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight - 10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [PublicModel colorWithHexString:@"#edf4f8"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[UploadInformationCell class] forCellReuseIdentifier:@"UploadInformationCellId"];
    [self.view addSubview:self.tableView];
}

- (void)OnClickLeftBtn
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UploadInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadInformationCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.imageArray[indexPath.row];
    cell.OnClickDelete = ^(NSDictionary *dic)
    {
        [self.imageArray removeObject:dic];
        [self.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.imageArray containsObject:self.imageDic]) {
        if(indexPath.row == self.imageArray.count - 1)
        {
            WJImagePickerController *vc = [[WJImagePickerController alloc]init];
            vc.maximumNumberOfSelection = 50 - self.imageArray.count;
            vc.delegate = self;
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:navc animated:YES completion:nil];
        }
    }
}

- (void)GetAssetArray:(NSMutableArray*)array
{
    [self.imageArray removeObject:self.imageDic];
    for (UIImage *image in array)
    {
        NSDictionary *dic = @{@"asset":image};
        [self.imageArray addObject:dic];
    }
    if (self.imageArray.count < 50) {
        [self.imageArray addObject:self.imageDic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.imageArray.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    });
}



//  点击发表请求数据
- (void)puRightAction
{
    [SVProgressHUD show];
    
    if (self.imageArray.count == 1) {
        [SVProgressHUD showImage:nil status:@"请选择图片"];
        return;
    }
    
    WJNetTool *net = [[WJNetTool alloc]init];
    NSMutableArray *uploadImage= [NSMutableArray array];
    for (NSDictionary *dic in self.imageArray)
    {
        if ([[dic allKeys]containsObject:@"asset"])
        {
            [uploadImage addObject:dic[@"asset"]];
        }
    }
    [net startMultiPartUploadTaskWithURL:[PublicModel getUploadFileClaimURL] imagesArray:uploadImage parameterOfimages:@"123" parametersDict:@{@"registNo":@"07020112202017000009"} succeedBlock:^(NSDictionary *dict) {
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:^{}];
    } failedBlock:^(NSError *error) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}


#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"linkClick");
    [[UIApplication sharedApplication] openURL:url];
}
- (void)loadNewData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(![PublicModel isBlankString:[PublicModel getUserid]] && ![PublicModel isBlankString:[PublicModel getToken]])
    {
        dic[@"userid"] = [PublicModel getUserid];
        dic[@"token"] = [PublicModel getToken];
    }
    else
    {
        [SVProgressHUD showImage:NULL status:@"请先登录~"];
        return;
    }
    NSString *body = [NSString stringWithFormat:@"action=%@",dic];
    
    [WJNetTool POST:[PublicModel getClaimFileListURL]  body:body bodyStyle:WJBodyString header:nil response:WJJSON success:^(id resuposeObject) {
        
        NSLog(@"请求成功=%@",(NSDictionary*)resuposeObject);
        
        NSDictionary *dic = resuposeObject;
        
        NSArray *array = dic[@"data"][@"list"];
        
//        for (UIImage *image in array)
//        {
//            NSDictionary *dic = @{@"asset":image};
//            [self.imageArray addObject:dic];
//        }

        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
    }];
}
@end






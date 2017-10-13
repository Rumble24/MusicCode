//
//  MemberController.m
//  Unity-iPhone
//
//  Created by 宜必鑫科技 on 2017/8/27.
//
//

#import "MemberController.h"
#import "PublicModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface MemberController ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat value;

@end

@implementation MemberController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:_backView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(showAnimation) userInfo:nil repeats:YES];
    
    _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(37.5, (HEIGHT - 140 - (WIDTH - 115) / 3.931f - 60)/2.0f - 50, WIDTH - 75,140 + (WIDTH - 115) / 3.931f + 60)];
    _backImage.layer.cornerRadius = 22;
    _backImage.layer.masksToBounds = YES;
    _backImage.backgroundColor = [UIColor whiteColor];
    _backImage.userInteractionEnabled = YES;
    [self.view addSubview:_backImage];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 75, 60)];
    label1.backgroundColor = [PublicModel colorWithHexString:@"91E0CC"];
    label1.textAlignment = 1;
    label1.font = [UIFont systemFontOfSize:25];
    label1.numberOfLines = 0;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"友情提示";
    [_backImage addSubview:label1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, WIDTH - 95, 60)];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = 0;
    label.textColor = [PublicModel colorWithHexString:@"52BEA4"];
    label.text = @"当前医生未在线，您可以转入保健咨询咨询相关问题";
    [_backImage addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 130, WIDTH - 75 - 40, (WIDTH - 115) / 4.1f)];
    imageView.image = [UIImage imageNamed:@"memberImage.png"];
    [_backImage addSubview:imageView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(20, 140 + (WIDTH - 115) / 3.931f, WIDTH - 115, 44);
    but.layer.cornerRadius = 22;
    but.layer.masksToBounds = YES;
    [but setTitle:@"确认" forState:0];
    [but addTarget:self action:@selector(OnClickBut) forControlEvents:1<<6];
    but.backgroundColor = [PublicModel colorWithHexString:@"91E0CC"];
    [_backImage addSubview:but];
}

- (void)OnClickBut
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(hideAnimation) userInfo:nil repeats:YES];
}


-(void)showAnimation
{
    _value +=0.02;
    if (_value < 0.8f)
    {
        _backView.backgroundColor = RGBA(51, 51, 51, _value);
        NSLog(@"%f",_value);
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)hideAnimation
{
    _value-=0.02;
    if (_value > 0)
    {
        _backView.backgroundColor = RGBA(51, 51, 51, _value);
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}










@end

//
//  TestViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TestViewController.h"
#import "PetNameViewController.h"

@interface TestViewController ()
@property (nonatomic, assign)NSInteger timeNumber;
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UILabel *registL;
@property (nonatomic, strong)UILabel *myPhoneL;
@property (nonatomic, strong)UILabel *tipL;
@property (nonatomic, strong)UILabel *timeL;
@property (nonatomic, strong)UIButton *backB;
@property (nonatomic, strong)UIButton *nextB;
@property (nonatomic, strong)UIButton *resetB;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UITextField *tipTF;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@end

@implementation TestViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.timeNumber <= 0) {
        self.timeNumber = 60;
    } else {
    [self timer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.timeNumber = 60;
    //创建背景界面
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,20, kScreenWidth, kScreenHeight)];
    self.imageV.image = [UIImage imageNamed:@"冰封王座之巅.png"];
    [self.view addSubview:self.imageV];
    [self.imageV addSubview:self.effectV];
    //创建注册标签
    self.registL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-45, 30, 90, kScreenHeight/11)];
    self.registL.text = @"手机注册";
    self.registL.textColor = [UIColor whiteColor];
    self.registL.font = [UIFont systemFontOfSize:20];
    self.registL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.registL];
    //创建下划线
    self.lineV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/11 +30, kScreenWidth, 1)];
    self.lineV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV];
    //创建当前手机号码标签
    self.myPhoneL = [[UILabel alloc]initWithFrame:CGRectMake(50, kScreenHeight*2/13, kScreenWidth-100, kScreenHeight/15)];
    self.myPhoneL.text = [NSString stringWithFormat:@"你的手机号： +86 %@",self.phoneStr];
    self.myPhoneL.textColor = [UIColor whiteColor];
    self.myPhoneL.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.myPhoneL];
    //创建当前手机号码标签
    self.tipL = [[UILabel alloc]initWithFrame:CGRectMake(50, kScreenHeight*2/13+kScreenHeight/15, 160, kScreenHeight/16)];
    self.tipL.text = @"请输入接收到的短信信息";
    self.tipL.textColor = [UIColor whiteColor];
    self.tipL.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.tipL];
    //创建密码TF
    self.tipTF = [[UITextField alloc]initWithFrame:CGRectMake(50,kScreenHeight*2/13+kScreenHeight/15+kScreenHeight/16, kScreenWidth-100, kScreenHeight/14)];
    self.tipTF.keyboardType = UIKeyboardTypeNumberPad;
    self.tipTF.textColor = [UIColor whiteColor];
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"盾牌 (1).png"]];
    self.tipTF.leftView = image1;
    self.tipTF.leftViewMode = UITextFieldViewModeAlways;
    self.tipTF.layer.masksToBounds = YES;
    self.tipTF.layer.cornerRadius = 6;
    UIColor *color1 = [UIColor whiteColor];
    self.tipTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName:color1}];
    self.tipTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.tipTF.layer.borderWidth= 1.0f;
    [self.view addSubview:self.tipTF];
    //创建倒计时标签
    self.timeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-70, kScreenHeight*2/13+kScreenHeight/15+kScreenHeight/14+kScreenHeight/16, 60, kScreenHeight/16)];
    self.timeL.text = @"剩余60s";
    self.timeL.textColor = [UIColor whiteColor];
    self.timeL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.timeL];
    //创建重新发送按钮
    self.resetB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.resetB.frame = CGRectMake(kScreenWidth/2+10, kScreenHeight*2/13+kScreenHeight/15+kScreenHeight/14+kScreenHeight/16, 60,kScreenHeight/16);
    self.resetB.tintColor = [UIColor lightGrayColor];
    [self.resetB setTitle:@"重新发送" forState:UIControlStateNormal];
    self.resetB.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.resetB addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetB];
    //创建下一步按钮
    self.nextB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextB.frame = CGRectMake(50,  kScreenHeight*2/13+kScreenHeight/15+kScreenHeight/14+kScreenHeight/16+kScreenHeight/16, kScreenWidth-100, kScreenHeight/12);
    [self.nextB setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextB.layer setMasksToBounds:YES];
    [self.nextB.layer setBorderWidth:1];
    [self.nextB.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.nextB addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextB];
    //创建返回按钮
    self.backB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backB.frame = CGRectMake(10, 50, 20,20);
    self.backB.tintColor = [UIColor whiteColor];
    [self.backB setImage:[UIImage imageNamed:@"箭头 (2).png"] forState:UIControlStateNormal];
    [self.backB addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backB];
    // Do any additional setup after loading the view.
}

#pragma mark 计时器
-(NSTimer *)timer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    return _timer;
}

#pragma mark 倒计时
-(void)time{
    self.timeNumber--;
    if (self.timeNumber <= 0) {
        [_timer invalidate];
        [self.resetB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    self.timeL.text = [NSString stringWithFormat:@"剩余%lds",_timeNumber];
    
}

#pragma mark ----- 创建滤镜 -----
-(UIBlurEffect *)beffect{
    if (!_beffect) {
        _beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    return _beffect;
}

-(UIVisualEffectView *)effectV{
    if (!_effectV) {
        _effectV = [[UIVisualEffectView alloc]initWithEffect:self.beffect];
        _effectV.frame = self.imageV.bounds;
        _effectV.alpha = 0.5;
    }
    return _effectV;
}

#pragma mark ----- 下一步方法 -----
-(void)nextAction{
    PetNameViewController *petVC = [[PetNameViewController alloc]init];
    [self.view endEditing:YES];
     __weak __typeof__(self) weakSelf = self;
    if (self.timeNumber <= 0) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"短信验证码时间过期" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    } else if (weakSelf.tipTF.text.length != 6) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"短信验证码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    } else {
    [JSMSSDK commitWithPhoneNumber:weakSelf.phoneStr verificationCode:weakSelf.tipTF.text completionHandler:^(id resultObject, NSError *error) {
    if (!error) {
         petVC.phoneStr = self.phoneStr;
        [self.navigationController pushViewController:petVC animated:YES];
            }
    else {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"短信验证错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
            }
        }];
    }
}



#pragma mark ----- 创建重发按钮方法 -----
-(void)resetAction{
    if (self.timeNumber<= 0) {
        __weak __typeof__(self) weakSelf = self;
    [JSMSSDK getVerificationCodeWithPhoneNumber:weakSelf.phoneStr andTemplateID:[NSString stringWithFormat:@"%d",1] completionHandler:^(id resultObject, NSError *error) {
    if (!error) {
        [self.resetB setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.timeNumber = 60;
        [self timer];
       } else {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"短信验证码发送失败"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark ----- 创建返回方法 -----
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

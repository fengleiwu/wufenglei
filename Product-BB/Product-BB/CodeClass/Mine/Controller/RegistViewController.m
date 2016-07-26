//
//  RegistViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RegistViewController.h"
#import "JSMSSDK.h"
#import "AFNetworkReachabilityManager.h"
#import "TestViewController.h"

@interface RegistViewController ()
@property (nonatomic, strong)UILabel *registL;
@property (nonatomic, strong)UILabel *explainL;
@property (nonatomic, strong)UILabel *delegateL;
@property (nonatomic, strong)UIButton *backB;
@property (nonatomic, strong)UIButton *nextB;
@property (nonatomic, strong)UIButton *delegateB;
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UITextField *phoneTF;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
//@property (nonatomic, strong)UITextField *
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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
    //创建说明标签
    self.explainL = [[UILabel alloc]initWithFrame:CGRectMake(50, kScreenHeight*2/11+kScreenHeight/15, kScreenWidth-100, kScreenHeight/15)];
    self.explainL.textColor = [UIColor whiteColor];
    self.explainL.text = @"为了安全，我们会向你的手机发送验证码";
    self.explainL.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.explainL];
    //创建协议标签
    self.delegateL = [[UILabel alloc]initWithFrame:CGRectMake(50, kScreenHeight*3/11 +kScreenHeight/15+kScreenHeight/12, 120, kScreenHeight/15)];
    self.delegateL.textColor = [UIColor whiteColor];
    self.delegateL.text = @"本人已阅读并同意";
    self.delegateL.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.delegateL];
    //创建返回按钮
    self.backB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backB.frame = CGRectMake(10, 50, 20,20);
    self.backB.tintColor = [UIColor whiteColor];
    [self.backB setImage:[UIImage imageNamed:@"箭头 (2).png"] forState:UIControlStateNormal];
    [self.backB addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backB];
    //创建手机号码验证框
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(50, kScreenHeight*2/11, kScreenWidth-100, kScreenHeight/15)];
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.layer.masksToBounds = YES;
    self.phoneTF.layer.cornerRadius = 6;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 30)];
    label1.text = @"+86";
    label1.textColor = [UIColor grayColor];
    self.phoneTF.leftView = label1;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.textColor = [UIColor whiteColor];
    UIColor *color = [UIColor whiteColor];
    self.phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:color}];
    self.phoneTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.phoneTF.layer.borderWidth= 1.0f;
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTF];
    //创建下一步按钮
    self.nextB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextB.frame = CGRectMake(50, kScreenHeight*3/11 +kScreenHeight/15, kScreenWidth-100, kScreenHeight/12);
    [self.nextB setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextB.layer setMasksToBounds:YES];
    [self.nextB.layer setBorderWidth:1];
    [self.nextB.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.nextB addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextB];
    //创建协议按钮
    self.delegateB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.delegateB.frame = CGRectMake(self.delegateL.frame.size.width +50, kScreenHeight*3/11 +kScreenHeight/15+kScreenHeight/12, 60, kScreenHeight/15);
    self.delegateB.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.delegateB setTitle:@"注册协议" forState:UIControlStateNormal];
    [self.delegateB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.delegateB addTarget:self action:@selector(delegateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.delegateB];
    // Do any additional setup after loading the view.
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

#pragma mark ----- 手机号输入监听 -----
-(void)textFieldDidChange:(UITextField *)phoneTF{
    if (phoneTF.text.length == 11) {
        self.nextB.backgroundColor = [UIColor whiteColor];
        [self.nextB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    } else {
        self.nextB.backgroundColor = [UIColor clearColor];
        [self.nextB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark ----- 创建下一步方法 -----
-(void)nextAction{
    if ([self validateMobile:self.phoneTF.text]) {
    [self.view endEditing: YES];
    __weak __typeof__(self) weakSelf = self;
    [JSMSSDK getVerificationCodeWithPhoneNumber:weakSelf.phoneTF.text andTemplateID:[NSString stringWithFormat:@"%d",1] completionHandler:^(id resultObject, NSError *error) {
    if (!error) {
        TestViewController *testVC = [[TestViewController alloc]init];
        testVC.phoneStr = self.phoneTF.text;
        [self.navigationController pushViewController:testVC animated:YES];
    }
    else {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"上传手机号失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    }
        }];
    } else {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"手机格式不对" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    }
}

#pragma mark ----- 判断手机格式 -----
-(BOOL)validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark ----- 查看协议方法 -----
-(void)delegateAction{

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

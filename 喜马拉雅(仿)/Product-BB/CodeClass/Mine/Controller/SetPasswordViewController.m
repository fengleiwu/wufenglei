//
//  SetPasswordViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()<XMPPStreamDelegate>
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UILabel *registL;
@property (nonatomic, strong)UIButton *backB;
@property (nonatomic, strong)UIButton *finishB;
@property (nonatomic, strong)UITextField *petTF;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@end

@implementation SetPasswordViewController

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
    self.registL.text = @"设置密码";
    self.registL.textColor = [UIColor whiteColor];
    self.registL.font = [UIFont systemFontOfSize:20];
    self.registL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.registL];
    //创建下划线
    self.lineV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/11 +30, kScreenWidth, 1)];
    self.lineV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV];
    //创建返回按钮
    self.backB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backB.frame = CGRectMake(10, 50, 20,20);
    self.backB.tintColor = [UIColor whiteColor];
    [self.backB setImage:[UIImage imageNamed:@"箭头 (2).png"] forState:UIControlStateNormal];
    [self.backB addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backB];
    //创建密码TF
    self.petTF = [[UITextField alloc]initWithFrame:CGRectMake(50,kScreenHeight*2/11, kScreenWidth-100, kScreenHeight/14)];
    self.petTF.textColor = [UIColor whiteColor];
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码.png"]];
    self.petTF.leftView = image1;
    self.petTF.leftViewMode = UITextFieldViewModeAlways;
    self.petTF.layer.masksToBounds = YES;
    self.petTF.layer.cornerRadius = 6;
    UIColor *color1 = [UIColor whiteColor];
    self.petTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入6-16位数字或字母" attributes:@{NSForegroundColorAttributeName:color1}];
    self.petTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.petTF.layer.borderWidth= 1.0f;
    self.petTF.secureTextEntry = YES;
    [self.view addSubview:self.petTF];
    //创建下一步按钮
    self.finishB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.finishB.frame = CGRectMake(50,  kScreenHeight*2/11 + kScreenHeight/14+20, kScreenWidth-100, kScreenHeight/12);
    [self.finishB setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishB.layer setMasksToBounds:YES];
    [self.finishB.layer setBorderWidth:1];
    [self.finishB.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.finishB addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishB];
    
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

#pragma mark ----- 创建完成方法 -----
-(void)finishAction{
    if ([self validatePassword:self.petTF.text]) {
        //  stream 设置代理
//        [nsuser]
//        [[XMPPManager shareInstance].stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//        [[XMPPManager shareInstance] registWithUserName:self.phoneStr petName:self.petName password:self.petTF.text];
//        NSLog(@"电话号码：%@  昵称：%@  密码：%@",self.phoneStr,self.petName,self.petTF.text);
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"密码格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:aAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark ------ XMPPStreamDelegate -----
-(void)xmppStreamDidRegister:(XMPPStream *)sender{
//    NSLog(@"注册成功");
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
//    NSLog(@"注册失败：%@",error);
}

#pragma mark ----- 判断密码格式是否正确 -----
-(BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
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

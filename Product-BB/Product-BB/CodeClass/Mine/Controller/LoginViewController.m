//
//  LoginViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface LoginViewController ()<UITextFieldDelegate,XMPPStreamDelegate>
@property (nonatomic, strong)UIButton *registB;
@property (nonatomic, strong)UIButton *backB;
@property (nonatomic, strong)UIButton *loginB;
@property (nonatomic, strong)UIButton *QQB;
@property (nonatomic, strong)UIButton *weiChatB;
@property (nonatomic, strong)UIButton *weiBOB;
@property (nonatomic, strong)UITextField *emailOrPhoneTF;
@property (nonatomic, strong)UITextField *passwordTF;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *dengluL;
@property (nonatomic, strong)UIView *lineV1;
@property (nonatomic, strong)UIView *lineV2;
@property (nonatomic, strong)UIView *lineV3;
@property (nonatomic, strong)UIView *lineV4;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@end

@implementation LoginViewController
-(void)startAnimated{
    //通知
    //键盘将要出来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    //创建登录标签
    self.dengluL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-25, 30, 50, 1)];
    self.dengluL.text = @"登录";
    self.dengluL.font = [UIFont systemFontOfSize:20];
    self.dengluL.textColor = [UIColor whiteColor];
    self.dengluL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dengluL];
    //创建划线
    self.lineV1 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight/11 +30, 1, 1)];
    self.lineV1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV1];
    self.lineV2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight/11 +30, 1, 1)];
    self.lineV2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV2];
    self.lineV3 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight*4/11, 1, 1)];
    self.lineV3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV3];
    self.lineV4 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight*4/11, 1, 1)];
    self.lineV4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineV4];
    //创建返回按钮
    self.backB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backB.frame = CGRectMake(10, 50, 20,20);
    [self.backB setImage:[UIImage imageNamed:@"箭头 (2).png"] forState:UIControlStateNormal];
    self.backB.tintColor = [UIColor whiteColor];
    [self.backB addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backB];
    //创建QQbutton
    self.QQB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.QQB.frame = CGRectMake(-kScreenHeight/11-kScreenHeight/11-kScreenWidth/9, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
    [self.QQB setImage:[UIImage imageNamed:@"QQ.png"] forState:UIControlStateNormal];
    [self.QQB addTarget:self action:@selector(QQAction) forControlEvents:UIControlEventTouchUpInside];
    self.QQB.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.QQB];
    //创建微信button
    self.weiChatB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.weiChatB.frame = CGRectMake(-kScreenHeight/11-kScreenWidth/9-kScreenHeight/22-kScreenHeight/11-kScreenWidth/9, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
    [self.weiChatB setImage:[UIImage imageNamed:@"微信 (1).png"] forState:UIControlStateNormal];
    [self.weiChatB addTarget:self action:@selector(weiChatAction) forControlEvents:UIControlEventTouchUpInside];
    self.weiChatB.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.weiChatB];
    //创建微博button
    self.weiBOB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.weiBOB.frame = CGRectMake(-kScreenHeight/11, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
    [self.weiBOB setImage:[UIImage imageNamed:@"微博 (3).png"] forState:UIControlStateNormal];
    [self.weiBOB addTarget:self action:@selector(weiBOAction) forControlEvents:UIControlEventTouchUpInside];
    self.weiBOB.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.weiBOB];
    //创建账号TF
    self.emailOrPhoneTF = [[UITextField alloc]initWithFrame:CGRectMake(50, kScreenHeight*4/11, kScreenWidth-100, 0)];
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"人气.png"]];
    self.emailOrPhoneTF.textColor = [UIColor whiteColor];
    self.emailOrPhoneTF.leftView = image1;
    self.emailOrPhoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.emailOrPhoneTF.layer.masksToBounds = YES;
    self.emailOrPhoneTF.layer.cornerRadius = 6;
    UIColor *color = [UIColor whiteColor];
    self.emailOrPhoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮箱或手机号" attributes:@{NSForegroundColorAttributeName:color}];
    self.emailOrPhoneTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.emailOrPhoneTF.layer.borderWidth= 1.0f;
    self.emailOrPhoneTF.delegate = self;
    self.emailOrPhoneTF.tag = 1;
    [self.view addSubview:self.emailOrPhoneTF];
    //创建密码TF
    self.passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(50, kScreenHeight*4/11, kScreenWidth-100, 0)];
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码.png"]];
    self.passwordTF.textColor = [UIColor whiteColor];
    self.passwordTF.leftView = image2;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.layer.masksToBounds = YES;
    self.passwordTF.layer.cornerRadius = 6;
    UIColor *color1 = [UIColor whiteColor];
    self.passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入6-16位数字或字母" attributes:@{NSForegroundColorAttributeName:color1}];
    self.passwordTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.passwordTF.layer.borderWidth= 1.0f;
    self.passwordTF.delegate = self;
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.tag = 2;
    [self.view addSubview:self.passwordTF];
    //创建注册按钮
    self.registB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registB.frame = CGRectMake(50, kScreenHeight*7/11 +20, kScreenWidth/2-5-50,kScreenHeight/12);
    [self.registB.layer setMasksToBounds:YES];
    [self.registB.layer setBorderWidth:1];
    [self.registB.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.registB.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.registB setTitle:@"注册" forState:UIControlStateNormal];
    [self.registB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registB addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    //创建登录按钮
    self.loginB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginB.frame = CGRectMake(kScreenWidth/2+5, kScreenHeight*7/11 +20, kScreenWidth/2-5-50,kScreenHeight/12);
    self.loginB.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.loginB.layer setMasksToBounds:YES];
    [self.loginB.layer setBorderWidth:1];
    [self.loginB.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.loginB setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginB addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    //实施动画
    [UIView animateWithDuration:1 animations:^{
        self.dengluL.frame = CGRectMake(kScreenWidth/2-25, 30, 50, kScreenHeight/11);
        self.lineV1.frame = CGRectMake(0, kScreenHeight/11 +30, (kScreenWidth/2), 1);
        self.lineV2.frame = CGRectMake(kScreenWidth/2, kScreenHeight/11 +30, kScreenWidth/2, 1);
        [self.view addSubview:self.backB];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
        self.QQB.frame = CGRectMake(kScreenWidth/2-kScreenHeight/22, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
        self.weiChatB.frame = CGRectMake(kScreenWidth/2-kScreenHeight/11-kScreenWidth/9-kScreenHeight/22, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
        self.weiBOB.frame = CGRectMake(kScreenWidth/2+kScreenHeight/22+kScreenWidth/9, kScreenHeight*2/11, kScreenHeight/11,kScreenHeight/11);
        self.lineV3.frame = CGRectMake(50, kScreenHeight*4/11, (kScreenWidth/2-50), 1);
        self.lineV4.frame = CGRectMake(kScreenWidth/2, kScreenHeight*4/11, kScreenWidth/2-50, 1);
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation.duration = 2;
        animation.repeatCount = 1;
        [self.QQB.layer addAnimation:animation forKey:nil];
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation1.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation1.duration = 2;
        animation1.repeatCount = 1;
        [self.weiChatB.layer addAnimation:animation1 forKey:nil];
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation2.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation2.duration = 2;
        animation2.repeatCount = 1;
        [self.weiBOB.layer addAnimation:animation2 forKey:nil];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:self.emailOrPhoneTF.frame];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(50, kScreenHeight*5/11, kScreenWidth-100,kScreenHeight/12)];
        // 这个值越大，则动画结束越快
        anim.springSpeed = 1;
        // 这个值越大， 弹力振幅越大
        anim.springBounciness = 20;
        // 动画开始时间
        anim.beginTime = 2;
        // 谁需要动画， 添加到谁的上面
        [self.emailOrPhoneTF pop_addAnimation:anim forKey:nil];
        POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim1.fromValue = [NSValue valueWithCGRect:self.passwordTF.frame];
        anim1.toValue = [NSValue valueWithCGRect:CGRectMake(50, kScreenHeight*6/11 +10, kScreenWidth-100, kScreenHeight/12)];
        anim1.springSpeed = 10;
        anim1.springBounciness = 20;
        anim1.beginTime = 2;
        [self.passwordTF pop_addAnimation:anim1 forKey:nil];
        [self.view addSubview:self.registB];
        [self.view addSubview:self.loginB];
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.registB];
    //创建背景界面
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,20, kScreenWidth, kScreenHeight)];
    self.imageV.image = [UIImage imageNamed:@"冰封王座.png"];
    [self.view addSubview:self.imageV];
    [self.imageV addSubview:self.effectV];
    [self startAnimated];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 第三方登录按钮 -----
-(void)QQAction{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
     //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
     //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
          associateHandler (user.uid, user, user);
//          NSLog(@"dd%@",user.rawData);
//          NSLog(@"dd%@",user.credential);
        // 记录登录成功的用户名和密码
        [[NSUserDefaults standardUserDefaults]setObject:user.rawData[@"nickname"] forKey:@"user"];
        [[NSUserDefaults standardUserDefaults]setObject:@"QQ" forKey:@"type"];
        [[NSUserDefaults standardUserDefaults]setObject:user.rawData[@"figureurl_qq_2"] forKey:@"picture"];
    // 本地存储
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.block11 != nil) {
                        self.block11(user.rawData[@"nickname"]);
        }
       [self dismissViewControllerAnimated:YES completion:nil];
                                   }
          onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    if (state == SSDKResponseStateSuccess) {
                                        
                                    }
                                }];
//    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//             
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 if (self.block11 != nil) {
//                     self.block11(user.nickname);
//                 }
//                 [self dismissViewControllerAnimated:YES completion:nil];
//             });
//         }
//         
//         else
//         {
//             NSLog(@"%@",error);
//         }
//         
//     }];
}

-(void)weiBOAction{
    [self connectShareSDKWithType:SSDKPlatformTypeSinaWeibo];
}

-(void)weiChatAction{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
    //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
    //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
    associateHandler (user.uid, user, user);
//    NSLog(@"dd%@",user.rawData);
//    NSLog(@"dd%@",user.credential);
    // 记录登录成功的用户名和密码
    [[NSUserDefaults standardUserDefaults]setObject:user.rawData[@"nickname"] forKey:@"user"];
    [[NSUserDefaults standardUserDefaults]setObject:@"wechat" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"picture"];
     // 本地存储
     [[NSUserDefaults standardUserDefaults] synchronize];
     if (self.block11 != nil) {
          self.block11(user.rawData[@"nickname"]);
                                       }
        [self dismissViewControllerAnimated:YES completion:nil];
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    if (state == SSDKResponseStateSuccess) {
                                        
                                    }
                                }];
}

#pragma mark ----- 第三方登录调用此方法 -----
-(void)connectShareSDKWithType:(SSDKPlatformType)type{
    [SSEThirdPartyLoginHelper loginByPlatform:type onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
        associateHandler (user.uid, user, user);
//        NSLog(@"dd%@",user.rawData);
//        NSLog(@"dd%@",user.credential);
        NSString *picture = user.rawData[@"avatar_hd"];
        // 记录登录成功的用户名和密码
        [[NSUserDefaults standardUserDefaults]setObject:user.rawData[@"name"] forKey:@"user"];
        [[NSUserDefaults standardUserDefaults]setObject:picture forKey:@"picture"];
        if (type ==SSDKPlatformTypeSinaWeibo) {
           [[NSUserDefaults standardUserDefaults]setObject:@"weibo" forKey:@"type"];
        }
        if (type == SSDKPlatformTypeQQ) {
            [[NSUserDefaults standardUserDefaults]setObject:@"QQ" forKey:@"type"];
        }
        // 本地存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
//            NSLog(@"登录成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
//            NSLog(@"登录失败");
        }
    }];
}

-(UILabel *)dengluL{
    if (!_dengluL) {
        _dengluL = [[UILabel alloc]init];
    }
    return _dengluL;
}

#pragma mark ----- 创建滤镜 -----
-(UIBlurEffect *)beffect{
    if (!_beffect) {
        _beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return _beffect;
}

-(UIVisualEffectView *)effectV{
    if (!_effectV) {
        _effectV = [[UIVisualEffectView alloc]initWithEffect:self.beffect];
        _effectV.frame = self.imageV.bounds;
        _effectV.alpha = 0.8;
    }
    return _effectV;
}

#pragma mark ----- 键盘弹出隐藏方法 -----
-(void)keyBoardShow:(NSNotification *)note{
        CGRect frame = self.view.frame;
        frame.origin.y = - self.passwordTF.height*2;
        self.view.frame =frame;
}

-(void)keyBoardHidden:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue ] animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame =frame;
    } completion:^(BOOL finished) {
        self.passwordTF.text = @"";
    }];
}

#pragma mark ----- 是textfile成为第一响应者 -----
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        textField = [self.view viewWithTag:2];
        [textField becomeFirstResponder];
    } else {
     [textField resignFirstResponder];
    }
    return  YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.passwordTF resignFirstResponder];
    [self.emailOrPhoneTF resignFirstResponder];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}

#pragma mark ----- 注册方法 -----
-(void)registAction{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}

#pragma mark ----- 登录方法 -----
-(void)loginAction{
    if (self.emailOrPhoneTF.text.length == 0) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"邮箱或手机不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    }
    if (self.passwordTF.text.length == 0) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    }
    if (![self validateMobile:self.emailOrPhoneTF.text]) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"邮箱或手机格式错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    } else  if (![self validatePassword:self.passwordTF.text]){
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"密码格式错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [a addAction:a1];
        [self presentViewController:a animated:YES completion:nil];
    } else{
        // 记录登录成功的用户名和密码
        [[NSUserDefaults standardUserDefaults]setObject:self.emailOrPhoneTF.text forKey:@"user"];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"type"];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"picture"];
        // 本地存储
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
//    [[XMPPManager shareInstance].stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    [[XMPPManager shareInstance] loginWithUserName:self.emailOrPhoneTF.text password:self.passwordTF.text];
    }
}

#pragma mark ----- XMPP协议方法 -----
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
//    NSLog(@"登录验证成功");
    // 如果用户登录了 要将该用户变成上线状态
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [[XMPPManager shareInstance].stream sendElement:presence];
    
//    NSLog(@"登陆界面界面当前用户 = %@",self.emailOrPhoneTF.text);
    
    // 记录登录成功的用户名和密码
    [[NSUserDefaults standardUserDefaults]setObject:self.emailOrPhoneTF.text forKey:@"user"];
    [[NSUserDefaults standardUserDefaults]setObject:self.passwordTF.text forKey:@"password"];
    
    // 本地存储
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"登录验证失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [a addAction:a1];
    [self presentViewController:a animated:YES completion:nil];
}

#pragma mark ----- 判断手机格式 -----
-(BOOL)validateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark ----- 判断密码格式是否正确 -----
-(BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


#pragma mark ----- 返回方法 -----
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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

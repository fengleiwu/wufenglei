//
//  PetNameViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PetNameViewController.h"
#import "SetPasswordViewController.h"

@interface PetNameViewController ()
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UILabel *registL;
@property (nonatomic, strong)UIButton *backB;
@property (nonatomic, strong)UIButton *nextB;
@property (nonatomic, strong)UITextField *petTF;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@end

@implementation PetNameViewController

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
    self.registL.text = @"设置昵称";
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
    //创建昵称TF
    self.petTF = [[UITextField alloc]initWithFrame:CGRectMake(50,kScreenHeight*2/11, kScreenWidth-100, kScreenHeight/14)];
    self.petTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.petTF.textColor = [UIColor whiteColor];
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"灰底白狗加载背景图.png"]];
    self.petTF.leftView = image1;
    self.petTF.leftViewMode = UITextFieldViewModeAlways;
    self.petTF.layer.masksToBounds = YES;
    self.petTF.layer.cornerRadius = 6;
    UIColor *color1 = [UIColor whiteColor];
    self.petTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入昵称" attributes:@{NSForegroundColorAttributeName:color1}];
    self.petTF.layer.borderColor= [UIColor whiteColor].CGColor;
    self.petTF.layer.borderWidth= 1.0f;
    [self.view addSubview:self.petTF];
    //创建下一步按钮
    self.nextB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextB.frame = CGRectMake(50,  kScreenHeight*2/11 + kScreenHeight/14+20, kScreenWidth-100, kScreenHeight/12);
    [self.nextB setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextB.layer setMasksToBounds:YES];
    [self.nextB.layer setBorderWidth:1];
    [self.nextB.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.nextB addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextB];
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

#pragma mark ----- 下一步方法 -----
-(void)nextAction{
    SetPasswordViewController *setVC = [[SetPasswordViewController alloc]init];
    if (self.petTF.text.length < 6) {
    UIAlertController *a = [UIAlertController alertControllerWithTitle:@"提醒" message:@"昵称格式不对" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [a addAction:a1];
    [self presentViewController:a animated:YES completion:nil];
    } else {
    setVC.phoneStr = self.phoneStr;
    setVC.petName = self.petTF.text;
    [self.navigationController pushViewController:setVC animated:YES];
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

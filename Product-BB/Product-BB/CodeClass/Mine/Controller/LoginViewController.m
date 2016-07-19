//
//  LoginViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong)UIButton *registB;
@property (nonatomic, strong)UIButton *loginB;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *dengluL;
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.registB];
    //创建背景界面
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)];
    self.imageV.image = [UIImage imageNamed:@"冰封王座.png"];
    [self.view addSubview:self.imageV];
    [self.imageV addSubview:self.effectV];
    // Do any additional setup after loading the view.
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

#pragma mark ----- 创建注册按钮 -----
-(UIButton *)registB{
    if (!_registB) {
        _registB = [UIButton buttonWithType:UIButtonTypeCustom];
        _registB.frame = CGRectMake(100, 100, 100,100);
        [_registB setTitle:@"注册" forState:UIControlStateNormal];
        _registB.backgroundColor = PKCOLOR(155, 155, 155);
        [_registB addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registB;
}

#pragma mark ----- 注册方法 -----
-(void)registAction{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
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

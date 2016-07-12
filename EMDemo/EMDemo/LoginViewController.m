//
//  LoginViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import <EMSDK.h>

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passwd;

@end

@implementation LoginViewController

#pragma mark---login
- (IBAction)loginBtn:(id)sender {
    EMError *error = [[EMClient sharedClient] loginWithUsername:_userName.text password:_passwd.text];
    if (!error) {
        NSLog(@"登录成功");
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self alertViewController:[NSString stringWithFormat:@"%d",error.code]];

    }
}

-(void)alertViewController:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [self showDetailViewController:alert sender:nil];
}

#pragma mark--register
- (IBAction)registBtn:(id)sender {
    RegistViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RegistViewController class])];
    [self.navigationController pushViewController:registerVC animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
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

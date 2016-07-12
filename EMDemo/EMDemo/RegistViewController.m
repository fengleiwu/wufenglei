//
//  RegistViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RegistViewController.h"
#import <EMSDK.h>
@interface RegistViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;//121982719827
@property (strong, nonatomic) IBOutlet UITextField *passwd;//121

@end

@implementation RegistViewController
- (IBAction)registAction:(id)sender {
    EMError *error = [[EMClient sharedClient]registerWithUsername:_userName.text password:_passwd.text];
    if (!error) {
        //成功
        [self.navigationController popViewControllerAnimated:NO];
        NSLog(@"%@%@",_userName.text,_passwd.text);
    }else{
        //失败
        [self alertViewController:[NSString stringWithFormat:@"%d",error.code]];
    }
}

//通用提示框
-(void)alertViewController:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [self showDetailViewController:alert sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

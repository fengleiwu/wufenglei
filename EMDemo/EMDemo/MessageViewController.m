//
//  MessageViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MessageViewController.h"
#import <EMSDK.h>
@interface MessageViewController ()<EMContactManagerDelegate>

@end

@implementation MessageViewController


-(void)viewWillAppear:(BOOL)animated
{
    //添加监听
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //移除监听
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

//用户A发送加用户B为好友的申请，用户B会收到这个回调
-(void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage
{
    [self alertViewController:aUsername titleMessage:aMessage];
}

//通用提示框
-(void)alertViewController:(NSString *)message titleMessage:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:message];
        if (!error) {
            //同意成功
            NSLog(@"发送同意成功");
        }else{
            [self alertViewController:[NSString stringWithFormat:@"%d",error.code]];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不同意" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:message];
        if (!error) {
            //拒绝成功
            NSLog(@"发送拒绝成功");
        }else{
            [self alertViewController:[NSString stringWithFormat:@"%d",error.code]];
        }
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self showDetailViewController:alert sender:nil];
}


//错误提示框
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

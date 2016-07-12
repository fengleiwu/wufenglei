//
//  AddViewController.m
//  EMDemo
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AddViewController.h"
#import <EMSDK.h>
@interface AddViewController ()
@property (strong, nonatomic) IBOutlet UITextField *friendNameTF;

@end

@implementation AddViewController



- (IBAction)addAction:(id)sender {
    
    //dispatch_async(dispatch_get_global_queue(<#long identifier#>, <#unsigned long flags#>), <#^(void)block#>)
    EMError *error = [[EMClient sharedClient].contactManager addContact:_friendNameTF.text message:@"我想加您为好友"];
    if (!error) {
        NSLog(@"添加成功");
        //[self.navigationController popViewControllerAnimated:YES];
        [self alertViewController:@"发送成功"];
    }else{
        [self alertViewController:[NSString stringWithFormat:@"%d",error.code]];
    }
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

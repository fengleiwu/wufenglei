//
//  DiscoverWebViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverWebViewController.h"

@interface DiscoverWebViewController ()
@property (nonatomic , strong)UIWebView *web;
@end

@implementation DiscoverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.web loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:0 target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
    //self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.web];
    // Do any additional setup after loading the view.
}

-(void)back
{
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

//
//  FocusViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FocusViewController.h"

@interface FocusViewController ()
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UIWebView *wView;
@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.wView];
    [self requestData];
    // Do any additional setup after loading the view.
    
}

#pragma mark ----- 创建webView -----
-(UIWebView *)wView{
    if (!_wView) {
        _wView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenHeight)];
    }
    return _wView;
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
    [self.wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KFocusImageURL]]];
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

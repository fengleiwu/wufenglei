//
//  recommendMoreViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "recommendMoreViewController.h"
#import "recommendMoreModel.h"
#import "recommendMoreTableViewCell.h"
#import "AlbumDetailViewController.h"
@interface recommendMoreViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)NSMutableArray *arr;
@end

@implementation recommendMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTabView];
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"小编推荐";
    self.tab.rowHeight = 120;
    [RequestManager requestWithUrlString:KrecommendMoreURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [recommendMoreModel recommendMore:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}


-(void)creatTabView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    recommendMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[recommendMoreTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
    }
    recommendMoreModel *model = self.arr[indexPath.row];
    [cell creatCell:model];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
    recommendMoreModel *model = self.arr[indexPath.row];
    album.url = model.albumId;
    album.inter = 4;
    [self.navigationController pushViewController:album animated:YES];
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

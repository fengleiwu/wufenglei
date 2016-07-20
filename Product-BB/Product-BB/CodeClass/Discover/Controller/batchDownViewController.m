//
//  batchDownViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "batchDownViewController.h"
#import "batchDownTableViewCell.h"
#import "AlbumDetailModel.h"
@interface batchDownViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tab;

@end

@implementation batchDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    // Do any additional setup after loading the view.
}


-(void)creatTableview
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
    batchDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[batchDownTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    AlbumDetailModel *model = self.arr[indexPath.row];
    [cell creatCell:model];
    return cell;
    
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

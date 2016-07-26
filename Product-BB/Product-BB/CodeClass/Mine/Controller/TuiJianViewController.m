//
//  TuiJianViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TuiJianViewController.h"
#import "DetailListTableViewCell.h"
#import "SUBModel.h"

@interface TuiJianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *KurlArr;
@property (nonatomic, strong)NSMutableArray *recommendArr;
@property (nonatomic, strong)UITableView *tableV1;
@end

@implementation TuiJianViewController
-(NSMutableArray *)KurlArr{
    if (!_KurlArr) {
        _KurlArr = [NSMutableArray arrayWithObjects:KFREE1URL,KFREE2URL,KFREE3URL,KFREE4URL,KFREE5URL,KFREE6URL, nil];
    }
    return _KurlArr;
}

-(NSMutableArray *)recommendArr{
    if (!_recommendArr) {
        _recommendArr = [NSMutableArray array];
    }
    return _recommendArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //刷新请求数据
    self.tableV1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 64,self.view.frame.size.width,self.view.frame.size.height) gifName:@"5562497_03" andShowToView:self.view];
        [self.recommendArr removeAllObjects];
        [self requestData];
    }];
    self.tableV1.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    }];
    [self.tableV1.mj_header beginRefreshing];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"推荐";
    [self.view addSubview:self.tableV1];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建推荐tableView -----
-(UITableView *)tableV1{
    if (!_tableV1) {
        _tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableV1.delegate = self;
        _tableV1.dataSource = self;
        _tableV1.showsVerticalScrollIndicator = NO;
        [_tableV1 registerNib:[UINib nibWithNibName:@"DetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
    }
    return _tableV1;
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recommendArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SUBModel *model = self.recommendArr[indexPath.row];
    DetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    [cell CellConfigureWithModel:model];
    return cell;
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
    NSInteger aa = arc4random()%(5-0+1);
    [RequestManager requestWithUrlString:self.KurlArr[aa] requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.recommendArr = [SUBModel modelConfigureWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableV1 reloadData];
            [self.tableV1.mj_header endRefreshing];
            [self.tableV1.mj_footer endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } error:^(NSError *error) {
//        NSLog(@"bottomData --- %@", error);
    }];
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

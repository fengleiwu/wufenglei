//
//  SubscriptionViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "DetailListTableViewCell.h"
#import "SUBModel.h"

@interface SubscriptionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UISegmentedControl *segContoller;
@property (nonatomic, strong)NSMutableArray *KurlArr;
@property (nonatomic, strong)NSMutableArray *recommendArr;
@property (nonatomic, strong)UITableView *tableV1;
@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, strong)UIView *moveV;
@end

@implementation SubscriptionViewController
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
        [MBProgressHUD setUpHUDWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height) gifName:@"5562497_03" andShowToView:self.view];
        [self.recommendArr removeAllObjects];
        [self requestData];
    }];
    self.tableV1.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    }];
    [self.tableV1.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view addSubview:self.segContoller];
    self.navigationController.navigationBar.translucent = NO;
    [self.segContoller addSubview:self.moveV];
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.tableV1];
//    [self requestData];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建滑块视图 -----
-(UIView *)moveV{
    if (!_moveV) {
        _moveV = [[UIView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth/3, 2)];
        _moveV.backgroundColor = [UIColor orangeColor];
    }
    return _moveV;
}

#pragma mark ----- 创建segmentedController -----
-(UISegmentedControl *)segContoller{
    if (!_segContoller) {
        _segContoller = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"订阅",@"历史"]];
        _segContoller.frame = CGRectMake(0, 20, kScreenWidth, 44);
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:22],
                              NSForegroundColorAttributeName:[UIColor orangeColor]};
        _segContoller.tintColor = [UIColor clearColor];
        [_segContoller setTitleTextAttributes:dic forState:(UIControlStateSelected)];
        NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:22],
                               NSForegroundColorAttributeName:[UIColor grayColor]};
        [_segContoller setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
        [_segContoller addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
        _segContoller.selectedSegmentIndex = 0;
    }
    return _segContoller;
}

#pragma mark ----- seg方法 -----
-(void)segAction{
    CGRect frame = self.moveV.frame;
    frame.origin.x = self.segContoller.selectedSegmentIndex *kScreenWidth/3;
    self.moveV.frame = frame;
    self.scrollV.contentOffset = CGPointMake(self.segContoller.selectedSegmentIndex *kScreenWidth, 0);
}

#pragma mark ----- 创建总scrollView视图 -----
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64-self.tabBarController.tabBar.height)];
        _scrollV.contentSize = CGSizeMake(kScreenWidth *3, 0);
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.pagingEnabled = YES;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.delegate = self;
    }
    return _scrollV;
}

#pragma mark ----- scrollView协议方法 -----
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.segContoller.selectedSegmentIndex = scrollView.contentOffset.x/kScreenWidth;
    CGRect frame = self.moveV.frame;
    frame.origin.x = self.segContoller.selectedSegmentIndex *kScreenWidth/3;
    self.moveV.frame = frame;
}

#pragma mark ----- 创建推荐tableView -----
-(UITableView *)tableV1{
    if (!_tableV1) {
        _tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollV.frame.size.height) style:UITableViewStylePlain];
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
        NSLog(@"bottomData --- %@", error);
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

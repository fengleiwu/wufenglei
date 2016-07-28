//
//  BroadcastListViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BroadcastListViewController.h"
#import "LocationTableViewCell.h"
#import "BroadListModel.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"

@interface BroadcastListViewController ()<UITableViewDataSource, UITableViewDelegate>
// typeArr loactionArr RankArr
@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UITableView *tableV;


@end

@implementation BroadcastListViewController

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self requestData];
    // 创建 tableView
    [self creatTableView];
    
    
}

#pragma mark --- 数据请求
- (void)requestData {
    NSString *url = [[NSString alloc]init];
    
    if (self.categoryId != 0) {
       url = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v2/radio/category?categoryId=%ld&device=iPhone&pageNum=1&pageSize=30", self.categoryId];
        self.navigationItem.title = self.topTitleName;
    } else if (self.locationId != 0) {
        url = @"http://live.ximalaya.com/live-web/v1/radio/local?device=iPhone&pageNum=1&pageSize=30";
        self.navigationItem.title = @"你好·上海";
    } else if (self.rankId != 0) {
        url = @"http://live.ximalaya.com/live-web/v3/radio/hot?device=iPhone&pageNum=1&pageSize=30";
        self.navigationItem.title = @"电台排行榜";
    } else if (self.topBtnTag == 0) {
        url = @"http://live.ximalaya.com/live-web/v2/radio/province?device=iPhone&pageNum=1&pageSize=30&provinceCode=310000&statEvent=pageview%2Fradiolist%40%E6%9C%AC%E5%9C%B0%E5%8F%B0&statModule=%E6%9C%AC%E5%9C%B0%E5%8F%B0&statPage=tab%40%E5%8F%91%E7%8E%B0_%E5%B9%BF%E6%92%AD";
        self.navigationItem.title = @"本地台";
    } else if (self.topBtnTag == 1) {
        url = @"http://live.ximalaya.com/live-web/v2/radio/national?device=iPhone&pageNum=1&pageSize=30&statEvent=pageview%2Fradiolist%40%E5%9B%BD%E5%AE%B6%E5%8F%B0&statModule=%E5%9B%BD%E5%AE%B6%E5%8F%B0&statPage=tab%40%E5%8F%91%E7%8E%B0_%E5%B9%BF%E6%92%AD";
        self.navigationItem.title = @"国家台";
    } else if (self.topBtnTag == 2) {
        url = @"http://live.ximalaya.com/live-web/v2/radio/network?device=iPhone&pageNum=1&pageSize=30&statEvent=pageview%2Fradiolist%40%E7%BD%91%E7%BB%9C%E5%8F%B0&statModule=%E7%BD%91%E7%BB%9C%E5%8F%B0&statPage=tab%40%E5%8F%91%E7%8E%B0_%E5%B9%BF%E6%92%AD";
        self.navigationItem.title = @"网络台";
    } else {
//        NSLog(@"cuo wu");
    }
    
    [RequestManager requestWithUrlString:url requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.modelArray = [BroadListModel modelConfigureWithDic:dic];
        
        [self.tableV reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --- 创建 tableVIew
- (void)creatTableView {
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableV.rowHeight = 100;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"locationCell"];
    [self.view addSubview:self.tableV];
    
}

#pragma mark --- tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    BroadListModel *model = self.modelArray[indexPath.row];
    [cell CellConfigureWithBroadListModel:model];
    cell.playB.tag = indexPath.row + 100;
    [cell.playB addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)playAction:(UIButton *)button {
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
    
//    BroadListModel *model = self.modelArray[button.tag - 100];
    playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithBroadlistModel:self.modelArray];
    [MyPlayerManager defaultManager].index = button.tag - 100;
    [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    
    [self presentViewController:playVC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
       
//    BroadListModel *model = self.modelArray[indexPath.row];
    // 判断字符串 URL 是否包含 m3u8 ，解析 model。
    playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithBroadlistModel:self.modelArray];
    [MyPlayerManager defaultManager].index = indexPath.row;
    [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    
    [self presentViewController:playVC animated:YES completion:nil];
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

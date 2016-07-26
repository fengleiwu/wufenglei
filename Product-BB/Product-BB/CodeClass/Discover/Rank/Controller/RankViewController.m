//
//  RankViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RankViewController.h"
#import "FocusViewController.h"
#import "OtherProgramViewController.h"
#import "ProgramListViewController.h"
#import "OtherRankListModel.h"
#import "RankListTableViewCell.h"
#import "RankListModel.h"
@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UIView *moreV1;
@property (nonatomic, strong)UIView *moreV2;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (nonatomic, strong)NSMutableArray *tableArr1;
@property (nonatomic, strong)NSMutableArray *tableArr2;
@property (nonatomic, strong)NSMutableArray *allArr;
@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, strong)NSMutableArray *anchorArr;
@end

@implementation RankViewController
-(NSMutableArray *)tableArr1{
    if (!_tableArr1) {
        _tableArr1 = [NSMutableArray array];
    }
    return _tableArr1;
}

-(NSMutableArray *)tableArr2{
    if (!_tableArr2) {
        _tableArr2 = [NSMutableArray array];
    }
    return _tableArr2;
}

-(NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray arrayWithObjects:KHotRankURL,KMoreRankURL,KBuyRankURL,KShareRankURL,KNovelRankURL,KLanguageRankURL,KEducationRankURL,KEntertainmentRankURL,KMUsicRankURL,KBusinessRankURL,KNewsRankURL,KScienceRankURL,KHistoryRankURL,KPrefectURL, nil];
    }
    return _listArr;
}

-(NSMutableArray *)anchorArr{
    if (!_anchorArr) {
        _anchorArr = [NSMutableArray arrayWithObjects:KWomanRankURL,KManRankURL,KNewManRankURL,KAnchorRankURL, nil];
    }
    return _anchorArr;
}

-(NSMutableArray *)allArr{
    if (!_allArr) {
        _allArr = [NSMutableArray array];
    }
    return _allArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建头视图 -----
-(void)creatHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.focusStr] completed:nil];
    [self.headView addSubview:imageV];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.headView addGestureRecognizer:self.tap];
}

#pragma mark ----- 手势方法 -----
-(void)tapAction{
    FocusViewController *focusVC = [[FocusViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:focusVC animated:YES];
}

#pragma mark ----- 创建tableViewSection视图 -----
-(UIView *)moreV1{
    if (!_moreV1) {
        _moreV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV1.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(5, 20, 15, 15);
        [button setImage:[UIImage imageNamed:@"播放 (2).png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 100, self.view.height/9-10)];
        label.text = @"节目榜单";
        [_moreV1 addSubview:button];
        [_moreV1 addSubview:label];
    }
    return _moreV1;
}

-(UIView *)moreV2{
    if (!_moreV2) {
        _moreV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV2.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(5, 20, 15, 15);
        [button setImage:[UIImage imageNamed:@"播放 (2).png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 100, self.view.height/9-10)];
        label.text = @"主播榜单";
        [_moreV2 addSubview:button];
        [_moreV2 addSubview:label];
    }
    return _moreV2;
}

#pragma mark ----- 创建总tableView -----
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self.tableV registerNib:[UINib nibWithNibName:@"RankListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RANKCell"];
    }
    return _tableV;
}

#pragma mark ----- tableView协议方法 -----
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramListViewController *programVC = [[ProgramListViewController alloc]init];
    OtherProgramViewController *OtherVC = [[OtherProgramViewController alloc]init];
    if (indexPath.section == 0) {
        RankListModel *model = self.tableArr1[indexPath.row];
        OtherVC.titleStr = model.title;
        programVC.titleStr = model.title;
        if (indexPath.row == 0) {
            programVC.urlStr = KHotRankURL;
        }
        else if (indexPath.row == 1) {
            programVC.urlStr = KMoreRankURL;
        }
        else if (indexPath.row == 13) {
            programVC.urlStr = KPrefectURL;
        } else {
            OtherVC.urlStr = self.listArr[indexPath.row];
            OtherVC.indexC = indexPath.row;
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:OtherVC animated:YES];
            return;
        }
    } else{
        OtherRankListModel *model = self.tableArr2[indexPath.row];
        OtherVC.titleStr = model.title;
        OtherVC.indexC = 100;
        OtherVC.urlStr = self.anchorArr[indexPath.row];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:OtherVC animated:YES];
        return;
    }
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:programVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.allArr[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight/6;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSInteger a = section;
    switch (a) {
        case 0:
            return self.moreV1;
            break;
        case 1:
            return self.moreV2;
            break;
        default:
            break;
    }
    return self.moreV1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.height/12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RankListModel *model = self.tableArr1[indexPath.row];
        RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RANKCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        return cell;
    } else{
        OtherRankListModel *model = self.tableArr2[indexPath.row];
        RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RANKCell" forIndexPath:indexPath];
        [cell CellConfigureWithModel:model];
        return cell;
    }
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
    [RequestManager requestWithUrlString:KRankUrl requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *focusDic = dic[@"focusImages"];
        NSArray *list = focusDic[@"list"];
        NSDictionary *Dic = list[0];
        self.focusStr = Dic[@"pic"];
        [self creatHeadView];
        self.tableArr1 = [RankListModel ModelConfigureWithJsonDic:dic];
        self.tableArr2 = [OtherRankListModel ModelConfigureWithJsonDic:dic];
        self.allArr = [NSMutableArray arrayWithObjects:self.tableArr1,self.tableArr2, nil];
        [self.view addSubview:self.tableV];
        self.tableV.tableHeaderView = self.headView;
//        NSLog(@"%@",dic);
    } error:^(NSError *error) {
//        NSLog(@"errpr == %@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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

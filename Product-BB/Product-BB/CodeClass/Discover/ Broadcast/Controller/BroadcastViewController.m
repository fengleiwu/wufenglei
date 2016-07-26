//
//  BroadcastViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BroadcastViewController.h"
#import "BroadcastListViewController.h"
#import "LocationTableViewCell.h"
#import "LocationModel.h"
#import "RankModel.h"
#import "TypeModel.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"

@interface BroadcastViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableV;
// 最上方本地台、国家台,新闻台等数组。
@property (nonatomic, strong)NSMutableArray *typeArr;
// 早安上海数组
@property (nonatomic, strong)NSMutableArray *loactionArr;
// 排行榜数组
@property (nonatomic, strong)NSMutableArray *RankArr;
// 用于存放上面的三个数组
@property (nonatomic, strong)NSMutableArray *AllArr;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
// table 头视图
@property (nonatomic, strong)UIView *headView;
// 记录头视图的高度
@property (nonatomic, assign) CGFloat headViewheight;
// 头视图上的5个视图
@property (nonatomic, strong)UIView *loaclV;
@property (nonatomic, strong)UIView *nationV;
@property (nonatomic, strong)UIView *provinceV;
@property (nonatomic, strong)UIView *networkV;
@property (nonatomic, strong)UIView *buttonView;
// 分区头视图
@property (nonatomic, strong)UIView *sectionV1;
@property (nonatomic, strong)UIView *sectionV2;
// 中间的新闻台等button
@property (nonatomic, strong)UIButton *typeBtn;

@end

@implementation BroadcastViewController
-(NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

-(NSMutableArray *)loactionArr{
    if (!_loactionArr) {
        _loactionArr = [NSMutableArray array];
    }
    return _loactionArr;
}

-(NSMutableArray *)RankArr{
    if (!_RankArr) {
        _RankArr = [NSMutableArray array];
    }
    return _RankArr;
}

-(NSMutableArray *)AllArr{
    if (!_AllArr) {
        _AllArr = [NSMutableArray array];
    }
    return _AllArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self requestData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
    [RequestManager requestWithUrlString:KbroadcastURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.typeArr = [TypeModel ModelConfigureWithJsonDic:dic];
        self.RankArr = [RankModel ModelConfigureWithJsonDic:dic];
        self.loactionArr = [LocationModel ModelConfigureWithJsonDic:dic];
        self.AllArr = [NSMutableArray arrayWithObjects:self.loactionArr,self.RankArr, nil];
        
        [self creatTableView];
        [self.tableV reloadData];
    } error:^(NSError *error) {
//        NSLog(@"error == %@",error);
    }];
}

#pragma mark ----- 创建总tableView -----
- (void)creatTableView {
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64-self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.tableV registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"locationCell"];
    [self.view addSubview:self.tableV];
    //设置tableView头视图
    [self creatHeadeview];
    self.tableV.tableHeaderView = self.headView;
    
}

#pragma mark ----- 创建tableView 头部视图 -----
-(void)creatHeadeview{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
     self.headView.backgroundColor = [UIColor whiteColor];
    
    // 创建最上面的本地台，国家台，网络台
    [self creatTopButtonView];
    // 创建新闻台、音乐台等电台按钮所在视图
    [self creatTypeButtonView];
}

#pragma mark --- 创建最上面的本地台，国家台，网络台
- (void)creatTopButtonView {
    // 省市台,省_1.png
    NSArray *imageArr = @[@"本地.png",@"五星国旗.png",@"娱乐_音乐电台.png"];
    NSArray *textArr = @[@"本地台",@"国家台",@"网络台"];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*kScreenWidth/3, 0, kScreenWidth/3, 70)];
        [self creatTopView:view buttonImage:imageArr[i] labelText:textArr[i] buttonTag:i+1000];
        [self.headView addSubview:view];
    }
}
- (void)creatTopView:(UIView *)view buttonImage:(NSString *)imageName labelText:(NSString *)text buttonTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(view.frame.size.width/2-15,10, 30, 30);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tintColor = [UIColor orangeColor];
    button.tag = tag;
    [button addTarget:self action:@selector(topAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2-30, 50, 60, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    [view addSubview: button];
}

#pragma mark ----- 创建新闻台、音乐台等电台按钮所在视图 -----
- (void)creatTypeButtonView {
    self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(10,80, kScreenWidth - 20, 60)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.buttonView];
    // 创建电台按钮
    [self creatTypeButton];
}

#pragma mark ----- 创建电台按钮 -----
-(void)creatTypeButton{
    
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
        self.typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.typeBtn.frame = CGRectMake(count%4 * (self.buttonView.width/4)-4,count/4 * 30,self.buttonView.width/4-4, 26);
        self.typeBtn.backgroundColor = PKCOLOR(241, 241, 241);
        if (count == 7) {
            [self.typeBtn setImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
            self.typeBtn.tintColor = [UIColor orangeColor];
            [self.typeBtn addTarget:self action:@selector(nextView2:) forControlEvents:UIControlEventTouchUpInside];
            self.typeBtn.tag = 999;
            [self.buttonView addSubview:self.typeBtn];
            return;
        }
        self.typeBtn.tag = [model.idd integerValue];
        [self.typeBtn setTitle:model.name forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.typeBtn addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:self.typeBtn];
        count++;
    }
}

#pragma mark ----- 电台视图 扩展 -----
-(void)nextView2:(UIButton *)button{
    button = [self.view viewWithTag:999];
    CGRect newFrame = self.headView.frame;
    newFrame.size.height = newFrame.size.height + self.buttonView.frame.size.height;
    self.headView.frame = newFrame;
    self.buttonView.height = self.headView.frame.size.height-80;
    
    [self.tableV beginUpdates];
    [self.tableV setTableHeaderView:self.headView];
    [self.tableV endUpdates];
    [self.tableV reloadData];
    
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
        if (count >= 7) {
            [button removeFromSuperview];
        self.typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.typeBtn.frame = CGRectMake(count%4 * (self.buttonView.width/4)-4,count/4 * 30,self.buttonView.width/4 -4, 26);
        self.typeBtn.backgroundColor = PKCOLOR(241, 241, 241);
            self.typeBtn.tag = [model.idd integerValue];
            [self.typeBtn setTitle:model.name forState:UIControlStateNormal];
            [self.typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.typeBtn addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonView addSubview:self.typeBtn];
        }
        count++;
    }
    self.typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.typeBtn.frame = CGRectMake(3 * (self.buttonView.width/4)-4,3 * 30,self.buttonView.width/4 -4, 26);
    self.typeBtn.backgroundColor = PKCOLOR(241, 241, 241);
    self.typeBtn.tag = 998;
    [self.typeBtn setImage:[UIImage imageNamed:@"箭头 (1).png"] forState:UIControlStateNormal];
    self.typeBtn.tintColor = [UIColor orangeColor];
    [self.typeBtn addTarget:self action:@selector(nextView3:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:self.typeBtn];
    
}

#pragma mark ----- 电台视图 收缩 -----
-(void)nextView3:(UIButton *)button{
    
    CGRect newFrame = self.headView.frame;
    newFrame.size.height = 140;
    self.headView.frame = newFrame;
    self.buttonView.height = self.headView.height/2 -10;
    
    [self.tableV beginUpdates];
    [self.tableV setTableHeaderView:self.headView];
    [self.tableV endUpdates];
    [self.tableV reloadData];
    for (TypeModel *model in self.typeArr) {
        button = [self.view viewWithTag:[model.idd integerValue]];
        [button removeFromSuperview];
    }
    button = [self.view viewWithTag:998];
    [button removeFromSuperview];
    [self creatTypeButton];
}

#pragma mark ----- 创建tableViewSection头视图 -----
-(UIView *)sectionV1{
    if (!_sectionV1) {
        _sectionV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _sectionV1.backgroundColor = [UIColor whiteColor];
        [self creatSectionHeaderViewWithView:_sectionV1 image:@"播放 (2).png" labelText:@"早安·上海" label1Text:@"更多 >" buttonTag:1];
    }
    return _sectionV1;
}

-(UIView *)sectionV2{
    if (!_sectionV2) {
        _sectionV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _sectionV2.backgroundColor = [UIColor whiteColor];
        [self creatSectionHeaderViewWithView:_sectionV2 image:@"播放 (2).png" labelText:@"排行榜" label1Text:@"更多 >" buttonTag:2];
    }
    return _sectionV2;
}

- (void)creatSectionHeaderViewWithView:(UIView *)view image:(NSString *)imageName labelText:(NSString *)text label1Text:(NSString *)text1 buttonTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = view.frame;
    [button addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = tag;
    [view addSubview:button];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
    imageV.image = [UIImage imageNamed:imageName];
    [button addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 10, 100, 22)];
    label.text = text;
    [button addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 55, 10, 55, 22)];
    label1.text = text1;
    label1.textColor = [UIColor lightGrayColor];
    [button addSubview:label1];
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.AllArr[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.AllArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.height/6;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.sectionV1;
    } else {
        return self.sectionV2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.height/15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        LocationModel *model = self.loactionArr[indexPath.row];
        cell.playB.tag = indexPath.row + 100;
        [cell cellConfigureWithModel:model];
        [cell.playB addTarget:self action:@selector(playAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    } else{
        RankModel *model = self.RankArr[indexPath.row];
        cell.playB.tag = indexPath.row + 200;
        [cell CellConfigureWithModel:model];
        [cell.playB addTarget:self action:@selector(playAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
    if (indexPath.section == 0) {
//        LocationModel *model = self.loactionArr[indexPath.row];
        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithLocationModel:self.loactionArr];
        
    } else{
//        RankModel *model = self.RankArr[indexPath.row];
        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithRankModel:self.RankArr];
    }
    [MyPlayerManager defaultManager].index = indexPath.row;
    [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
 
    self.tabBarController.tabBar.hidden = YES;
    [self presentViewController:playVC animated:YES completion:nil];
}

#pragma mark --- 跳转 播放界面
- (void)playAction1:(UIButton *)button {
    
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
    if (button.tag < 200) {
        //        LocationModel *model = self.loactionArr[button.tag - 100];
        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithLocationModel:self.loactionArr];
        [MyPlayerManager defaultManager].index = button.tag - 100;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    } else {
        //        RankModel *model = self.RankArr[button.tag - 200];
        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithRankModel:self.RankArr];
        [MyPlayerManager defaultManager].index = button.tag - 200;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    }
    [self presentViewController:playVC animated:YES completion:nil];
}

#pragma mark --- 更多 方法
- (void)btnAction:(UIButton *)button {
    BroadcastListViewController *broadVC = [[BroadcastListViewController alloc]init];
    // 传值过去，用于判断使用什么 URL.
    if (button.tag == 1) {
        broadVC.locationId = 1;
    }else {
        broadVC.rankId = 1;
    }
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:broadVC animated:YES];
}

#pragma mark --- 点击最上面四个按钮 页面跳转
- (void)topAction:(UIButton *)button {
    BroadcastListViewController *broadVC = [[BroadcastListViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:broadVC animated:YES];
    broadVC.topBtnTag = button.tag-1000;
}

#pragma mark ----- 新闻台、音乐台等 跳转方法 -----
-(void)nextView1:(UIButton *)button{
    //    NSLog(@"%ld", button.tag);
    BroadcastListViewController *broadVC = [[BroadcastListViewController alloc]init];
    broadVC.categoryId = button.tag;
    broadVC.topTitleName = button.titleLabel.text;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:broadVC animated:YES];
    
}

#pragma mark ----- 获取当前时间 -----
//-(NSString *)dateToString{
//    NSDate *date = [[NSDate alloc]init];
//    NSLog(@"%@",date);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"YYYY.MM.dd-HH.mm.ss";
//    NSString *dateString = [formatter stringFromDate:date];
//    return dateString;
//}




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

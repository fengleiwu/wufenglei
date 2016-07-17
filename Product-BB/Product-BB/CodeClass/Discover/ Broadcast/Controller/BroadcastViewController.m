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
// 最上方本地台、国家台等数组。
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
@property (nonatomic, strong)UIView *sectionV;
// 头视图上的5个视图
@property (nonatomic, strong)UIView *loaclV;
@property (nonatomic, strong)UIView *nationV;
@property (nonatomic, strong)UIView *provinceV;
@property (nonatomic, strong)UIView *networkV;
@property (nonatomic, strong)UIView *buttonV;
//
@property (nonatomic, strong)UIView *moreV1;
@property (nonatomic, strong)UIView *moreV2;

// 中间的新闻台等button
@property (nonatomic, strong)UIButton *typeBtn;
@property (nonatomic, assign)CGFloat buttonViewWidth;
@property (nonatomic, assign)CGFloat buttonViewHeight;


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
    [self cbroadcastTypeV];
    
    
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
//    NSLog(@"%@",dic);
    self.typeArr = [TypeModel ModelConfigureWithJsonDic:dic];
    self.RankArr = [RankModel ModelConfigureWithJsonDic:dic];
    self.loactionArr = [LocationModel ModelConfigureWithJsonDic:dic];
    [self creatTypeButton];
    [self.view addSubview:self.tableV];
    //设置tableView头视图
    self.tableV.tableHeaderView = self.headView;
    self.AllArr = [NSMutableArray arrayWithObjects:self.loactionArr,self.RankArr, nil];
} error:^(NSError *error) {
    NSLog(@"error == %@",error);
}];
}

#pragma mark ----- 创建总tableView -----
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-50-self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self.tableV registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"locationCell"];
        
    }
    return _tableV;
}

#pragma mark ----- 创建电台类型视图 -----
-(void)cbroadcastTypeV{
        self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height*2/5)];
    self.sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, self.headView.height -10,kScreenWidth, 10)];
    self.sectionV.backgroundColor = PKCOLOR(245, 243, 248);
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.sectionV];
    [self.headView addSubview:self.buttonV];
    [self.headView addSubview:self.loaclV];
    [self.headView addSubview:self.nationV];
    [self.headView addSubview:self.provinceV];
    [self.headView addSubview:self.networkV];
}
// 另一种创建方法是用 for 循环。
#pragma mark ----- 创建本地电台按钮 -----
-(UIView *)loaclV{
    if (!_loaclV) {
        _loaclV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, self.headView.height/2)];
        [self creatTopView:_loaclV buttonImage:@"本地.png" labelText:@"本地台" buttonTag:1];
    }
    return _loaclV;
}

#pragma mark ----- 创建国家电台按钮 -----
-(UIView *)nationV{
    if (!_nationV) {
        _nationV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, self.headView.height/2)];
        
        [self creatTopView:_nationV buttonImage:@"五星国旗.png" labelText:@"国家台" buttonTag:2];
    }
    return _nationV;
}

#pragma mark ----- 创建省市电台按钮 -----
-(UIView *)provinceV{
    if (!_provinceV) {
        _provinceV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/4, self.headView.height/2)];
        
        [self creatTopView:_provinceV buttonImage:@"省_1.png" labelText:@"省市台" buttonTag:3];
    }
    return _provinceV;
}

#pragma mark ----- 创建网络电台按钮 -----
-(UIView *)networkV{
    if (!_networkV) {
        _networkV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*3/4, 0, kScreenWidth/4, self.headView.height/2)];
        
        [self creatTopView:_networkV buttonImage:@"娱乐_音乐电台.png" labelText:@"网络台" buttonTag:4];
    }
    return _networkV;
}

- (void)creatTopView:(UIView *)view buttonImage:(NSString *)imageName labelText:(NSString *)text buttonTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(kScreenWidth/8 -30,_loaclV.height/5, 60, _loaclV.height*2/5);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tintColor = [UIColor orangeColor];
    button.tag = tag;
    [button addTarget:self action:@selector(topAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/8-30, _loaclV.height*3/5, 60, _loaclV.height/5)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    [view addSubview: button];
}

#pragma mark --- 点击上面四个按钮 页面跳转
- (void)topAction:(UIButton *)button {
    BroadcastListViewController *broadVC = [[BroadcastListViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:broadVC animated:YES];
    broadVC.topBtnTag = button.tag;
    
}

#pragma mark ----- 创建电台按钮所在视图 -----
-(UIView *)buttonV{
    if (!_buttonV) {
        _buttonV = [[UIView alloc]initWithFrame:CGRectMake(10, self.headView.height/2 +10, kScreenWidth - 20, self.headView.height/2 -20)];
    }
    return _buttonV;
}

#pragma mark ----- 创建电台按钮 -----
-(void)creatTypeButton{
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
//        NSLog(@"%@",[NSString stringWithFormat:@"%ld",[model.idd integerValue]]);
        _typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _typeBtn.frame = CGRectMake(count%4 * (self.buttonV.width/4)-4,count/4 * (self.buttonV.height/2)-2,self.buttonV.width/4 -4, self.buttonV.height/2-8);
        _buttonWidth = _buttonV.width;
        _buttonHeight = _buttonV.height;
        _typeBtn.backgroundColor = PKCOLOR(245, 245, 245);
        if (count == 7) {
            [_typeBtn setImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
            _typeBtn.tintColor = [UIColor orangeColor];
            [_typeBtn addTarget:self action:@selector(nextView2:) forControlEvents:UIControlEventTouchUpInside];
            _typeBtn.tag = 999;
            [self.buttonV addSubview:self.typeBtn];
            return;
        }
        _typeBtn.tag = [model.idd integerValue];
        [_typeBtn setTitle:model.name forState:UIControlStateNormal];
        [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonV addSubview:self.typeBtn];
        count++;
    }
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

#pragma mark ----- 电台视图伸缩1 -----
-(void)nextView2:(UIButton *)button{
    button = [self.view viewWithTag:999];
    CGRect newFrame = self.headView.frame;
    newFrame.size.height = newFrame.size.height + self.buttonV.frame.size.height;
    self.headView.frame = newFrame;
    self.buttonV.height = self.view.height*2/5  -30;
    self.sectionV.frame = CGRectMake(0, self.headView.height -10, kScreenWidth, 10);
    [self.tableV setTableHeaderView:self.headView];
    [self.tableV beginUpdates];
    [self.tableV setTableHeaderView:self.headView];
    [self.tableV endUpdates];
    [self.tableV reloadData];
    
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
        if (count >= 7) {
            [button removeFromSuperview];
        _typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _typeBtn.frame = CGRectMake(count%4 * (_buttonWidth/4)-4,count/4 * (_buttonHeight/2)-2,_buttonWidth/4 -4, _buttonHeight/2-8);
        _typeBtn.backgroundColor = PKCOLOR(245, 245, 245);
            _typeBtn.tag = [model.idd integerValue];
            [_typeBtn setTitle:model.name forState:UIControlStateNormal];
            [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_typeBtn addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonV addSubview:self.typeBtn];
        }
        count++;
    }
    _typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _typeBtn.frame = CGRectMake(3 * (_buttonWidth/4)-4,3 * (_buttonHeight/2)-2,_buttonWidth/4 -4, _buttonHeight/2-8);
    _typeBtn.backgroundColor = PKCOLOR(248, 248, 255);
    _typeBtn.tag = 998;
    [_typeBtn setImage:[UIImage imageNamed:@"箭头 (1).png"] forState:UIControlStateNormal];
    _typeBtn.tintColor = [UIColor orangeColor];
    [_typeBtn addTarget:self action:@selector(nextView3:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonV addSubview:self.typeBtn];
    
}

#pragma mark ----- 电台伸缩2 -----
-(void)nextView3:(UIButton *)button{
    CGRect newFrame = self.headView.frame;
    newFrame.size.height = self.view.height*2/5;
    self.headView.frame = newFrame;
    self.buttonV.height = self.headView.height/2 -20;
    self.sectionV.frame = CGRectMake(0, self.headView.height -10, kScreenWidth, 10);
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
-(UIView *)moreV1{
    if (!_moreV1) {
        _moreV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV1.backgroundColor = [UIColor whiteColor];
        [self creatSectionHeaderViewWithView:_moreV1 image:@"播放 (2).png" labelText:@"早安·上海" label1Text:@"更多 >" buttonTag:1];
    }
    return _moreV1;
}

-(UIView *)moreV2{
    if (!_moreV2) {
        _moreV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV2.backgroundColor = [UIColor whiteColor];
        [self creatSectionHeaderViewWithView:_moreV2 image:@"播放 (2).png" labelText:@"排行榜" label1Text:@"更多 >" buttonTag:2];
    }
    return _moreV2;
}

- (void)creatSectionHeaderViewWithView:(UIView *)view image:(NSString *)imageName labelText:(NSString *)text label1Text:(NSString *)text1 buttonTag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = view.frame;
    [button addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = tag;
    [view addSubview:button];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 22, 22)];
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
#pragma mark --- 进入列表界面方法
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

#pragma mark ----- tableView协议方法 -----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.AllArr[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.AllArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.height/5;
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
    //    NSLog(@"%ld",indexPath.section);
    
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
#pragma mark --- 跳转 播放界面
- (void)playAction1:(UIButton *)button {
    
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
    if (button.tag < 200) {
        LocationModel *model = self.loactionArr[button.tag - 100];

        playVC.newmodelArray = self.loactionArr;
         playVC.playPath32 = model.playUrl1;
        
        if ([playVC.playPath32 containsString:@"m3u8"]) {
            playVC.newmodelArray = [BroadMusicModel modelConfigureWithArray:playVC.newmodelArray];
        }
        [MyPlayerManager defaultManager].index = button.tag - 100;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    } else {
        RankModel *model = self.RankArr[button.tag - 200];
        playVC.playPath32 = model.playUrl1;
        playVC.newmodelArray = self.RankArr;
        
        if ([playVC.playPath32 containsString:@"m3u8"]) {
            playVC.newmodelArray = [BroadMusicModel modelConfigureWithArray:playVC.newmodelArray];
        }
        [MyPlayerManager defaultManager].index = button.tag - 200;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
    }
//    [self presentViewController:broadVC animated:YES completion:nil];
    [self.navigationController pushViewController:playVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicplayViewController *playVC = [[MusicplayViewController alloc]init];

    if (indexPath.section == 0) {
        LocationModel *model = self.loactionArr[indexPath.row];
        playVC.playPath32 = model.playUrl1;
        playVC.newmodelArray = self.loactionArr;
    } else{
        RankModel *model = self.RankArr[indexPath.row];
        playVC.playPath32 = model.playUrl1;
        playVC.newmodelArray = self.RankArr;
    }
    // 判断字符串 URL 是否包含 m3u8 ，解析 model。
    if ([playVC.playPath32 containsString:@"m3u8"]) {
        playVC.newmodelArray = [BroadMusicModel modelConfigureWithArray:playVC.newmodelArray];
    }
    [MyPlayerManager defaultManager].index = indexPath.row;
    [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
 
    
    //    [self presentViewController:broadVC animated:YES completion:nil];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:playVC animated:YES];

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

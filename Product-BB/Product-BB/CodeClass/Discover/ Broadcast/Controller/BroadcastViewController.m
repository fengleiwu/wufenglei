//
//  BroadcastViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BroadcastViewController.h"
#import "LocationTableViewCell.h"
#import "LocationModel.h"
#import "RankModel.h"
#import "TypeModel.h"
@interface BroadcastViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)NSMutableArray *RankArr;
@property (nonatomic, strong)NSMutableArray *AllArr;
@property (nonatomic, strong)NSMutableArray *loactionArr;
@property (nonatomic, strong)UIView *broadcastTypeV;
@property (nonatomic, strong)UIView *sectionV;
@property (nonatomic, strong)UIView *moreV1;
@property (nonatomic, strong)UIView *moreV2;
@property (nonatomic, strong)UIView *buttonV;
@property (nonatomic, strong)UIView *loaclV;
@property (nonatomic, strong)UIView *nationV;
@property (nonatomic, strong)UIButton *nationB;
@property (nonatomic, strong)UIButton *provinceB;
@property (nonatomic, strong)UIButton *networkB;
@property (nonatomic, strong)UIButton *typeB;
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
    
    
    // Do any additional setup after loading the view.
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
//    [self cbroadcastTypeV];
    [self.view addSubview:self.tableV];
    //设置tableView头视图
    self.tableV.tableHeaderView = self.broadcastTypeV;
    self.AllArr = [NSMutableArray arrayWithObjects:self.loactionArr,self.RankArr, nil];
} error:^(NSError *error) {
    NSLog(@"error == %@",error);
}];
}

#pragma mark ----- 创建总tableView -----
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height, self.view.frame.size.width, self.view.frame.size.height-84-self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self.tableV registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:@"locationCell"];
    }
    return _tableV;
}

#pragma mark ----- 创建电台类型视图 -----
-(void)cbroadcastTypeV{
        self.broadcastTypeV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height*2/5)];
    self.sectionV = [[UIView alloc]initWithFrame:CGRectMake(0, self.broadcastTypeV.height -10,kScreenWidth, 10)];
    self.sectionV.backgroundColor = PKCOLOR(245, 243, 248);
    self.broadcastTypeV.backgroundColor = [UIColor whiteColor];
    [self.broadcastTypeV addSubview:self.sectionV];
    [self.broadcastTypeV addSubview:self.buttonV];
    [self.broadcastTypeV addSubview:self.loaclV];
    [self.broadcastTypeV addSubview:self.nationV];
    [self.broadcastTypeV addSubview:self.provinceB];
    [self.broadcastTypeV addSubview:self.networkB];
}
//nsl
#pragma mark ----- 创建电台按钮所在视图 -----
-(UIView *)buttonV{
    if (!_buttonV) {
        _buttonV = [[UIView alloc]initWithFrame:CGRectMake(10, self.broadcastTypeV.height/2 +10, kScreenWidth - 20, self.broadcastTypeV.height/2 -20)];
    }
    return _buttonV;
}

#pragma mark ----- 创建电台按钮 -----
-(void)creatTypeButton{
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
//        NSLog(@"%@",[NSString stringWithFormat:@"%ld",[model.idd integerValue]]);
        _typeB = [UIButton buttonWithType:UIButtonTypeSystem];
        _typeB.frame = CGRectMake(count%4 * (self.buttonV.width/4)-4,count/4 * (self.buttonV.height/2)-2,self.buttonV.width/4 -4, self.buttonV.height/2-8);
        _buttonWidth = _buttonV.width;
        _buttonHeight = _buttonV.height;
        _typeB.backgroundColor = PKCOLOR(245, 245, 245);
        if (count == 7) {
            [_typeB setImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
            _typeB.tintColor = [UIColor orangeColor];
            [_typeB addTarget:self action:@selector(nextView2:) forControlEvents:UIControlEventTouchUpInside];
            _typeB.tag = 999;
            [self.buttonV addSubview:self.typeB];
            return;
        }
        _typeB.tag = [model.idd integerValue];
        [_typeB setTitle:model.name forState:UIControlStateNormal];
        [_typeB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_typeB addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonV addSubview:self.typeB];
        count++;
    }
}

#pragma mark ----- 电台跳转方法 -----
-(void)nextView1:(UIButton *)button{
    
}

#pragma mark ----- 电台视图伸缩1 -----
-(void)nextView2:(UIButton *)button{
    button = [self.view viewWithTag:999];
    CGRect newFrame = self.broadcastTypeV.frame;
    newFrame.size.height = newFrame.size.height + self.buttonV.frame.size.height;
    self.broadcastTypeV.frame = newFrame;
    self.buttonV.height = self.view.height*2/5  -30;
    self.sectionV.frame = CGRectMake(0, self.broadcastTypeV.height -10, kScreenWidth, 10);
    [self.tableV setTableHeaderView:self.broadcastTypeV];
    [self.tableV beginUpdates];
    [self.tableV setTableHeaderView:self.broadcastTypeV];
    [self.tableV endUpdates];
    [self.tableV reloadData];
    
    NSInteger count = 0;
    for (TypeModel *model in self.typeArr) {
        if (count >= 7) {
            [button removeFromSuperview];
        _typeB = [UIButton buttonWithType:UIButtonTypeSystem];
        _typeB.frame = CGRectMake(count%4 * (_buttonWidth/4)-4,count/4 * (_buttonHeight/2)-2,_buttonWidth/4 -4, _buttonHeight/2-8);
        _typeB.backgroundColor = PKCOLOR(245, 245, 245);
            _typeB.tag = [model.idd integerValue];
            [_typeB setTitle:model.name forState:UIControlStateNormal];
            [_typeB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_typeB addTarget:self action:@selector(nextView1:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonV addSubview:self.typeB];
        }
        count++;
    }
    _typeB = [UIButton buttonWithType:UIButtonTypeSystem];
    _typeB.frame = CGRectMake(3 * (_buttonWidth/4)-4,3 * (_buttonHeight/2)-2,_buttonWidth/4 -4, _buttonHeight/2-8);
    _typeB.backgroundColor = PKCOLOR(248, 248, 255);
    _typeB.tag = 998;
    [_typeB setImage:[UIImage imageNamed:@"箭头 (1).png"] forState:UIControlStateNormal];
    _typeB.tintColor = [UIColor orangeColor];
    [_typeB addTarget:self action:@selector(nextView3:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonV addSubview:self.typeB];
    
}

#pragma mark ----- 电台伸缩2 -----
-(void)nextView3:(UIButton *)button{
    CGRect newFrame = self.broadcastTypeV.frame;
    newFrame.size.height = self.view.height*2/5;
    self.broadcastTypeV.frame = newFrame;
    self.buttonV.height = self.broadcastTypeV.height/2 -20;
    self.sectionV.frame = CGRectMake(0, self.broadcastTypeV.height -10, kScreenWidth, 10);
    [self.tableV beginUpdates];
    [self.tableV setTableHeaderView:self.broadcastTypeV];
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

#pragma mark ----- 创建本地电台按钮 -----
-(UIView *)loaclV{
    if (!_loaclV) {
        _loaclV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, self.broadcastTypeV.height/2)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kScreenWidth/8 -30,_loaclV.height/5, 60, _loaclV.height*2/5);
        [button setImage:[UIImage imageNamed:@"本地.png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/8-30, _loaclV.height*3/5, 60, _loaclV.height/5)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"本地台";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor grayColor];
        [_loaclV addSubview:label];
        [_loaclV addSubview: button];
    }
    return _loaclV;
}

#pragma mark ----- 创建国家电台按钮 -----
-(UIButton *)nationB{
    if (!_nationB) {
        _nationB = [UIButton buttonWithType:UIButtonTypeSystem];
        _nationB.frame = CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, self.broadcastTypeV.height/2);
        [_nationB setImage:[UIImage imageNamed:@"五星国旗.png"] forState:UIControlStateNormal];
        _nationB.imageEdgeInsets = UIEdgeInsetsMake(0,0,40,_nationB.titleLabel.bounds.size.width);
        [_nationB setTitle:@"国家台" forState:UIControlStateNormal];
        _nationB.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nationB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _nationB.titleEdgeInsets = UIEdgeInsetsMake(50, _nationB.titleLabel.bounds.size.width-80, 0, 0);
        _nationB.tintColor = [UIColor orangeColor];
    }
    return _nationB;
}

-(UIView *)nationV{
    if (!_nationV) {
        _nationV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, self.broadcastTypeV.height/2)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kScreenWidth/8 -30,_nationV.height/5, 60, _nationV.height*2/5);
        [button setImage:[UIImage imageNamed:@"五星国旗.png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/8-30, _nationV.height*3/5, 60, _nationV.height/5)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"国家台";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor grayColor];
        [_nationV addSubview:label];
        [_nationV addSubview: button];
    }
    return _nationV;
}

#pragma mark ----- 创建省市电台按钮 -----
-(UIButton *)provinceB{
    if (!_provinceB) {
        _provinceB = [UIButton buttonWithType:UIButtonTypeSystem];
        _provinceB.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/4, self.broadcastTypeV.height/2);
        [_provinceB setImage:[UIImage imageNamed:@"省_1.png"] forState:UIControlStateNormal];
        _provinceB.imageEdgeInsets = UIEdgeInsetsMake(0,0,40,_provinceB.titleLabel.bounds.size.width);
        [_provinceB setTitle:@"省市台" forState:UIControlStateNormal];
        _provinceB.titleLabel.font = [UIFont systemFontOfSize:18];
        [_provinceB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _provinceB.titleEdgeInsets = UIEdgeInsetsMake(50, _provinceB.titleLabel.bounds.size.width-80, 0, 0);
        _provinceB.tintColor = [UIColor orangeColor];
    }
    return _provinceB;
}

#pragma mark ----- 创建网络电台按钮 -----
-(UIButton *)networkB{
    if (!_networkB) {
        _networkB = [UIButton buttonWithType:UIButtonTypeSystem];
        _networkB.frame = CGRectMake(kScreenWidth*3/4, 0, kScreenWidth/4, self.broadcastTypeV.height/2);
        [_networkB setImage:[UIImage imageNamed:@"娱乐_音乐电台.png"] forState:UIControlStateNormal];
        _networkB.imageEdgeInsets = UIEdgeInsetsMake(0,0,40,_networkB.titleLabel.bounds.size.width);
        [_networkB setTitle:@"网络台" forState:UIControlStateNormal];
        _networkB.titleLabel.font = [UIFont systemFontOfSize:18];
        [_networkB setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _networkB.titleEdgeInsets = UIEdgeInsetsMake(50, _networkB.titleLabel.bounds.size.width-80, 0, 0);
        _networkB.tintColor = [UIColor orangeColor];
    }
    return _networkB;
}

#pragma mark ----- 创建tableViewSection视图 -----
-(UIView *)moreV1{
    if (!_moreV1) {
        _moreV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV1.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 10, 22, self.view.height/9 -34);
        [button setImage:[UIImage imageNamed:@"播放 (2).png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 100, self.view.height/9-10)];
        label.text = @"早安·上海";
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 55, 0, 55, self.view.height/9-10)];
        label1.text = @"更多 >";
        label1.textColor = [UIColor lightGrayColor];
        [_moreV1 addSubview:button];
        [_moreV1 addSubview:label];
        [_moreV1 addSubview:label1];
    }
    return _moreV1;
}

-(UIView *)moreV2{
    if (!_moreV2) {
        _moreV2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height/12)];
        _moreV2.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 10, 22, self.view.height/9 -34);
        [button setImage:[UIImage imageNamed:@"播放 (2).png"] forState:UIControlStateNormal];
        button.tintColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 0, 100, self.view.height/9-10)];
        label.text = @"排行榜";
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 55, 0, 55, self.view.height/9-10)];
        label1.text = @"更多 >";
        label1.textColor = [UIColor lightGrayColor];
        [_moreV2 addSubview:button];
        [_moreV2 addSubview:label];
        [_moreV2 addSubview:label1];
    }
    return _moreV2;
}

//#pragma mark ----- 获取当前时间 -----
//-(NSString *)dateToString{
//    NSDate *date = [[NSDate alloc]init];
//    NSLog(@"%@",date);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"YYYY.MM.dd-HH.mm.ss";
//    NSString *dateString = [formatter stringFromDate:date];
//    return dateString;
//}


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
    NSLog(@"%ld",indexPath.section);
    if (indexPath.section == 0) {
        LocationModel *model = self.loactionArr[indexPath.row];
        LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        return cell;
    } else{
        RankModel *model = self.RankArr[indexPath.row];
        LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
        [cell CellConfigureWithModel:model];
        return cell;
    }
   
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

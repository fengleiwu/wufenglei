//
//  MineViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MineViewController.h"
#import "MySettingTableViewCell.h"
#import "HFStretchableTableHeaderView.h"
#import "LoginViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView *MindUserV;
@property (nonatomic, strong)UIView *backV1;
@property (nonatomic, strong)UIView *back2;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIButton *headB;
@property (nonatomic, strong)UIButton *login;
@property (nonatomic, strong)UIButton *settingB;
@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *tableArr;
@property (nonatomic, strong)NSMutableArray *logoArr;
@property (nonatomic, strong)UIBlurEffect *beffect;
@property (nonatomic, strong)UIVisualEffectView *effectV;
@property (nonatomic , strong)HFStretchableTableHeaderView *stretchHeaderView;
@end

@implementation MineViewController
-(NSMutableArray *)tableArr{
    if (!_tableArr) {
        NSArray *arr1 = @[@"我的订阅",@"播放历史"];
        NSArray *arr2 = @[@"珠穆朗玛商城",@"游戏中心"];
        NSArray *arr3 = @[@"意见反馈",@"设置"];
        _tableArr = [NSMutableArray arrayWithObjects:arr1,arr2,arr3, nil];
    }
    return _tableArr;
}

-(NSMutableArray *)logoArr{
    if (!_logoArr) {
        _logoArr = [NSMutableArray arrayWithObjects:@"我的订阅.png",@"播放历史.png",@"商城.png",@"游戏_选中.png",@"意见反馈.png",@"设置 (1).png", nil];
    }
    return _logoArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aCount = 1;
    [self creatMindUserV];
    [self.view addSubview:self.tableV];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableV.tableHeaderView = self.MindUserV;
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建登录界面 -----
-(void)creatMindUserV{
    self.MindUserV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*2/5)];
    self.back2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*2/5)];
    self.back2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"珠穆朗玛.jpg"]];
    self.backV1 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*3/8 -3, kScreenHeight/12, kScreenWidth/4+5,kScreenWidth/4+5)];
    self.backV1.layer.masksToBounds = YES;
    self.backV1.layer.cornerRadius = (kScreenWidth/4+5)/2;
    self.backV1.backgroundColor = [UIColor grayColor];
    //添加滤镜
    [self.MindUserV addSubview:self.back2];
    [self.back2 addSubview:self.effectV];
    [self.MindUserV addSubview:self.backV1];
    [self.view addSubview:self.MindUserV];
    //添加头像button
    self.headB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headB.frame = CGRectMake(0, 0, kScreenWidth/4,kScreenWidth/4);
    self.headB.center = self.backV1.center;
    self.headB.layer.masksToBounds = YES;
    self.headB.layer.cornerRadius = kScreenWidth/8;
    [self.headB setImage:[UIImage imageNamed:@"dog.jpg"] forState:UIControlStateNormal];
    [self.headB addTarget:self action:@selector(changeHead) forControlEvents:UIControlEventTouchUpInside];
    [self.MindUserV addSubview:self.headB];
    //创建登录按钮
    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    self.login.frame = CGRectMake(kScreenWidth/2-40, kScreenHeight/4-10, 80,25);
    self.login.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.login setTitle:@"点击登录" forState:UIControlStateNormal];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.MindUserV addSubview:self.login];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, kScreenHeight/4+15, 200, 20)];
    self.label.text = @"1秒登录，专享个性化服务";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textColor = PKCOLOR(245, 245, 245);
    [self.MindUserV addSubview:self.label];
    //创建设置按钮
    self.settingB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.settingB.frame = CGRectMake(10, 30, 30,30);
    [self.settingB setImage:[UIImage imageNamed:@"设置 (1).png"] forState:UIControlStateNormal];
    self.settingB.tintColor = [UIColor whiteColor];
    [self.MindUserV addSubview:self.settingB];
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableV withView:self.back2 subViews:self.MindUserV];
}

#pragma mark ----- 创建tableView -----
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator = NO;
        [_tableV registerClass:[MySettingTableViewCell class] forCellReuseIdentifier:@"mineCell"];
    }
    return _tableV;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    if (self.tableV.contentOffset.y<0) {
        CGFloat f = kScreenHeight*2/5 - self.tableV.contentOffset.y;
        self.effectV.height = f;
        self.effectV.width = 2*kScreenWidth;
    }
    if (self.tableV.contentOffset.y >0) {
        if (self.tableV.contentOffset.y < 0) {
            self.aCount = fabs(self.tableV.contentOffset.y +30);
        } else {
            self.aCount = 10 + self.tableV.contentOffset.y;
        }
        if (self.tableV.contentOffset.y >= 100) {
            self.headB.alpha = 0;
        } else {
            self.headB.alpha = 10/self.aCount;
            self.backV1.alpha = 10/self.aCount;
            self.login.alpha = 10/self.aCount;
            self.label.alpha = 10/self.aCount;
        }
        
    } else {
        self.headB.alpha = 1;
        self.backV1.alpha = 1;
        self.login.alpha = 1;
        self.label.alpha = 1;
    }
    [self.back2 addSubview:self.effectV];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
    self.effectV.frame = self.back2.frame;
    [self.back2 addSubview:self.effectV];
    
    
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight/10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell" forIndexPath:indexPath];
    cell.label.text = self.tableArr[indexPath.section][indexPath.row];
    cell.nextV.image = [UIImage imageNamed:@"箭头 (3).png"];
    [cell.imageB setImage:[UIImage imageNamed:self.logoArr[indexPath.section *2 + indexPath.row]] forState:UIControlStateNormal];
    cell.imageB.tintColor = [UIColor orangeColor];
    return cell;
}

#pragma mark ----- 创建换头像方法 -----
-(void)changeHead{

}

#pragma mark ----- 登录方法 -----
-(void)loginAction{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:naVC animated:YES completion:nil];
}

#pragma mark ----- 创建滤镜 -----
-(UIBlurEffect *)beffect{
    if (!_beffect) {
        _beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    return _beffect;
}

-(UIVisualEffectView *)effectV{
    if (!_effectV) {
        _effectV = [[UIVisualEffectView alloc]initWithEffect:self.beffect];
        _effectV.frame = self.MindUserV.bounds;
        _effectV.alpha = 0.3;
    }
    return _effectV;
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

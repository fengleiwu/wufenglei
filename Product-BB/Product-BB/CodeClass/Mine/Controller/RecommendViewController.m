//
//  RecommendViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendViewController.h"
#import "TuiJianViewController.h"
#import "MyMusicDownLoadTable.h"
#import "HistoryOfPlayTableViewCell.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"
BOOL All = YES;
BOOL isClick = NO;

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *editV;
@property (nonatomic, strong)UIWebView *wView;
@property (nonatomic, strong)UITableView *tableV1;
@property (nonatomic, strong)MyMusicDownLoadTable *table;
@property (nonatomic, strong)UIButton *lookRecommendB;
@property (nonatomic, strong)UIButton *checkB;
@property (nonatomic, strong)UIButton *removeB;
@property (nonatomic, strong)NSArray *sqliteArr;
@property (nonatomic, strong)NSMutableArray *modelArr;
@end

@implementation RecommendViewController
-(NSArray *)sqliteArr{
    if (!_sqliteArr) {
        _sqliteArr = [NSArray array];
    }
    return _sqliteArr;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playFrame" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playResume" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //我的订阅
    if (self.index == 0) {
        //创建背景
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        self.imageV.image = [UIImage imageNamed:@"喵.png"];
        [self.view addSubview:self.imageV];
        //创建提醒标签
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*2/3, kScreenHeight*5/11, 120, 30)];
        self.label.text = @"你还没订阅哦...";
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:self.label];
        self.navigationItem.title = @"我的订阅";
        [self.view addSubview:self.lookRecommendB];
    }
    //播放历史
    if (self.index == 1) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationItem.title = @"播放历史";
        self.sqliteArr = [self.table selectAllInHistoryOfPlay];
        if (self.sqliteArr.count == 0) {
        //创建背景
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        self.imageV.image = [UIImage imageNamed:@"屏幕快照 2016-07-22 下午7.20.34.png"];
        [self.view addSubview:self.imageV];
        //创建提醒标签
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*2/3, kScreenHeight*5/11, 120, 30)];
        self.label.text = @"你还没有收听过...";
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:self.label];
        }else {
            self.view.backgroundColor = PKCOLOR(211, 211, 211);
            for (NSArray *arr in self.sqliteArr) {
                BroadMusicModel *model = [[BroadMusicModel alloc]init];
                model.musicURL = arr[0];
                model.totalTitle = arr[1];
                model.liveTitle = arr[2];
                model.playCount = arr[3];
                model.bgImage = arr[4];
                    [self.modelArr addObject:model];
            }
        [self.view addSubview:self.tableV1];
        [self.view addSubview:self.editV];
        [self.editV addSubview:self.checkB];
        [self.editV addSubview:self.removeB];
            }
    }
    //商城
    if (self.index == 2) {
        self.navigationItem.title = @"珠穆朗玛商城";
        [self requestData];
    }
    if (self.index == 3) {
        self.navigationItem.title = @"游戏中心";
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self requestDataWithGame];
    }
    //意见反馈
    if (self.index == 4) {
        self.navigationItem.title = @"意见反馈";
    }
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建已下载歌曲界面 -----
-(UITableView *)tableV1{
    if (!_tableV1) {
        _tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0,60, kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
        _tableV1.delegate = self;
        _tableV1.dataSource = self;
        [_tableV1 registerClass:[HistoryOfPlayTableViewCell class] forCellReuseIdentifier:@"historyCell"];
    }
    return _tableV1;
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight/7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BroadMusicModel *model = self.modelArr[indexPath.row];
    HistoryOfPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    [cell cellConfigureWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isClick == NO) {
        MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
        playVC.newmodelArray = self.modelArr;
        [MyPlayerManager defaultManager].index = indexPath.row;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
        
        [self presentViewController:playVC animated:YES completion:nil];
    } else {
    BroadMusicModel *model = self.modelArr[indexPath.row];
    NSInteger cc = indexPath.row;
    if (model.isSelect == NO) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:cc inSection:0];
        [self.tableV1 selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    } else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:cc inSection:0];
        [self.tableV1 deselectRowAtIndexPath:indexPath animated:YES];
    }
    model.isSelect = !model.isSelect;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cc = indexPath.row;
    BroadMusicModel *model = self.modelArr[cc];
    model.isSelect = NO;
}

#pragma mark ----- 创建编辑界面 -----
-(UIView *)editV{
    if (!_editV) {
        _editV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
        _editV.backgroundColor = [UIColor lightGrayColor];
    }
    return _editV;
}

#pragma mark ----- 创建全选Button -----
-(UIButton *)checkB{
    if (!_checkB) {
        _checkB = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkB.frame = CGRectMake(0, 0, kScreenWidth/2, 30);
        [_checkB setTitle:@"选择" forState:UIControlStateNormal];
        [_checkB setTintColor:[UIColor whiteColor]];
        [_checkB addTarget:self action:@selector(checkA) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkB;
}

#pragma mark ----- 创建删除Button -----
-(UIButton *)removeB{
    if (!_removeB) {
        _removeB = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeB.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 30);
        [_removeB setTitle:@"删除" forState:UIControlStateNormal];
        [_removeB setTintColor:[UIColor whiteColor]];
        [_removeB addTarget:self action:@selector(removeA) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeB;
}

#pragma mark ----- 选择方法 -----
-(void)checkA{
    if (All == YES) {
        self.tableV1.allowsMultipleSelectionDuringEditing= NO;
         [self.tableV1 setEditing:YES animated:YES];
        [self.checkB setTitle:@"取消选择" forState:UIControlStateNormal];
        All = NO;
        isClick = YES;
        for (int i = 0; i < self.modelArr.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableV1 selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            BroadMusicModel *model = self.modelArr[i];
            model.isSelect = YES;
        }
    } else {
        [self.tableV1 setEditing:NO  animated:YES];
        [self.checkB setTitle:@"选择" forState:UIControlStateNormal];
        All = YES;
        isClick = NO;
        for (int i = 0; i < self.modelArr.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableV1 deselectRowAtIndexPath:indexPath animated:YES];
            BroadMusicModel *model = self.modelArr[i];
            model.isSelect = NO;
        }
    }
}

#pragma mark ----- 删除方法 -----
-(void)removeA{
    if (isClick == YES) {
        for (NSInteger i = self.modelArr.count - 1; i >= 0; i--)
        {
            BroadMusicModel *model = self.modelArr[i];
            if (model.isSelect == YES) {
                [self.modelArr removeObjectAtIndex:i];
                [self.table delegateNoteWithHistoryOfPlayTableName:kYourDownloadTable totalTitle:model.totalTitle];
            }
        }
        All = NO;
        isClick = NO;
        [self checkA];
        [self refreshData];
    }
}

-(void)refreshData{
    self.sqliteArr = [self.table selectAllInHistoryOfPlay];
    if (self.sqliteArr.count == 0) {
        
    }else {
        [self.modelArr removeAllObjects];
        for (NSArray *arr in self.sqliteArr) {
            BroadMusicModel *model = [[BroadMusicModel alloc]init];
            model.musicURL = arr[0];
            model.totalTitle = arr[1];
            model.liveTitle = arr[2];
            model.playCount = arr[3];
            model.bgImage = arr[4];
            [self.modelArr addObject:model];
        }
    }
    [self.tableV1 reloadData];
}

#pragma mark ----- 删除方法 -----
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1|2;
}


#pragma mark ----- 创建webView -----
-(UIWebView *)wView{
    if (!_wView) {
        _wView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64,kScreenWidth,kScreenHeight-64)];
    }
    return _wView;
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
    [RequestManager requestWithUrlString:KTuiGuangURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataDic = dic[@"data"];
        NSDictionary *Dic = dataDic[0];
        self.webStr = Dic[@"link"];
        [self requestData1];
    } error:^(NSError *error) {
        NSLog(@"errpr == %@",error);
    }];
}

-(void)requestDataWithGame{
    [ self.wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KGameURL]]];
    [self.view addSubview:self.wView];
}

#pragma mark ----- 数据请求webView -----
-(void)requestData1{
    [ self.wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webStr]]];
    [self.view addSubview:self.wView];
}

#pragma mark ----- 创建去看看button -----
-(UIButton *)lookRecommendB{
    if (!_lookRecommendB) {
        _lookRecommendB = [UIButton buttonWithType:UIButtonTypeSystem];
        _lookRecommendB.frame = CGRectMake(70, kScreenHeight*9/11, kScreenWidth-140, 35);
        [_lookRecommendB setTitle:@"看看推荐" forState:UIControlStateNormal];
        [_lookRecommendB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _lookRecommendB.backgroundColor = [UIColor whiteColor];
        [_lookRecommendB addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookRecommendB;
}

-(MyMusicDownLoadTable *)table{
    if (!_table) {
        _table = [[MyMusicDownLoadTable alloc]init];
    }
    return _table;
}

#pragma mark ----- 进入商城方法 -----
-(void)nextAction{
    TuiJianViewController *tuijianVC = [[TuiJianViewController alloc]init];
    [self.navigationController pushViewController:tuijianVC animated:YES];
}

-(NSString *)creatSqliteWithSqliteName:(NSString *)sqliteName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:sqliteName];
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

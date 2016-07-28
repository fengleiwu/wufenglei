//
//  RecommendViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RecommendViewController.h"
#import "AppDelegate.h"
#import "TuiJianViewController.h"
#import "MyMusicDownLoadTable.h"
#import "YourSettingTableViewCell.h"
#import "HistoryOfPlayTableViewCell.h"
#import "MusicplayViewController.h"
#import "PingLunTableViewCell.h"
#import "BroadMusicModel.h"
BOOL All = YES;
BOOL isClick = NO;

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *speakTV;
@property (nonatomic, strong)UITextField *speakTF;
@property (nonatomic, strong)UITextField *phoneTF;
@property (nonatomic, strong)UITextField *QQTF;
@property (nonatomic, strong)UIView *editV;
@property (nonatomic, strong)UIView *timeV;
@property (nonatomic, strong)UIView *bacKV;
@property (nonatomic, strong)UIWebView *wView;
@property (nonatomic, strong)UITableView *tableV1;
@property (nonatomic, strong)UITableView *tablev2;
@property (nonatomic, strong)UITableView *tableV3;
@property (nonatomic, strong)UITableView *tableV4;
@property (nonatomic, strong)MyMusicDownLoadTable *table;
@property (nonatomic, strong)UIButton *lookRecommendB;
@property (nonatomic, strong)UIButton *checkB;
@property (nonatomic, strong)UIButton *sendB;
@property (nonatomic, strong)UIButton *removeB;
@property (nonatomic, strong)UIButton *closeB;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSArray *sqliteArr;
@property (nonatomic, strong)NSMutableArray *settingArr;
@property (nonatomic, strong)NSMutableArray *timeArr;
@property (nonatomic, strong)NSMutableArray *pingArr;
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

-(NSMutableArray *)pingArr{
    if (!_pingArr) {
        _pingArr = [NSMutableArray array];
    }
    return _pingArr;
}

-(NSMutableArray *)timeArr{
    if (!_timeArr) {
        _timeArr = [NSMutableArray arrayWithObjects:@"不开启",@"立即退出",@"20分钟后",@"30分钟后",@"60分钟后",@"90分钟后", nil];
    }
    return _timeArr;
}

-(NSMutableArray *)settingArr{
    if (!_settingArr) {
        NSArray *arr1 = @[@"特色闹铃",@"定时关闭"];
        NSArray *arr2 = @[@"账号绑定"];
        NSArray *arr3 = @[@"断点续听",@"2G/3G/4G播放和下载",@"推送设置",@"隐私设置",@"修改密码"];
        NSArray *arr4 = @[@"帮助中心"];
        NSArray *arr5 = @[@"亲，请评价，支持我们做得更好！",@"关于"];
        _settingArr = [NSMutableArray arrayWithObjects:arr1,arr2,arr3,arr4,arr5, nil];
    }
    return _settingArr;
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
        //键盘将要出来
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        //键盘将要消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
        //创建手机号TF
        self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 64, kScreenWidth, kScreenHeight/15)];
        self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label1.text = @"手机：";
        self.phoneTF.leftView = label1;
        self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
        self.phoneTF.textColor = [UIColor whiteColor];
        [self.view addSubview:self.phoneTF];
        //创建QQTF
        self.QQTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 64+kScreenHeight/15, kScreenWidth, kScreenHeight/15)];
        self.QQTF.keyboardType = UIKeyboardTypeNumberPad;
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label2.text = @"QQ：";
        self.QQTF.leftView = label2;
        self.QQTF.leftViewMode = UITextFieldViewModeAlways;
        self.QQTF.textColor = [UIColor whiteColor];
        [self.view addSubview:self.QQTF];
        [self.view addSubview:self.tableV3];
        [self.view addSubview:self.speakTV];
        [self.speakTV addSubview:self.speakTF];
        [self.speakTV addSubview:self.sendB];
        }
    if (self.index == 5) {
        self.navigationItem.title = @"设置";
        [self.view addSubview:self.tableV4];
        [self.view addSubview:self.timeV];
        [self.view addSubview:self.bacKV];
        [self.timeV addSubview:self.closeB];
        [self creatLandB];
    }
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建设置界面 -----
-(UITableView *)tableV4{
    if (!_tableV4) {
        _tableV4 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableV4.delegate = self;
        _tableV4.dataSource = self;
        _tableV4.tag = 104;
        [_tableV4 registerClass:[YourSettingTableViewCell class] forCellReuseIdentifier:@"SETTINGCell"];
    }
    return _tableV4;
}

#pragma mark ----- 创建意见反馈 -----
-(UITableView *)tableV3{
    if (!_tableV3) {
        _tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+kScreenHeight*2/15, kScreenWidth, kScreenHeight-64-kScreenHeight*2/15-40) style:UITableViewStyleGrouped];
        _tableV3.delegate = self;
        _tableV3.dataSource = self;
        _tableV3.tag = 103;
        _tableV3.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableV3 registerClass:[PingLunTableViewCell class] forCellReuseIdentifier:@"PingCell"];
    }
    return _tableV3;
}

#pragma mark ----- 创建评论框 -----
-(UIView *)speakTV{
    if (!_speakTV) {
        _speakTV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
        _speakTV.backgroundColor = PKCOLOR(180, 170, 190);
    }
    return _speakTV;
}

-(UITextField *)speakTF{
    if (!_speakTF) {
        _speakTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth-60, 34)];
        _speakTF.backgroundColor = [UIColor whiteColor];
        _speakTF.delegate = self;
    }
    return _speakTF;
}

-(UIButton *)sendB{
    if (!_sendB) {
        _sendB = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendB.frame = CGRectMake(kScreenWidth - 53, 4,  48, 32);
        [_sendB setTitle:@"发送" forState:UIControlStateNormal];
        [_sendB addTarget:self action:@selector(sendA) forControlEvents:UIControlEventTouchUpInside];
        [_sendB setTintColor:[UIColor whiteColor]];
        _sendB.backgroundColor = [UIColor blueColor];
        _sendB.layer.masksToBounds = YES;
        _sendB.layer.cornerRadius = 8;
    }
    return _sendB;
}

#pragma mark ----- 键盘 -----
-(void)keyBoardShow:(NSNotification *)note{
    CGRect newRect = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.speakTV.transform = CGAffineTransformMakeTranslation(0, -newRect.size.height);
}

-(void)keyBoardHidden:(NSNotification *)note{
     self.speakTV.transform = CGAffineTransformIdentity;
}

#pragma mark ----- 是textfile成为第一响应者 -----
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   [self.speakTF resignFirstResponder];
    return  YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.speakTF resignFirstResponder];
}

#pragma mark ----- 创建已下载歌曲界面 -----
-(UITableView *)tableV1{
    if (!_tableV1) {
        _tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0,60, kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
        _tableV1.delegate = self;
        _tableV1.dataSource = self;
        _tableV1.tag = 101;
        [_tableV1 registerClass:[HistoryOfPlayTableViewCell class] forCellReuseIdentifier:@"historyCell"];
    }
    return _tableV1;
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 104) {
        return self.settingArr.count;
    } else {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 103) {
        return self.pingArr.count;
    } else if (tableView.tag == 104){
        return [self.settingArr[section] count];
    }else {
        return self.modelArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 103) {
        CGFloat H = [AdjustHeight adjustHeightByString:self.pingArr[indexPath.row] width:100 font:15];
        self.height = H +20;
        return H +20;
    } else if (tableView.tag == 104){
        return kScreenHeight/10;
    }else {
    return kScreenHeight/7;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 103) {
        PingLunTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PingCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
         cell.label.layer.masksToBounds = YES;
        cell.label.layer.cornerRadius = 2;
        cell.label.text = self.pingArr[indexPath.row];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (tableView.tag == 104){
        YourSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCell" forIndexPath:indexPath];
        cell.label.text = self.settingArr[indexPath.section][indexPath.row];
        if ((indexPath.row == 0 || indexPath.row == 1  )&& indexPath.section == 2) {
            cell.nextV.image = [UIImage imageNamed:@""];
            UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth*6/7, (kScreenHeight/10 - kScreenWidth/11)/2, kScreenWidth/11, kScreenWidth/11)];
            sw.transform =CGAffineTransformMakeScale(1,1);
            [cell addSubview:sw];
        }
        return cell;
    } else {
    BroadMusicModel *model = self.modelArr[indexPath.row];
    HistoryOfPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    [cell cellConfigureWithModel:model];
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 103) {
        
    } else if (tableView.tag == 104){
        if (indexPath.section == 0 && indexPath.row == 1) {
            self.timeV.frame = CGRectMake(0, kScreenHeight*4/11, kScreenWidth, kScreenHeight*7/11);
            self.bacKV.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight*4/11-64);
        }
    } else {
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
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 103 || tableView.tag == 104) {
        
    } else {
    NSInteger cc = indexPath.row;
    BroadMusicModel *model = self.modelArr[cc];
    model.isSelect = NO;
    }
}

#pragma mark ----- 创建背景界面 -----
-(UIView *)bacKV{
    if (!_bacKV) {
        _bacKV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
        _bacKV.backgroundColor = [UIColor grayColor];
        _bacKV.alpha = 0.7;
    }
    return _bacKV;
}

-(void)creatLandB{
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/11 * i, kScreenWidth/2, kScreenHeight/11)];
        label.text = self.timeArr[i];
        label.textColor = [UIColor blackColor];
        [self.timeV addSubview:label];
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(8, kScreenHeight/11*(i+1)-1, kScreenWidth-16, 1)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        [self.timeV addSubview:lineV];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tintColor = [UIColor orangeColor];
        button.frame = CGRectMake(kScreenWidth - 40, kScreenHeight/22-15 + kScreenHeight/11 * i, 30, 30);
        button.tag = 200+i;
        NSString *str = [NSString stringWithFormat:@"%d",200+i];
        if ([[TimeDisManager defaultManager].timeDic[str] isEqualToString:@"NO"]) {
        [button setImage:[UIImage imageNamed:@"圈.png"] forState:UIControlStateNormal];
        } else {
        [button setImage:[UIImage imageNamed:@"圈 YES.png"] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        [self.timeV addSubview:button];
    }
}

-(void)sureAction:(UIButton *)button{
     NSInteger ii = button.tag;
    for (int i = 0; i < 6; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",200+i];
        [[TimeDisManager defaultManager].timeDic setValue:@"NO" forKey:str];
        if (ii == i +200) {
            [[TimeDisManager defaultManager].timeDic setValue:@"YES" forKey:str];
        }
        button = [self.view viewWithTag:200+i];
        if ([[TimeDisManager defaultManager].timeDic[str] isEqualToString:@"NO"]) {
            [button setImage:[UIImage imageNamed:@"圈.png"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"圈 YES.png"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark ----- 创建定时界面 -----
-(UIView *)timeV{
    if (!_timeV) {
        _timeV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth , 0)];
        _timeV.backgroundColor = [UIColor whiteColor];
    }
    return _timeV;
}

#pragma mark ----- 创建定时界面关闭按钮 -----
-(UIButton *)closeB{
    if (!_closeB) {
        _closeB = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeB.frame = CGRectMake(0, kScreenHeight*6/11, kScreenWidth, kScreenHeight/11);
        [_closeB setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeB addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeB;
}

#pragma mark ----- 关闭界面方法 -----
-(void)closeAction{
    self.timeV.frame = CGRectMake(0, kScreenHeight, kScreenWidth , 0);
    self.bacKV.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
    YourSettingTableViewCell *cell = (YourSettingTableViewCell*)[_tableV4 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    int ii = 0;
    for (int i = 0; i < 6; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",200+i];
        NSString *value = [TimeDisManager defaultManager].timeDic[str];
        if ([value isEqualToString:@"YES"]) {
            ii = i;
            break;
        }
        ii++;
    }
    switch (ii) {
        case 0:{
            [_timer invalidate];
            cell.timeL.text = @"";
            break;}
        case 1:{
            [self timeOut1:5];
            break;}
        case 2:{
            [_timer invalidate];
            cell.timeL.text = [NSString stringWithFormat:@"%2d:00",1200/60];
            self.timeNumber = 1200;
            [self timer];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self timeOut:1200];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            });
            break;
        }
        case 3:{
            [_timer invalidate];
            cell.timeL.text = [NSString stringWithFormat:@"%2d:00",1800/60];
            self.timeNumber = 1800;
            [self timer];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self timeOut:1800];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            });
            break;
        }
        case 4:{
            [_timer invalidate];
            cell.timeL.text = [NSString stringWithFormat:@"%2d:00",3600/60];
            self.timeNumber = 3600;
            [self timer];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self timeOut:3600];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            });
            break;
        }
        case 5:{
            [_timer invalidate];
            cell.timeL.text = [NSString stringWithFormat:@"%2d:00",5400/60];
            self.timeNumber = 5400;
            [self timer];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self timeOut:5400];
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            });
            break;
        }
        default:
            break;
    }
}

#pragma mark 计时器
-(NSTimer *)timer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    return _timer;
}

#pragma mark 倒计时
-(void)time{
  YourSettingTableViewCell *cell = (YourSettingTableViewCell*)[_tableV4 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    self.timeNumber--;
    if (self.timeNumber <= 0) {
        [_timer invalidate];
        
    }
    cell.timeL.text = [NSString stringWithFormat:@"%2ld:%2ld",self.timeNumber/60,self.timeNumber%60];
    
}

#pragma mark ----- 退出程序方法 -----
-(void)timeOut:(NSInteger)time{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
    [UIView animateWithDuration:time animations:^{
//        window.alpha = 0;
    } completion:^(BOOL finished) {
            exit(0);
    }];
}

-(void)timeOut1:(NSInteger)time{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:time animations:^{
                window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
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

-(void)sendA{
    [self.pingArr addObject:self.speakTF.text];
    NSLog(@"%ld",self.pingArr.count);
    [self.tableV3 reloadData];
    if (self.pingArr.count * self.height > kScreenHeight-64-kScreenHeight*2/15-40) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.pingArr.count-1 inSection:0];
        [self.tableV3 scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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

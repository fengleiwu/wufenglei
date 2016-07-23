//
//  SubscriptionViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SubscriptionViewController.h"
#import "DetailListTableViewCell.h"
#import "MyMusicDownLoadTable.h"
#import "MusicplayViewController.h"
#import "HistoryOfPlayTableViewCell.h"
#import "BroadMusicModel.h"
#import "DingYueModel.h"
#import "SUBModel.h"

@interface SubscriptionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UISegmentedControl *segContoller;
@property (nonatomic, strong)NSMutableArray *KurlArr;
@property (nonatomic, strong)NSMutableArray *recommendArr;
@property (nonatomic, strong)NSString *URLStr;
@property (nonatomic, strong)NSArray *SUBArr;
@property (nonatomic, strong)NSArray *sqliteArr;
@property (nonatomic, strong)NSArray *urlArr;
@property (nonatomic, strong)NSMutableArray *urlidArr;
@property (nonatomic, strong)NSMutableArray *modelArr;
@property (nonatomic, strong)UITableView *tableV1;
@property (nonatomic, strong)UITableView *tableV2;
@property (nonatomic, strong)UITableView *tableV3;
@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, strong)UIImageView *imageV2;
@property (nonatomic, strong)UIButton *checkB;
@property (nonatomic, strong)UIButton *removeB;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UIView *moveV;
@property (nonatomic, strong)UIView *editV;
@end

@implementation SubscriptionViewController
-(NSMutableArray *)KurlArr{
    if (!_KurlArr) {
        _KurlArr = [NSMutableArray arrayWithObjects:KFREE1URL,KFREE2URL,KFREE3URL,KFREE4URL,KFREE5URL,KFREE6URL, nil];
    }
    return _KurlArr;
}

-(NSArray *)urlArr{
    if (!_urlArr) {
        _urlArr = @[@"http://mobile.ximalaya.com/mobile/v1/artist/albums?device=iPhone&pageId=1&pageSize=2&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1&toUid=54060615",KtheSameURL,@"http://mobile.ximalaya.com/mobile/v1/album/track?albumId=4345263&device=iPhone&isAsc=true&pageId=1&pageSize=20&statEvent=pageview%2Falbum%404345263&statModule=%E4%BB%98%E8%B4%B9%E7%B2%BE%E5%93%81&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1",@"http://mobile.ximalaya.com/mobile/v1/album?albumId=308981&device=iPhone&pageSize=20&source=5&statEvent=pageview%2Falbum%40266276&statModule=%E5%B0%8F%E7%BC%96%E6%8E%A8%E8%8D%90&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1",@"http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=4345263&device=iPhone&statEvent=pageview%2Falbum%404345263&statModule=%E4%BB%98%E8%B4%B9%E7%B2%BE%E5%93%81&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1"];
    }
    return _urlArr;
}

-(NSMutableArray *)recommendArr{
    if (!_recommendArr) {
        _recommendArr = [NSMutableArray array];
    }
    return _recommendArr;
}

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

-(NSArray *)SUBArr{
    if (!_SUBArr) {
        _SUBArr = [NSArray array];
    }
    return _SUBArr;
}

-(NSMutableArray *)urlidArr{
    if (!_urlidArr) {
        _urlidArr = [NSMutableArray array];
    }
    return _urlidArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.scrollV.contentOffset.x == 0) {
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
    if (self.scrollV.contentOffset.x == kScreenWidth*2) {
        [self refreshData];
    }
    if (self.scrollV.contentOffset.y == kScreenWidth) {
        [self refreshWithData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view addSubview:self.segContoller];
    self.navigationController.navigationBar.translucent = NO;
    [self.segContoller addSubview:self.moveV];
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.tableV1];
    self.All = YES;
    self.isClick = NO;
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.sqliteArr = [table selectAllInHistoryOfPlay];
    if (self.sqliteArr.count == 0) {
        //创建背景
        self.imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight - 64-self.tabBarController.tabBar.height)];
        self.imageV2.image = [UIImage imageNamed:@"屏幕快照 2016-07-22 下午7.20.34.png"];
        [self.scrollV addSubview:self.imageV2];
        //创建提醒标签
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*2/3+kScreenWidth*2, (kScreenHeight-self.tabBarController.tabBar.height)*1/3, 120, 30)];
        self.label2.text = @"你还没有收听过...";
        self.label2.textColor = [UIColor whiteColor];
        self.label2.font = [UIFont systemFontOfSize:15];
        [self.scrollV addSubview:self.label2];
    }else {
        self.view.backgroundColor = PKCOLOR(211, 211, 211);
        for (NSArray *arr in self.sqliteArr) {
            BroadMusicModel *model = [[BroadMusicModel alloc]init];
            model.totalTitle = arr[1];
            model.liveTitle = arr[2];
            model.bgImage = arr[4];
            [self.modelArr addObject:model];
        }
        [self.scrollV addSubview:self.tableV2];
        [self.scrollV addSubview:self.editV];
        [self.editV addSubview:self.checkB];
        [self.editV addSubview:self.removeB];
    // Do any additional setup after loading the view.
   }
    self.SUBArr = [table selectAllInDingyue];
    if (self.SUBArr.count == 0) {
        
    } else {
        self.urlidArr = [DingYueModel modelConfigureWithArray:self.SUBArr];
    }
    for (DingYueModel *model in self.urlidArr) {
        NSLog(@"%@",model.uid);
    }
    [self requestWithData];
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
    if (self.scrollV.contentOffset.x == kScreenWidth * 2) {
        MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
        self.sqliteArr = [table selectAllInHistoryOfPlay];
        if (self.sqliteArr.count == 0) {
            //创建背景
            self.imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight - 64-self.tabBarController.tabBar.height)];
            self.imageV2.image = [UIImage imageNamed:@"屏幕快照 2016-07-22 下午7.20.34.png"];
            [self.scrollV addSubview:self.imageV2];
            //创建提醒标签
            self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*2/3+kScreenWidth*2, (kScreenHeight-self.tabBarController.tabBar.height)*1/3, 120, 30)];
            self.label2.text = @"你还没有收听过...";
            self.label2.textColor = [UIColor whiteColor];
            self.label2.font = [UIFont systemFontOfSize:15];
            [self.scrollV addSubview:self.label2];
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
            // Do any additional setup after loading the view.
        }
    }
}

#pragma mark ----- 创建推荐tableView -----
-(UITableView *)tableV1{
    if (!_tableV1) {
        _tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scrollV.frame.size.height) style:UITableViewStylePlain];
        _tableV1.delegate = self;
        _tableV1.dataSource = self;
        _tableV1.tag = 101;
        _tableV1.showsVerticalScrollIndicator = NO;
        [_tableV1 registerNib:[UINib nibWithNibName:@"DetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
    }
    return _tableV1;
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 101) {
      return self.recommendArr.count;
    } else {
      return self.modelArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
      return 120;
    } else {
      return kScreenHeight/7;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        SUBModel *model = self.recommendArr[indexPath.row];
        DetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        [cell CellConfigureWithModel:model];
        return cell;
    } else{
        BroadMusicModel *model = self.modelArr[indexPath.row];
        HistoryOfPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 102) {
        if (self.isClick == NO) {
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
    if (tableView.tag == 102) {
        NSInteger cc = indexPath.row;
        BroadMusicModel *model = self.modelArr[cc];
        model.isSelect = NO;
    }
}

#pragma mark ----- 创建订阅界面 -----
-(UITableView *)tableV3{
    if (!_tableV3) {
        _tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableV3.delegate = self;
        _tableV3.dataSource = self;
        _tableV3.tag = 103;
    }
    return _tableV3;
}

#pragma mark ----- 创建已下载歌曲界面 -----
-(UITableView *)tableV2{
    if (!_tableV2) {
        _tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth *2,0, kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
        _tableV2.delegate = self;
        _tableV2.dataSource = self;
        _tableV2.tag = 102;
        [_tableV2 registerClass:[HistoryOfPlayTableViewCell class] forCellReuseIdentifier:@"historyCell"];
    }
    return _tableV2;
}

#pragma mark ----- 删除方法 -----
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 102) {
        return 1|2;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

#pragma mark ----- 创建编辑界面 -----
-(UIView *)editV{
    if (!_editV) {
        _editV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, 30)];
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
    if (self.All == YES) {
        self.tableV2.allowsMultipleSelectionDuringEditing= NO;
        [self.tableV2 setEditing:YES animated:YES];
        [self.checkB setTitle:@"取消选择" forState:UIControlStateNormal];
        self.All = NO;
        self.isClick = YES;
        for (int i = 0; i < self.modelArr.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableV2 selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            BroadMusicModel *model = self.modelArr[i];
            model.isSelect = YES;
        }
    } else {
        [self.tableV2 setEditing:NO  animated:YES];
        [self.checkB setTitle:@"选择" forState:UIControlStateNormal];
        self.All = YES;
        self.isClick = NO;
        for (int i = 0; i < self.modelArr.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [self.tableV2 deselectRowAtIndexPath:indexPath animated:YES];
            BroadMusicModel *model = self.modelArr[i];
            model.isSelect = NO;
        }
    }
}

#pragma mark ----- 删除方法 -----
-(void)removeA{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    if (self.isClick == YES) {
        for (NSInteger i = self.modelArr.count - 1; i >= 0; i--)
        {
            BroadMusicModel *model = self.modelArr[i];
            if (model.isSelect == YES) {
                [self.modelArr removeObjectAtIndex:i];
                [table delegateNoteWithHistoryOfPlayTableName:kYourDownloadTable totalTitle:model.totalTitle];
            }
        }
        self.All = NO;
        self.isClick = NO;
        [self checkA];
        [self refreshData];
    }
}

-(void)refreshData{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.sqliteArr = [table selectAllInHistoryOfPlay];
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
    [self.tableV2 reloadData];
}

-(void)refreshWithData{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.SUBArr = [table selectAllInDingyue];
    if (self.SUBArr.count == 0) {
        
    }else {
        [self.urlidArr removeAllObjects];
        self.urlidArr = [DingYueModel modelConfigureWithArray:self.SUBArr];
    }
//    [self.tableV3 reloadData];
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

-(void)requestWithData{
//    for (DingYueModel *model in self.urlidArr) {
//        if ([model.uid isEqualToString:@"2"]) {
//            if ([model.isPaid isEqualToString:@"0"]&&[model.nickName isEqualToString:@"3"]&& ![model.inter isEqualToString:@"4"]) {
//        self.URLStr = self.urlidArr[2];
//                break;
//            }
//            if ([model.inter isEqualToString:@"4"]) {
//                self.URLStr = KtheSameURL;
//                break;
//            }
//            if (![model.nickName isEqualToString:@"3"]) {
//                self.URLStr = self.urlidArr[3];
//                break;
//            }
//        } else{
//        self.URLStr = self.urlArr[0];
//        self.URLStr = [self.URLStr stringByReplacingOccurrencesOfString:@"Uid=54060615" withString:[NSString stringWithFormat:@"Uid=%@",model.uid]];
//            break;
//        }
//    }
//    [RequestManager requestWithUrlString:self.URLStr requestType:RequestGET parDic:nil finish:^(NSData *data) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
//    
//    } error:^(NSError *error) {
//        NSLog(@"bottomData --- %@", error);
//    }];
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

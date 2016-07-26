//
//  ProgramListViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProgramListViewController.h"
#import "TitleListCollectionViewCell.h"
#import "AllHotTableViewCell.h"
#import "AllMoreTableViewCell.h"
#import "AllHotModel.h"
#import "HotTitleModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "attentionViewController.h"

@interface ProgramListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *HotArr;
@property (nonatomic,strong)NSMutableArray *iidArr;
@property (nonatomic, strong)NSMutableArray *urlIdArr;
@property (nonatomic, strong)NSMutableArray *AllHotArr;
@property (nonatomic ,strong)UICollectionView *collectionV;
@property (nonatomic, strong)UIScrollView *largeScrollV;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (nonatomic, strong)UILabel *allL;
@property (nonatomic, strong)UIImageView *ALLImageV;
@property (nonatomic, strong)UIView *moveV;
@property (nonatomic, strong)UIView *ALLV;
@property (nonatomic, strong)UIView *selectV;
@property (nonatomic, strong)UIView *backV;
@property (nonatomic, strong)UIButton *moreB;
// 用于判断使用哪种 cell
@property (nonatomic, strong)NSString *cellName;

@end

@implementation ProgramListViewController
-(NSMutableArray *)HotArr{
    if (!_HotArr) {
        _HotArr = [NSMutableArray array];
    }
    return _HotArr;
}

-(NSMutableArray *)iidArr{
    if (!_iidArr) {
        _iidArr = [NSMutableArray array];
    }
    return _iidArr;
}

-(NSMutableArray *)AllHotArr{
    if (!_AllHotArr) {
        _AllHotArr = [NSMutableArray array];
    }
    return _AllHotArr;
}

-(NSMutableArray *)urlIdArr{
    if (!_urlIdArr) {
        _urlIdArr = [NSMutableArray array];
    }
    return _urlIdArr;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.moreB removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //更多按钮
    self.moreB = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreB.tintColor = [UIColor blackColor];
    self.moreB.backgroundColor = [UIColor whiteColor];
    self.moreB.frame = CGRectMake(kScreenWidth-70, 10, 30, 30);
    [self.moreB setImage:[UIImage imageNamed:@"更多.png"] forState:UIControlStateNormal];
    [self.moreB addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.moreB];
    [self requestData];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 分享方法 -----
-(void)moreAction{
    //分享
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"1004.jpg"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }

}

#pragma mark ----- 创建标题collectionTitle -----
-(UICollectionView *)collectionV{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(110, 25);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing= 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 25) collectionViewLayout:layout];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        [_collectionV registerClass:[TitleListCollectionViewCell class] forCellWithReuseIdentifier:@"titlelistCell"];
        [_collectionV selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    }
    return _collectionV;
}

#pragma mark ----- 创建滑动块 -----
-(UIView *)moveV{
    if (!_moveV) {
        _moveV = [[UIView alloc]initWithFrame:CGRectMake(0, 24, 110, 1)];
        _moveV.backgroundColor = [UIColor orangeColor];
    }
    return _moveV;
}

#pragma mark ----- 创建总滑图 -----
-(void)clargeScrollV{
    _largeScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _largeScrollV.showsHorizontalScrollIndicator = YES;
    _largeScrollV.pagingEnabled = YES;
    _largeScrollV.delegate = self;
    _largeScrollV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.largeScrollV];
}

#pragma mark ----- 滑动方法 -----
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y != 0) {
        self.collset = YES;
    } else {
        if (scrollView != self.collectionV && scrollView.contentOffset.x !=0)
        {
            self.moveV.frame = CGRectMake(110 * (scrollView.contentOffset.x / kScreenWidth), 24, 110, 1);
        }
    }
}



#pragma mark --- 结束减速触发的方法 ---
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.collset == YES) {
        self.collset = NO;
    } else {
    
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth) inSection:0]];
    
        NSLog(@"%ld",(long)self.conset);
        NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x > 0 ||scrollView.contentOffset.x >self.conset) {
        TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth)-1 inSection:0]];
        cell.label.textColor = [UIColor grayColor];
        cell.label.font = [UIFont systemFontOfSize:16];
        
    }
    if (scrollView.contentOffset.x <self.conset) {
        TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth)+1 inSection:0]];
        cell.label.textColor = [UIColor grayColor];
        cell.label.font = [UIFont systemFontOfSize:16];
    }
    
    // 如果滚动的不是 collectionView 证明是scrollView 我们需要设置 collectionView的偏移
    if (scrollView != self.collectionV)
    {
        cell.label.textColor = [UIColor orangeColor];
        cell.label.font = [UIFont systemFontOfSize:20];
        [self requestDataWithIndex:(NSInteger)(NSInteger)(scrollView.contentOffset.x / kScreenWidth)+1000];
        [_collectionV selectItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth) inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        if (scrollView.contentOffset.x / kScreenWidth != 0)
        {
            [self.collectionV setContentOffset:CGPointMake(110 * (scrollView.contentOffset.x / kScreenWidth) - 110, 0) animated:YES];
        }
    }
        self.conset = scrollView.contentOffset.x;
        NSLog(@"%ld",(long)self.conset);
    
    }
}

#pragma mark ----- 创建全部视图 -----
-(void)creatALLV{
        self.ALLV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-80,0, 80, 25)];
        self.ALLV.backgroundColor = [UIColor whiteColor];
        self.allL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
        self.allL.text = @"全部";
        [self.ALLV addSubview:self.allL];
        self.ALLImageV = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 25, 25)];
        self.ALLImageV.image = [UIImage imageNamed:@"箭头.png"];
        [self.ALLV addSubview:self.ALLImageV];
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.ALLV addGestureRecognizer:self.tap];
        self.isClick = NO;
        [self.view addSubview:self.ALLV];
}

#pragma mark ----- 手势方法 -----
-(void)tapAction{
    if (self.isClick == NO) {
        self.allL.text = @"收起";
        self.ALLImageV.image = [UIImage imageNamed:@"取消 (1).png"];
        self.selectV.frame = CGRectMake(0, 25, kScreenWidth, kScreenHeight*2/3 -64);
        self.backV.frame = CGRectMake(0, kScreenHeight*2/3-64, kScreenWidth, kScreenHeight/3+64);
        self.isClick = YES;
        [self creatTypeButton];
    } else{
        self.allL.text = @"全部";
        self.ALLImageV.image = [UIImage imageNamed:@"箭头.png"];
        self.isClick = NO;
        self.backV.frame = CGRectMake(0, 0,1,1);
        self.selectV.frame = CGRectMake(0, 0,1,1);
        for (int i = 0; i < self.HotArr.count; i++) {
            UIButton *button = [self.view viewWithTag:i + 100];
            [button removeFromSuperview];
        }
    }
}

#pragma mark ----- 创建选择界面 -----
-(UIView *)selectV{
    if (!_selectV) {
        _selectV = [[UIView alloc]initWithFrame:CGRectMake(0, 0,1,1)];
        _selectV.backgroundColor = [UIColor whiteColor];
    }
    return _selectV;
}

#pragma mark ----- 创建不可拖动视图 -----
-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        _backV.backgroundColor = [UIColor grayColor];
        _backV.alpha = 0.4;
    }
    return _backV;
}

#pragma mark ----- 创建类型选项 -----
-(void)creatTypeButton{
    NSInteger aa = 0;
    for (HotTitleModel *model in self.HotArr) {
        TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:aa inSection:0]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame =CGRectMake(aa%3 *(kScreenWidth/3)+4, aa/3 *((kScreenHeight*2/3 -89)/8)+2,kScreenWidth/3 -4,20);
        button.tag = aa + 100;
        [button setTitle:model.name forState:UIControlStateNormal];
        if (cell.isSelected) {
            [button setTintColor:[UIColor whiteColor]];
            button.backgroundColor = [UIColor orangeColor];
        } else {
        [button setTintColor:[UIColor blackColor]];
        button.backgroundColor = PKCOLOR(245, 245, 245);
        }
        [button addTarget:self action:@selector(typeNextAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectV addSubview:button];
        aa++;
    }
}

#pragma mark ----- button方法 -----
-(void)typeNextAction:(UIButton *)button{
    [self.collectionV reloadData];
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag-100 inSection:0]];
    [_collectionV selectItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag -100 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    cell.label.textColor = [UIColor orangeColor];
    cell.label.font = [UIFont systemFontOfSize:20];
        [self requestDataWithIndex:button.tag -100+1000];
        [_collectionV setContentOffset:CGPointMake(110 * (button.tag -100) - 110, 0) animated:YES];
    
    self.moveV.frame = CGRectMake(110 * (button.tag -100), 24, 110, 1);
    [self.largeScrollV setContentOffset:CGPointMake(kScreenWidth* (button.tag -100), 0) animated:NO];
    self.conset = self.largeScrollV.contentOffset.x;
    self.isClick = YES;
    [self tapAction];
    
}

#pragma mark ----- 创建tableView -----
-(void)creatForTableV{
    for (NSInteger i = 0; i < self.HotArr.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 20, kScreenWidth, kScreenHeight-84) style:UITableViewStylePlain];
        tableView.tag = i +1000;
        tableView.backgroundColor= [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        if ([self.urlStr isEqualToString:KHotRankURL]) {
            [tableView registerClass:[AllHotTableViewCell class] forCellReuseIdentifier:@"ALLHOTCell"];
            self.cellName = @"ALLHOTCell";
        }
        if ([self.urlStr isEqualToString:KMoreRankURL] || [self.urlStr isEqualToString:KPrefectURL]) {
            [tableView registerClass:[AllMoreTableViewCell class] forCellReuseIdentifier:@"ALLMORECell"];
            self.cellName = @"ALLMORECell";
        }
        [self.largeScrollV addSubview:tableView];
    }
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.AllHotArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cellName isEqualToString:@"ALLHOTCell"]) {
        AllHotModel *model = self.AllHotArr[indexPath.row];
        CGFloat H = [AdjustHeight adjustHeightByString:model.title width:kScreenWidth*9/10-80 font:18];
        return H+50;
    } else {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllHotModel *model = self.AllHotArr[indexPath.row];
    if ([self.urlStr isEqualToString:KHotRankURL]) {
        AllHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALLHOTCell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        if (indexPath.row == 0) {
            cell.rankL.textColor = PKCOLOR(255, 69, 0);
        }
        if (indexPath.row == 1) {
            cell.rankL.textColor = PKCOLOR(255, 160, 0);
        }
        if (indexPath.row == 2) {
            cell.rankL.textColor = PKCOLOR(154, 205, 50);
        }
        return cell;
    }
    if ([self.urlStr isEqualToString:KMoreRankURL] || [self.urlStr isEqualToString:KPrefectURL]) {
     AllMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALLMORECell" forIndexPath:indexPath];
        [cell cellConfigureWithModel:model];
        cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
        if (indexPath.row == 0) {
            cell.rankL.textColor = PKCOLOR(255, 69, 0);
        }
        if (indexPath.row == 1) {
            cell.rankL.textColor = PKCOLOR(255, 160, 0);
        }
        if (indexPath.row == 2) {
            cell.rankL.textColor = PKCOLOR(154, 205, 50);
        }
        return cell;
    }
    return nil;
}

#pragma mark ----- collection协议方法 -----
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.HotArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotTitleModel *model = self.HotArr[indexPath.row];
    TitleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titlelistCell" forIndexPath:indexPath];
    [cell CellConfigureWithModel:model];
    cell.label.textColor = [UIColor grayColor];
    cell.label.font = [UIFont systemFontOfSize:16];
    if (cell.isSelected) {
        cell.label.textColor = [UIColor orangeColor];
        cell.label.font = [UIFont systemFontOfSize:20];
    }
    return cell;
}

#pragma mark --- 点击cell的方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor orangeColor];
    cell.label.font = [UIFont systemFontOfSize:20];
    
    if (indexPath.row != 0)
    {
        [self requestDataWithIndex:indexPath.row+1000];
        [collectionView setContentOffset:CGPointMake(110 * indexPath.row - 110, 0) animated:YES];
    }
    
    self.moveV.frame = CGRectMake(110 * indexPath.row, 24, 110, 1);
    [self.largeScrollV setContentOffset:CGPointMake(kScreenWidth* indexPath.row, 0) animated:NO];
    
    self.isClick = YES;
    [self tapAction];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor grayColor];
    cell.label.font = [UIFont systemFontOfSize:16];
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
//    NSLog(@"%@",self.urlStr);
    [RequestManager requestWithUrlString:self.urlStr requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.HotArr = [HotTitleModel modelConfigureWithDic:dic];
        for (HotTitleModel *model in self.HotArr) {
            if ([model.name isEqualToString:@"总榜"]) {
                [self.urlIdArr addObject:@"1_57_ranking"];
                [self.iidArr addObject:@"0"];
            } else {
            NSString *str = model.keyy;
            str = [[str componentsSeparatedByString:@":"] firstObject];
            [self.urlIdArr addObject:str];
                [self.iidArr addObject:[NSString stringWithFormat:@"%ld",[model.idd integerValue]]];
            }
        }
        
        [self clargeScrollV];
        [self creatForTableV];
        [self.view addSubview:self.collectionV];
        [self creatALLV];
        [self.view addSubview:self.selectV];
        [self.view addSubview:self.backV];
        self.largeScrollV.contentSize = CGSizeMake(kScreenWidth *self.HotArr.count, 0);
        
        [self.collectionV addSubview:self.moveV];
        [self requestDataWithIndex:1000];
    } error:^(NSError *error) {
        NSLog(@"errpr == %@",error);
    }];
}

-(void)requestDataWithIndex:(NSInteger)index{
    NSString *str = self.urlStr;
    if ([self.urlStr isEqualToString:KHotRankURL]) {
        str = [str stringByReplacingOccurrencesOfString:@"1_57_ranking" withString:self.urlIdArr[index-1000]];
        str = [str stringByReplacingOccurrencesOfString:@"A0&pageId=1" withString:[NSString stringWithFormat:@"A%@&pageId=1",self.iidArr[index- 1000]]];
    }
    if ([self.urlStr isEqualToString:KMoreRankURL]) {
        str = [str stringByReplacingOccurrencesOfString:@"1_21_ranking" withString:self.urlIdArr[index-1000]];
        str = [str stringByReplacingOccurrencesOfString:@"A0&pageId=1" withString:[NSString stringWithFormat:@"A%@&pageId=1",self.iidArr[index- 1000]]];
    }
    if ([self.urlStr isEqualToString:KPrefectURL]) {
        str = [str stringByReplacingOccurrencesOfString:@"1_63_ranking" withString:self.urlIdArr[index-1000]];
        str = [str stringByReplacingOccurrencesOfString:@"A0&pageId=1" withString:[NSString stringWithFormat:@"A%@&pageId=1",self.iidArr[index- 1000]]];
    }
    [RequestManager requestWithUrlString:str requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.AllHotArr = [AllHotModel modelConfigureWithDic:dic];
        UITableView *tableView = [self.view viewWithTag:index];
        [tableView reloadData];
//        NSLog(@"%@",dic);
    } error:^(NSError *error) {
        NSLog(@"errpr == %@",error);
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllHotModel *model = self.AllHotArr[indexPath.row];
    attentionViewController *attent = [[attentionViewController alloc]init];
    attent.Uid = model.uid;
    [self.navigationController pushViewController:attent animated:YES];
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

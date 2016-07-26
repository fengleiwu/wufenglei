//
//  CategoryListViewController.m
//  Product-BB
//
//  Created by 林建 on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CategoryListViewController.h"
#import "TitleListCollectionViewCell.h"
#import "DetailListTableViewCell.h"
#import "CateTypeModel.h"
#import "TableListModel.h"
#import "AlbumDetailViewController.h"
@interface CategoryListViewController ()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIView *moveV;
@property (nonatomic, strong)UIScrollView *largeScrollV;
@property (nonatomic, strong)NSMutableArray *tableArr;
@property (nonatomic, strong)NSMutableArray *urlIdArr;
@property (nonatomic, strong)NSMutableArray *iddArr;
@property (nonatomic, strong)NSMutableArray *nameArr;
@property (nonatomic, strong)NSMutableArray *collectionArr;
@property (nonatomic, strong)NSMutableDictionary *nameDic;
@property (nonatomic, strong)UICollectionView *collectionV;
@end

@implementation CategoryListViewController
-(NSMutableArray *)collectionArr{
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}

-(NSMutableArray *)tableArr{
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }
    return _tableArr;
}

-(NSMutableArray *)urlIdArr{
    if (!_urlIdArr) {
        _urlIdArr = [NSMutableArray array];
    }
    return _urlIdArr;
}

-(NSMutableArray *)iddArr{
    if (!_iddArr) {
        _iddArr = [NSMutableArray array];
    }
    return _iddArr;
}

-(NSMutableArray *)nameArr{
    if (!_nameArr) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}

-(NSMutableDictionary *)nameDic{
    if (!_nameDic) {
        _nameDic = [NSMutableDictionary dictionary];
    }
    return _nameDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    self.limit = 1;
    [self requestData1];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 创建标题 -----
-(UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth /2-50, 15, 100, 44)];
        _titleL.text = self.titleStr;
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:20];
    }
    return _titleL;
}

#pragma mark ----- 创建总滑图 -----
-(void)clargeScrollV{
        _largeScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        _largeScrollV.showsHorizontalScrollIndicator = YES;
        _largeScrollV.pagingEnabled = YES;
        _largeScrollV.delegate = self;
        _largeScrollV.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.largeScrollV];
}

#pragma mark ----- 创建tableView -----
-(void)creatForTableV{
    for (NSInteger i = 0; i < self.collectionArr.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        tableView.tag = i +1000;
        tableView.backgroundColor= [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerNib:[UINib nibWithNibName:@"DetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
               // 上拉刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.tableArr removeAllObjects];
            self.start = 0;
            self.reload = YES;
            self.colset = NO;
            [self requestData2:self.urlIdArr[i] index:1000 +i];
        }];
        
        // 下拉加载数据
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.start = self.limit *20;
            self.limit +=1;
            self.reload = YES;
            self.colset = NO;
            if (self.startOver == YES) {
            } else {
               [self requestData2:self.urlIdArr[i] index:1000 +i];
            }
        }];
     [self.largeScrollV addSubview:tableView];
    }
}

#pragma mark ----- 滑动方法 -----
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y != 0 ) {
        if (self.reload == YES) {
           
        }else {
            self.colset = YES;//yes cell滑动
        }
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
    if ( self.colset == YES ) {
        self.colset = NO;
        
    } else if(self.reload == YES && self.colset != NO){
        self.reload = NO;
    } else {
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[_collectionV cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth) inSection:0]];
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
        UITableView *tableView = [self.view viewWithTag:(NSInteger)(scrollView.contentOffset.x / kScreenWidth)+1000];
//        NSLog(@"%ld",tableView.tag);
        NSInteger key = (NSInteger)(scrollView.contentOffset.x / kScreenWidth);
        if ([self.nameDic[self.nameArr[key]] isEqualToString:@"Yes"] ) {
//            [self requestData2:self.urlIdArr[(NSInteger)(scrollView.contentOffset.x / kScreenWidth)] index:(NSInteger)(scrollView.contentOffset.x / kScreenWidth)+1000];
        } else {
            [self.nameDic setValue:@"Yes" forKey:self.nameArr[(NSInteger)(scrollView.contentOffset.x / kScreenWidth)]];
            [tableView.mj_header beginRefreshing];
        }
        [_collectionV selectItemAtIndexPath:[NSIndexPath indexPathForRow:(NSInteger)(scrollView.contentOffset.x / kScreenWidth) inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        if (scrollView.contentOffset.x / kScreenWidth != 0)
        {
            [self.collectionV setContentOffset:CGPointMake(110 * (scrollView.contentOffset.x / kScreenWidth) - 110, 0) animated:YES];
        }
    }
    self.conset = scrollView.contentOffset.x;
    }
}

#pragma mark ----- tableView协议方法 -----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableListModel *model = self.tableArr[indexPath.row];
    DetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    [cell cellConfigureWithModel:model];
    if ([self.URLLStr isEqualToString:KMustListenURL]) {
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290] completed:nil];
    }
    return cell;
}

#pragma mark ----- 数据请求 -----
-(void)requestData1{
    if ([self.URLLStr isEqualToString:KnovelURL]) {
        NSString *str = KnovelURL;
        str = [str stringByReplacingOccurrencesOfString:@"categoryId=3" withString:[NSString stringWithFormat:@"categoryId=%ld",self.idd]];
        self.URLLStr = str;
    } else {
   
    }
    [RequestManager requestWithUrlString:self.URLLStr requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
        self.collectionArr = [CateTypeModel modelConfigureWithDic:dic];
        for (CateTypeModel *model in self.collectionArr) {
            if (model.name != nil) {
                [self.nameDic setValue:@"NO" forKey:model.name];
                [self.nameArr addObject:model.name];
            } else {
                [self.nameDic setValue:@"NO" forKey:model.keywordName];
                [self.nameArr addObject:model.keywordName];
            }
           
        }
        if ([self.URLLStr isEqualToString:KShanghaiURL]) {
            for (CateTypeModel *model in self.collectionArr) {
                [self.urlIdArr addObject:model.idd];
            }
        } else if ([self.URLLStr isEqualToString:KMustListenURL]){
            for (CateTypeModel *model in self.collectionArr) {
                [self.urlIdArr addObject:model.idd];
            }
        }
        else {
            for (CateTypeModel *model in self.collectionArr) {
                [self.urlIdArr addObject:model.keywordId];
            }
        }
//        NSLog(@"%@",self.urlIdArr);
        [self clargeScrollV];
        [self creatForTableV];
        [self.view addSubview:self.collectionV];
        self.largeScrollV.contentSize = CGSizeMake(kScreenWidth *self.collectionArr.count, 0);
        [self.collectionV addSubview:self.moveV];
         UITableView *tableView = [self.view viewWithTag:1000];
        [self.nameDic setValue:@"Yes" forKey:self.nameArr[0]];
        [tableView.mj_header beginRefreshing];
//        [self requestData2:self.urlIdArr[0] index:1000];
    } error:^(NSError *error) {
//        NSLog(@"bottomData --- %@", error);
    }];
}

-(void)requestData2:(NSString *)idd index:(NSInteger)index{
    NSString *str = [NSString string];
    if ([self.URLLStr isEqualToString:KShanghaiURL]) {
        str = KShanghaiTableURL;
        str = [str stringByReplacingOccurrencesOfString:@"categoryId=22" withString:[NSString stringWithFormat:@"categoryId=%@",idd]];
    } else if ([self.URLLStr isEqualToString:KMustListenURL]){
        str = KMustListenTableURL;
        str = [str stringByReplacingOccurrencesOfString:@"key=1_3_ranking" withString:[NSString stringWithFormat:@"key=1_%@_ranking",idd]];
        str = [str stringByReplacingOccurrencesOfString:@"A3&pageId=1" withString:[NSString stringWithFormat:@"A%@&pageId=1",idd]];
    } else if ([self.URLLStr isEqualToString:KBuyGoodURL]){
        str = KBuyGoodTableURL;
        str = [str stringByReplacingOccurrencesOfString:@"keywordId=373" withString:[NSString stringWithFormat:@"keywordId=%@",idd]];
    }
    else {
        str = KtableURL;
//        NSLog(@"%ld",self.idd);
        str = [str stringByReplacingOccurrencesOfString:@"categoryId=3" withString:[NSString stringWithFormat:@"categoryId=%ld",self.idd]];
        str = [str stringByReplacingOccurrencesOfString:@"keywordId=232" withString:[NSString stringWithFormat:@"keywordId=%@",idd]];
    }
    //改变每次请求的数据
    if (self.limit >1) {
       str = [str stringByReplacingOccurrencesOfString:@"pageId=1" withString:[NSString stringWithFormat:@"pageId=%ld",self.limit]];
    }
    [RequestManager requestWithUrlString:str requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        UITableView *tableView = [self.view viewWithTag:index];
//        NSLog(@"%@",dic);
        if (self.limit *20 > [dic[@"totalCount"] integerValue]) {
            [tableView.mj_footer endRefreshing];
            self.startOver = YES;
        }
        NSArray *arr1 = [TableListModel modelConfigureWithDic:dic];
        for (TableListModel *model in arr1) {
            [self.tableArr addObject:model];
        }
        
//        [tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
            [tableView.mj_header endRefreshing];
            [tableView.mj_footer endRefreshing];
        });
        self.reload = NO;
//        NSLog(@"%@",self.tableArr);
    } error:^(NSError *error) {
        NSLog(@"bottomData --- %@", error);
    }];
}

#pragma mark ----- 创建滑动块 -----
-(UIView *)moveV{
    if (!_moveV) {
        _moveV = [[UIView alloc]initWithFrame:CGRectMake(0, 24, 110, 1)];
        _moveV.backgroundColor = [UIColor orangeColor];
    }
    return _moveV;
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

#pragma mark ----- collection协议方法 -----
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CateTypeModel *model = self.collectionArr[indexPath.row];
    TitleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titlelistCell" forIndexPath:indexPath];
    [cell cellConfigureWithModel:model];
    if ([self.URLLStr isEqualToString:KShanghaiURL] || [self.URLLStr isEqualToString:KMustListenURL]) {
        cell.label.text = model.name;
    }
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
    self.conset = kScreenWidth *indexPath.row;
    if (indexPath.row != 0)
    {
        UITableView *tableView = [self.view viewWithTag:indexPath.row+1000];
        NSInteger key = indexPath.row;
        if ([self.nameDic[self.nameArr[key]] isEqualToString:@"Yes"] ) {
//            [self requestData2:self.urlIdArr[indexPath.row] index:indexPath.row+1000];
        } else {
            [self.nameDic setValue:@"Yes" forKey:self.nameArr[indexPath.row]];
            [tableView.mj_header beginRefreshing];
        }
//        [self requestData2:self.urlIdArr[indexPath.row] index:indexPath.row+1000];
        [collectionView setContentOffset:CGPointMake(110 * indexPath.row - 110, 0) animated:YES];
    }
    
    self.moveV.frame = CGRectMake(110 * indexPath.row, 24, 110, 1);
    [self.largeScrollV setContentOffset:CGPointMake(kScreenWidth* indexPath.row, 0) animated:NO];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleListCollectionViewCell *cell = (TitleListCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.label.textColor = [UIColor grayColor];
        cell.label.font = [UIFont systemFontOfSize:16];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableListModel *model = self.tableArr[indexPath.row];
    AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
    
    album.url = model.albumId;
    if (model.isPaid == true) {
        album.uid = model.uid;
        album.isPaid = YES;
        album.nickName = model.nickname;
        album.score = [NSString stringWithFormat:@"%@",model.score];
        album.displayPrice = model.displayDiscountedPrice;
        
        }else{
        album.inter = 4;
    }
    [self.navigationController pushViewController:album animated:YES];
    
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

//
//  CategoryViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryListViewController.h"
#import "ShopViewController.h"
#import "CategoryCarouselModel.h"
#import "CategoryBottomModel.h"
#import "CategoryTableViewCell.h"

@interface CategoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UICollectionView *middleCollectionView;
@property (nonatomic, strong) NSMutableArray *carouselesArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *otherTap;
@end

@implementation CategoryViewController
- (NSMutableArray *)carouselesArray {
    if (!_carouselesArray) {
        _carouselesArray = [NSMutableArray array];
    }
    return _carouselesArray;
}

- (NSMutableArray *)tableArray {
    if (!_tableArray) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self requestCarouselData];
    [self requestData];
    
}

#pragma mark ----- 数据请求 -----
-(void)requestData{
[RequestManager requestWithUrlString:KTuiGuangURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataDic = dic[@"data"];
    NSDictionary *Dic = dataDic[0];
    self.webStr = Dic[@"link"];
    self.imageStr = Dic[@"cover"];
//    NSLog(@"%@",dic);
    [self creatbottomView];
    [self requestTableViewData];
} error:^(NSError *error) {
//    NSLog(@"errpr == %@",error);
}];
}

// 最下方的  数据
- (void)requestTableViewData {
    [RequestManager requestWithUrlString:KCategoryBottomURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.tableArray = [CategoryBottomModel modelConfigureWithDic:dic];
        // 创建tableView
        [self creatTableView];
    } error:^(NSError *error) {
//        NSLog(@"bottomData --- %@", error);
    }];
}

#pragma mark ----- 创建头部视图 -----
-(void)creatbottomView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.imageStr] completed:nil];
    [self.headView addSubview:imageV];
    self.otherTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.headView addGestureRecognizer:self.otherTap];
}

#pragma mark ----- 手势方法 -----
-(void)tapAction{
    ShopViewController *shopVC = [[ShopViewController alloc]init];
    shopVC.webStr = self.webStr;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:shopVC animated:YES];
}

#pragma mark --- tableView (有声书、音乐等）
- (void)creatTableView {
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 130) style:(UITableViewStylePlain)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerClass:[CategoryTableViewCell class]forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    //创建头视图轮播图
    self.tableV.tableHeaderView = self.headView;
}


-(void)nextList{
    
}

#pragma mark --- tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"11%ld",indexPath.section);
    // 前五个图片不好看，换自己的。
    NSArray *imageArr = @[@"find_book@3x",@"find_music@3x",@"find_other@3x",@"find_comic@3x",@"find_kid@3x"];
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    NSInteger index = indexPath.row * 2;
    if (index < self.tableArray.count) {
        CategoryBottomModel *modelLeft = self.tableArray[index];
        if (index < 5) {
            cell.leftImageV.image = [UIImage imageNamed:imageArr[index]];
        } else {
            [cell.leftImageV sd_setImageWithURL:[NSURL URLWithString:modelLeft.coverPath]];
        }
        cell.leftTitleL.text = modelLeft.title;
        cell.leftBtn.tag = [modelLeft.myid integerValue];
        
        CategoryBottomModel *modelRight = self.tableArray[index + 1];
        if (index<3) {
            cell.rightImageV.image = [UIImage imageNamed:imageArr[index +1]];
        } else {
            [cell.rightImageV sd_setImageWithURL:[NSURL URLWithString:modelRight.coverPath]];
        }
        cell.rightTitleL.text = modelRight.title;
        cell.rightBtn.tag = [modelRight.myid integerValue];
        
    }
    [cell.leftBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.rightBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

#pragma mark ----- 页面跳转方法 -----
- (void)pushAction:(UIButton *)button {
    for (CategoryBottomModel *model in self.tableArray) {
        if ([model.myid integerValue] == button.tag) {
            CategoryListViewController *cListVC = [[CategoryListViewController alloc]init];
            cListVC.titleStr = model.title;
            cListVC.idd = [model.myid integerValue];
            cListVC.URLLStr = KnovelURL;
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:cListVC animated:YES];
            return;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

//#pragma mark --- collection 代理方法
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    // 所有数据在一个数组里，每个分区有 6 个 item，则 section =
////    NSInteger count = self.bottomCollectionArray.count / 6;
//    // count = 4，不知道怎么取5，所以直接给了。
//    return 5;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section == 4) {
//        return 2;
//    }
//    return 6;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CategoryBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottom" forIndexPath:indexPath];
//    CategoryBottomModel *model = self.bottomCollectionArray[indexPath.item + indexPath.section];
//    [cell cellConfigureWithModel:model];
//    cell.backgroundColor = [UIColor grayColor];
//    return cell;
//}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

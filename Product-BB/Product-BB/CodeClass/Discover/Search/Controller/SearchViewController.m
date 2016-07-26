//
//  SearchViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SearchViewController.h"
#import "hotRecommendsModel.h"
#import "AlbumDetailViewController.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UISearchController *search;
// 请求下来的基本数组
//@property (nonatomic, strong) NSMutableArray *dataArr;
// 需要搜索的title 放在一个数组
@property (nonatomic, strong) NSMutableArray *searchArr;
// model 放在一个数组
@property (nonatomic, strong) NSMutableArray *modelArr;
// 搜索结果放在一个数组
@property (nonatomic, strong) NSMutableArray *resultArr;
// 不知道怎么描述，在 viewdidload 里==0，点击方法里使用了。
@property (nonatomic, assign) NSInteger i;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.i = 0;
    
    [self requestData];
    [self creatSearchController];
    [self creatTableView];
    self.tableV.tableHeaderView = self.search.searchBar;
}

- (void)requestData {
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSMutableArray *basicArray =[[NSMutableArray alloc]init];
        NSMutableArray *titleArr = [NSMutableArray array];
        NSMutableArray *modelA = [NSMutableArray array];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        basicArray = [hotRecommendsModel hotRecommends:dic];
        for (NSArray *modelArr in basicArray) {
            for (hotRecommendsModel *model in modelArr) {
                NSString *str = [NSString string];
                str = model.title;
                [titleArr addObject:str];
                [modelA addObject:model];
            }
        }
        self.searchArr = titleArr;
        self.modelArr = modelA;
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}

- (void)creatSearchController {
    self.search = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置显示搜索结果的显示器
    self.search.searchResultsUpdater = self;
    //设置开始搜索时, 背景显示与否
    self.search.dimsBackgroundDuringPresentation = NO;
    self.search.searchBar.delegate = self;
    //searchController的代理
    self.search.delegate = self;
    self.search.searchBar.placeholder = @"请输入专辑名称";
    // 修改取消按钮
    self.search.searchBar.showsCancelButton = YES;
    UIButton *btn = [self.search.searchBar valueForKey:@"cancelButton"];
    [btn setTitle:@"取消" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}

- (void)creatTableView {
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableV.rowHeight = 50;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    // scrollview 上面有20的空，
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UISearchResultsUpdating
//在搜索框输入的时候会调用该方法, 每一次输入都会调用该方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", searchController.searchBar.text];
    // 通过谓词索索 将检验出来的数据 从原有数据中提取出来 放到新的数组中 也就是从原来的中的数据检测提取出来后 放到检测后的数组中self.arr中
    self.resultArr = [[NSMutableArray alloc] initWithArray:[self.searchArr filteredArrayUsingPredicate:predicate]];
    [self.tableV reloadData];//更新数据
}

#pragma mark - UISearchBarDelegate
//点击cancel时触发 也就是点击取消搜索时触发
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
//点击cell触发, 可以在这个方法中处理cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleString = self.resultArr[indexPath.row];
    
    hotRecommendsModel *model = [[hotRecommendsModel alloc]init];
    for (hotRecommendsModel *mo in self.modelArr) {
        if ([titleString isEqualToString:mo.title]) {
            model = mo;
//            NSLog(@"werer");
        }
    }
    AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
    album.url = model.albumId;
    album.nickName = model.nickname;
    model.score = [NSString stringWithFormat:@"%@", model.score];
    // 有评分传，没评分不传
    if (model.score != NULL && ![model.score isEqualToString:@""]) {
        album.score = model.score;
    }
    
    if (model.displayPrice == nil || [model.displayPrice isEqualToString:@""]) {
        // 没购买
        album.inter = 4;
    } else {
        // 有购买
        album.displayPrice = model.displayPrice;
    }
    
    if (self.i == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.i++;
    }
    
    [self.navigationController pushViewController:album animated:YES];
}

#pragma mark - UITableVIewDataSource
//设置分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//设置每个分区对应的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}
//返回对应的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // 显示搜索结果数组的值
    cell.textLabel.text = self.resultArr[indexPath.row];
    return cell;
}
#pragma mark --- 键盘隐藏
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.search.searchBar resignFirstResponder];
}


@end

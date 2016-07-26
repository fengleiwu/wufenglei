//
//  DiscoverViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverViewController.h"
#import "BroadcastViewController.h"
#import "CategoryListViewController.h"
#import "CarouselView.h"
#import "focusImagesModel.h"
#import "editorRecommendAlbumsTableViewCell.h"
#import "DiscoverCollectView.h"
#import "hotRecommendsModel.h"
#import "WEBModel.h"
#import "DiscoverWebViewController.h"
#import "recommendMoreViewController.h"
#import "AlbumDetailViewController.h"
#import "specialTableViewCell.h"
#import "qualityGoodsTableViewController.h"
#import "ListenDetailViewController.h"
//#import "AnchorTableView.h"
#import "SearchViewController.h"
#import "AnchorTableViewController.h"

@interface DiscoverViewController ()<UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, strong)UIScrollView *scr;
@property (nonatomic, strong)UISegmentedControl *seg;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)NSMutableArray *focusImages;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CarouselView *car;
@property (nonatomic, strong)NSMutableArray *cellArray;//小便推荐
@property (nonatomic, strong)NSMutableArray *specialColumnArray;//精品停单
@property (nonatomic, strong)NSMutableArray *arr;
@property (nonatomic, strong)UIViewController *subVC;
@property (nonatomic, strong)BroadcastViewController *broadVC;
@property (nonatomic, strong)DiscoverCollectView *discell;
@property (nonatomic, strong)NSMutableArray *bigArray;//一样的东西
@property (nonatomic, strong)NSMutableArray *bigTingDanArr;
@property (nonatomic, strong)NSMutableArray *titleArray;
@property (nonatomic, strong)NSMutableArray *controllers;
@property (nonatomic, strong)NSMutableArray *TingListArr;
@property (nonatomic, strong)NSMutableArray *ListNameArr;
@property (nonatomic, strong)NSMutableArray *TingListURLArr;
@property (nonatomic, strong)NSMutableArray *bottomPicArray;
@property (nonatomic, strong)NSMutableArray *bigBottomPicArray;
@property (nonatomic, strong)CarouselView *bottomPic;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)AnchorTableViewController *anchor;

@end

@implementation DiscoverViewController
-(NSMutableArray *)bigArray{
    if (!_bigArray) {
        _bigArray = [NSMutableArray array];
    }
    return _bigArray;
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)TingListArr{
    if (!_TingListArr) {
        _TingListArr = [NSMutableArray array];
    }
    return _TingListArr;
}

-(NSMutableArray *)bigTingDanArr{
    if (!_bigTingDanArr) {
        _bigTingDanArr = [NSMutableArray array];
    }
    return _bigTingDanArr;
}

-(NSMutableArray *)TingListURLArr{
    if (!_TingListURLArr) {
        _TingListURLArr = [NSMutableArray arrayWithObjects:KShanghaiURL,KMustListenURL,KBuyGoodURL, nil];
    }
    return _TingListURLArr;
}

-(NSMutableArray *)ListNameArr{
    if (!_ListNameArr) {
        _ListNameArr = [NSMutableArray array];
    }
    return _ListNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 点击状态栏，回到顶部。
    [TopWindow show];
    self.controllers = [@[ @"CategoryViewController", @"BroadcastViewController",@"RankViewController"] mutableCopy];
    // 添加搜索按钮。
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(kScreenWidth - 30, 35, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_search_n@3x"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationController.view addSubview:btn];
    
    [self creatScr];
    [self creatSeg];
    [self creatLine];
    [self creatCarouse];
    [self creatBigArray];
    [self creatTitleArray];
    [self creatTable];
    [self creatdownCarouse];
    [self creatBottomPic];
    
    self.anchor = [AnchorTableViewController shareManager];
    [self.anchor creatTableView:CGRectMake(4 * kScreenWidth, 0, kScreenWidth, kScreenHeight - 64 - 60)];
    [self addChildViewController:self.anchor];
    [self.scr addSubview:self.anchor.table];
    self.cellArray = [NSMutableArray array];
    
        //焦点图数据请求
    [RequestManager requestWithUrlString:KfocusImagesURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.cellArray = [focusImagesModel editorRecommendAlbums:dic];
        [self.tableView reloadData];
        } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];

    [RequestManager requestWithUrlString:KfocusImagesURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.specialColumnArray = [focusImagesModel specialColumn:dic];
        [self.tableView reloadData];
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 40)];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.text = @"珠穆朗玛FM";
    [self.navigationController.view addSubview:self.titleLabel];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
    
}

#pragma mark ----- 良品数据请求 -----
-(void)creatBottomPic
{
    self.bottomPicArray = [NSMutableArray array];
    [RequestManager requestWithUrlString:KwebViewURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.bigBottomPicArray = [WEBModel webWith:dic];
        for (WEBModel *model in self.bigBottomPicArray) {
            [self.bottomPicArray addObject:model.cover];
        }
        self.bottomPic = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80) imageURLs:self.bottomPicArray];
        __block DiscoverViewController *dis = self;
        
        NSMutableArray *array = self.bigBottomPicArray;
        self.bottomPic.imageClick = ^(NSInteger index)
        {
            WEBModel *model = array[index];
            DiscoverWebViewController *discover = [[DiscoverWebViewController alloc]init];
            discover.webURL = model.link;
            
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:discover];
            dis.tabBarController.tabBar.hidden = YES;
         [dis presentViewController:navc animated:YES completion:nil];
        };
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
}



#pragma mark ----- 创建广播视图 -----
-(BroadcastViewController *)broadVC{
    if (!_broadVC) {
        _broadVC = [[BroadcastViewController alloc]init];
        _broadVC.view.frame = CGRectMake(0, 0, kScreenWidth, self.scr.height);
    }
    return _broadVC;
}

-(void)creatTitleArray
{
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.titleArray = [hotRecommendsModel title:dic];
        
        [self.tableView reloadData];
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}

#pragma mark ----- 数据请求——多条听单 -----
-(void)creatBigArray;
{
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.bigArray = [hotRecommendsModel hotRecommends:dic];
//        NSLog(@"%@",self.bigArray);
        for (NSArray *arr in self.bigArray) {
            NSInteger aa = 0;
            for (hotRecommendsModel *model in arr) {
                if (aa == 0) {
                  [self.bigTingDanArr addObject:model.categoryId];
                }
                aa++;
            }
        }
        [self.tableView reloadData];
        //NSLog(@"+++++++++%@ %ld",self.bigArray,self.bigArray.count);
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}




-(void)creatCarouse//最上面轮播图
{
    [RequestManager requestWithUrlString:KfocusImagesURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.focusImages = [focusImagesModel focusImages:dic];
        NSMutableArray *picArray = [NSMutableArray array];
        for (focusImagesModel *model in self.focusImages) {
            [picArray addObject:model.pic];
        }
        self.car = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150) imageURLs:picArray];
            [self.tableView reloadData];
        
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];

}


-(void)creatdownCarouse//轮播图下面
{
    CGFloat f = (kScreenWidth - 150) / 4;
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic1 = dic[@"discoveryColumns"];
        NSArray *list = dic1[@"list"];
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.tag = i + 1;
            btn.frame = CGRectMake(2 * 20 * i + f * i, 160, f, f + 20);
            [btn addTarget:self action:@selector(tingAction:) forControlEvents:(UIControlEventTouchUpInside)];
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, f, f)];
            NSDictionary *dic2 = list[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:dic2[@"coverPath"]]];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, f , f+20, 20)];
            label.text = dic2[@"title"];
            [self.TingListArr addObject:dic2[@"title"]];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:imageV];
            [btn addSubview:label];
            [self.tableView addSubview:btn];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark ----- 听XXX方法 -----
-(void)tingAction:(UIButton *)btn
{
    CategoryListViewController *cateVC = [[CategoryListViewController alloc]init];
    cateVC.titleStr = self.TingListArr[btn.tag - 1];
    if (btn.tag == 1) {
        AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
        album.url = @"3985798";
        album.inter = 4;
        [self.navigationController pushViewController:album animated:YES];
    }else if (btn.tag == 2){
        cateVC.URLLStr = self.TingListURLArr[btn.tag-2];
        [self.navigationController pushViewController:cateVC animated:YES];
    }else if (btn.tag == 3){
        cateVC.URLLStr = self.TingListURLArr[btn.tag-2];
        [self.navigationController pushViewController:cateVC animated:YES];
    }else if (btn.tag == 4){
        cateVC.URLLStr = self.TingListURLArr[btn.tag-2];
        [self.navigationController pushViewController:cateVC animated:YES];
    }
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark ----creatseg---
-(void)creatSeg
{
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"推荐",@"分类",@"广播",@"榜单",@"主播"]];
    self.seg.frame = CGRectMake(0, 0, kScreenWidth, 20);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    self.seg.tintColor = [UIColor clearColor];
    [self.seg setTitleTextAttributes:dic forState:(UIControlStateSelected)];
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.seg setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
    self.seg.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.seg];
}

#pragma mark ---line---
-(void)creatLine
{
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 19, kScreenWidth / 5, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.seg addSubview:self.lineView];
}

#pragma mark --- segAction
-(void)segAction
{
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.seg.selectedSegmentIndex * (kScreenWidth / 5);
    self.lineView.frame = frame;
    CGPoint x = CGPointMake(self.seg.selectedSegmentIndex * (kScreenWidth), 0);
    self.scr.contentOffset = x;
}

#pragma mark --- creatScr
-(void)creatScr
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20 , kScreenWidth, kScreenHeight - (self.seg.bounds.size.height + 20))];
    self.scr.contentSize = CGSizeMake(5 * kScreenWidth, 0);
    self.scr.delegate = self;
    self.scr.bounces = NO;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.pagingEnabled = YES;
    for (NSInteger i = 0; i < 4; i++) {
        if (i == 0) {
            
        }  else {
            self.subVC = [[NSClassFromString(self.controllers[i-1]) alloc]init];
            self.subVC.view.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight);
            [self addChildViewController:self.subVC];
            [self.scr addSubview:self.subVC.view];
        }
    }
    [self.view addSubview:self.scr];
    [self.view addSubview:self.scr];
}

#pragma mark --- scr代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.seg.selectedSegmentIndex = self.scr.contentOffset.x/kScreenWidth;
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.seg.selectedSegmentIndex * (kScreenWidth / 5);
    self.lineView.frame = frame;
}

-(void)creatTable
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.scr.frame.size.height - self.tabBarController.tabBar.frame.size.height - 50) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.scr addSubview:self.tableView];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
            }
        [cell.contentView addSubview:self.car];
        return cell;
    }else  if (indexPath.section == 1){
        editorRecommendAlbumsTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell1) {
            cell1 = [[editorRecommendAlbumsTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
            }
        [cell1 creatCell:self.cellArray];
        cell1.disc.imageClick = ^(NSInteger inter)
        {
            AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
                        focusImagesModel *model = self.cellArray[inter];
                    album.url = model.albumId;
            album.inter = 4;
            self.tabBarController.tabBar.hidden = YES;
[self.navigationController pushViewController:album animated:YES];
        };
        [cell1.more1Btn setTitle:@"小编推荐" forState:(UIControlStateNormal)];
        [cell1.more1Btn addTarget:self action:@selector(recommendMoreAction) forControlEvents:(UIControlEventTouchUpInside)];
        [cell1.more2Btn addTarget:self action:@selector(recommendMoreAction) forControlEvents:(UIControlEventTouchUpInside)];
        return cell1;
    }else if (indexPath.section == 2) {
        specialTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"ssss"];
        if (!cell2) {
            cell2 = [[specialTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ssss"];
        }
        focusImagesModel *model = self.specialColumnArray[indexPath.row];
        [cell2 creatSpecialCell:model];
        return cell2;
    }else if(indexPath.section == self.bigArray.count + 3){
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (!cell3) {
            cell3 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"aa"];
        }
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = CGRectMake(10, 0, kScreenWidth / 2 - 10, 40);
        [btn setTitle:@"查看更多分类" forState:(UIControlStateNormal)];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn1.frame = CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2 - 10, 40);
        [btn1 setTitle:@">" forState:(UIControlStateNormal)];
        [btn setTintColor:[UIColor grayColor]];
        [btn1 setTintColor:[UIColor grayColor]];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [cell3.contentView addSubview:btn1];
        [cell3.contentView addSubview:btn];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [btn1 addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        return cell3;
    }else if (indexPath.section == self.bigArray.count + 4){
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"aaa"];
        }
        [cell4.contentView addSubview:self.bottomPic];
        return cell4;
    }else{
        editorRecommendAlbumsTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"sssss"];
        if (!cell5) {
            cell5 = [[editorRecommendAlbumsTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sssss"];
        }
        NSMutableArray *muarr = [NSMutableArray array];
        muarr = self.bigArray[indexPath.section - 3];

        hotRecommendsModel *model = self.titleArray[indexPath.section - 3];
        [cell5.more1Btn setTitle:model.title forState:(UIControlStateNormal)];
        cell5.more1Btn.tag = indexPath.section;
        cell5.more2Btn.tag = indexPath.section;
        [self.ListNameArr addObject:model.title];
        [cell5.more1Btn addTarget:self action:@selector(cell5moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell5.more2Btn addTarget:self action:@selector(cell5moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell5 creatCell:muarr];
        cell5.disc.imageClick = ^(NSInteger inter){
            hotRecommendsModel *model = muarr[inter];
            AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
            album.url = model.albumId;
            if (indexPath.section == 3) {
                album.inter = inter;
            }else{
                album.inter = 4;
            }
            self.tabBarController.tabBar.hidden = YES;

            [self.navigationController pushViewController:album animated:YES];
        };
        return cell5;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }else{
    return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return self.bigArray.count + 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.bigArray.count + 4) {
        return 80;
    }
    if (indexPath.section == self.bigArray.count + 3) {
        return 40;
    }
    if (indexPath.section == 1) {
        return (kScreenWidth - 40) / 3 + 90 + 40;
    }if (indexPath.section == 2) {
        return 110;
    }else{
        return 240;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UIButton *more1Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    more1Btn.frame = CGRectMake(5, 0, (kScreenWidth - 10) / 2, 40);
    UIButton *more2Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [more1Btn setTitle:@"精品听单" forState:(UIControlStateNormal)];
    more2Btn.frame = CGRectMake((kScreenWidth - 10) / 2 + 5, 0, (kScreenWidth - 10) / 2, 40);
    more2Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [more2Btn setTitle:@"更多 >" forState:(UIControlStateNormal)];
    [more1Btn addTarget:self action:@selector(turnToQualityGoodsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [more2Btn addTarget:self action:@selector(turnToQualityGoodsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    more2Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    more1Btn.tintColor = [UIColor blackColor];
    more2Btn.tintColor = [UIColor grayColor];
    more1Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [view1 addSubview:more1Btn];
    [view1 addSubview:more2Btn];
    
    return view1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        focusImagesModel *model = self.specialColumnArray[indexPath.row];
        ListenDetailViewController *listen = [[ListenDetailViewController alloc]init];
        listen.listenTitle = model.title;
        listen.type = model.contentType;
        listen.listenId = model.specialId;
        self.tabBarController.tabBar.hidden = YES;

        [self.navigationController pushViewController:listen animated:YES];
    }
}

#pragma mark --- button 方法
-(void)btnAction
{
    self.seg.selectedSegmentIndex = 1;
    CGPoint point = CGPointMake(kScreenWidth, 0);
    self.scr.contentOffset = point;
}

-(void)recommendMoreAction
{
    recommendMoreViewController *recommend = [[recommendMoreViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;

[self.navigationController pushViewController:recommend animated:YES];
}


-(void)cell5moreAction:(UIButton *)button
{
   CategoryListViewController *cateVC = [[CategoryListViewController alloc]init];
    NSString *str = KBuyGoodURL;
    str = [str stringByReplacingOccurrencesOfString:@"categoryId=33" withString:[NSString stringWithFormat:@"categoryId=%@",self.bigTingDanArr[button.tag -3]]];
    cateVC.URLLStr = str;
    cateVC.idd = [self.bigTingDanArr[button.tag -3] integerValue];
    cateVC.titleStr = self.ListNameArr[button.tag -3];
    [self.navigationController pushViewController:cateVC animated:YES];
}


-(void)turnToQualityGoodsAction:(UIButton *)btn
{
    qualityGoodsTableViewController *quality = [[qualityGoodsTableViewController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:quality animated:YES];
}

// 进入搜索页面
- (void)searchAction:(UIButton *)btn {
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:searchVC];
    [self presentViewController:na animated:YES completion:nil];
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

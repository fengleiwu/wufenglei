//
//  DiscoverViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverViewController.h"
#import "BroadcastViewController.h"
#import "CarouselView.h"
#import "focusImagesModel.h"
#import "editorRecommendAlbumsTableViewCell.h"
#import "DiscoverCollectView.h"
#import "specialView.h"
#import "hotRecommendsModel.h"
#import "WEBModel.h"
#import "DiscoverWebViewController.h"
@interface DiscoverViewController ()<UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)UISegmentedControl *seg;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)NSMutableArray *focusImages;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)CarouselView *car;
@property (nonatomic , strong)NSMutableArray *cellArray;//小便推荐
@property (nonatomic , strong)NSMutableArray *specialColumnArray;//精品停单
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic, strong)BroadcastViewController *broadVC;
@property (nonatomic , strong)DiscoverCollectView *discell;
@property (nonatomic , strong)specialView *special;
@property (nonatomic , strong)NSMutableArray *bigArray;//一样的东西
@property (nonatomic , strong)NSMutableArray *titleArray;
@property (nonatomic , strong)NSMutableArray *bottomPicArray;
@property (nonatomic , strong)NSMutableArray *bigBottomPicArray;
@property (nonatomic , strong)CarouselView *bottomPic;
@property (nonatomic , strong)UILabel *titleLabel;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 40)];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.text = @"珠穆朗玛FM";
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.view addSubview:self.titleLabel];
    [self creatdiscell];
    [self creatScr];
    [self creatSeg];
    [self creatLine];
    [self creatCarouse];
    [self creatBigArray];
    [self creatTitleArray];
    [self creatTable];
    [self creatdownCarouse];
    [self creatBottomPic];
}



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
        _broadVC.view.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, self.scr.height);
    }
    return _broadVC;
}

-(void)creatTitleArray
{
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.titleArray = [hotRecommendsModel title:dic];
        
        NSLog(@"%@",self.titleArray);
        [self.tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)creatBigArray;
{
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.bigArray = [hotRecommendsModel hotRecommends:dic];
        [self.tableView reloadData];
        //NSLog(@"+++++++++%@ %ld",self.bigArray,self.bigArray.count);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)creatdiscell  //小编推荐
{
    self.cellArray = [NSMutableArray array];
    [RequestManager requestWithUrlString:KfocusImagesURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.cellArray = [focusImagesModel editorRecommendAlbums:dic];
        self.discell = [[DiscoverCollectView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth,(kScreenWidth - 40) / 3 + 90) imageURLs:self.cellArray];
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}



-(void)creatCarouse//轮播图
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
        NSLog(@"%@",error);
    }];

}


-(void)creatdownCarouse
{
    CGFloat f = (kScreenWidth - 160) / 4;
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic1 = dic[@"discoveryColumns"];
        NSArray *list = dic1[@"list"];
        for (int i = 0; i < 4; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20 + 2 * 20 * i + f * i, 160, f, f)];
            NSDictionary *dic2 = list[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:dic2[@"coverPath"]]];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20 + 2 * 20 * i + f * i, f + 160 , f, 20)];
            label.text = dic2[@"title"];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            [self.tableView addSubview:imageV];
            [self.tableView addSubview:label];
        }
    } error:^(NSError *error) {
        
    }];
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
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.seg.bounds.size.height + 20 , kScreenWidth, kScreenHeight - (self.seg.bounds.size.height + 20))];
    self.scr.contentSize = CGSizeMake(5 * kScreenWidth, 0);
    self.scr.delegate = self;
    self.scr.bounces = NO;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.pagingEnabled = YES;
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - self.tabBarController.tabBar.frame.size.height - 30) style:(UITableViewStylePlain)];
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
        editorRecommendAlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[editorRecommendAlbumsTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
            
        }
        [cell.contentView addSubview:self.discell];
        [cell.more1Btn setTitle:@"小编推荐" forState:(UIControlStateNormal)];
        
        return cell;
    }else if (indexPath.section == 2) {
        editorRecommendAlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ssss"];
        if (!cell) {
            cell = [[editorRecommendAlbumsTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ssss"];
        }
        [RequestManager requestWithUrlString:KfocusImagesURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.specialColumnArray = [focusImagesModel specialColumn:dic];
            for (int i = 0; i < self.specialColumnArray.count; i++) {
                focusImagesModel *model = self.specialColumnArray[i];
                specialView *special = [[specialView alloc]initWithFrame:CGRectMake(0, 40 + 110 * i, kScreenWidth, 110) model:model];
                [cell.contentView addSubview:special];
                [self.tableView reloadData];
            }
            [cell.more1Btn setTitle:dic[@"specialColumn"][@"title"] forState:(UIControlStateNormal)];
        } error:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        return cell;
    }else if(indexPath.section == self.bigArray.count + 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"aa"];
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
        [cell.contentView addSubview:btn1];
        [cell.contentView addSubview:btn];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [btn1 addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }else if (indexPath.section == self.bigArray.count + 4){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"aaa"];
        }
        [cell.contentView addSubview:self.bottomPic];
        return cell;
    }else{
        editorRecommendAlbumsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sssss"];
        if (!cell) {
            cell = [[editorRecommendAlbumsTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sssss"];
        }
        NSMutableArray *muarr = [NSMutableArray array];
        muarr = self.bigArray[indexPath.section - 3];
        DiscoverCollectView *dis = [[DiscoverCollectView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth,(kScreenWidth - 40) / 3 + 90) imageURLs:muarr];
        hotRecommendsModel *model = self.titleArray[indexPath.section - 3];
        [cell.more1Btn setTitle:model.title forState:(UIControlStateNormal)];
        [cell.contentView addSubview:dis];
        return cell;
    }
    
    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
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
        return 260;
    }else{
        return 250;
    }
    
    
}


-(void)btnAction
{
    self.seg.selectedSegmentIndex = 1;
    CGPoint point = CGPointMake(kScreenWidth, 0);
    self.scr.contentOffset = point;
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

//
//  DiscoverViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DiscoverViewController.h"
#import "CarouselView.h"
#import "focusImagesModel.h"
@interface DiscoverViewController ()<UIScrollViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)UISegmentedControl *seg;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)NSMutableArray *focusImages;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)CarouselView *car;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 40)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"珠穆朗玛FM";
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.view addSubview:titleLabel];
    [self creatScr];
    [self creatSeg];
    [self creatLine];
    [self creatCarouse];
    [self creatTable];
    
    
    // Do any additional setup after loading the view.
}

-(void)creatCarouse
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.scr addSubview:self.tableView];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
    }
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.car];
    }
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 250;
    }else{
        return 150;
    }
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

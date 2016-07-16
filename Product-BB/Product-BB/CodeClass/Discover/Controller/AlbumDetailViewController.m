//
//  AlbumDetailViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//


//专辑详情页

#import "AlbumDetailViewController.h"
#import "AlbumDetailModel.h"
#import "AlbumDetailTableViewCell.h"
#import "VeryBigTabView.h"
#import "AdjustHeight.h"
#import "ContentTableViewCell.h"
#import "hotRecommendsModel.h"
#import "DetailPayModel.h"
#import "MoreDetailTableViewController.h"
#import "ContentIntroductTableViewCell.h"
@interface AlbumDetailViewController ()<UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate>
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)AlbumDetailModel *albumModel;
@property (nonatomic , strong)NSMutableArray *tracksArr;
@property (nonatomic , strong)AlbumDetailModel *userModel;
@property (nonatomic , strong)UIView *tabViewHeadView;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)VeryBigTabView *veryBigTab;
@property (nonatomic , strong)UITableView *detailTableView;
@property (nonatomic , strong)NSMutableArray *bigArray;
@property (nonatomic , strong)DetailPayModel *contectModel;
@property (nonatomic , assign)BOOL isPay;
@property (nonatomic , strong)DetailPayModel *introduceModel;
@property (nonatomic , strong)NSMutableArray *pinglunArray;
//@property (nonatomic , strong)UITextView *contentView;
//@property (nonatomic , strong)UILabel *contentLabel;

@end

@implementation AlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"专辑详情";
    [self creatVeryBigTabview];
    if (self.inter <= 2 && self.inter >= 0) {
        self.isPay = YES;
        NSString *url = @"http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=4345263&device=iPhone&statEvent=pageview%2Falbum%404345263&statModule=%E4%BB%98%E8%B4%B9%E7%B2%BE%E5%93%81&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1";
        NSString *detailUrl = [url stringByReplacingOccurrencesOfString:@"albumId=4345263" withString:[NSString stringWithFormat:@"albumId=%@",self.url]];
        NSLog(@"************%@",url);
        [RequestManager requestWithUrlString:detailUrl requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.contectModel = [DetailPayModel detail:dic];
            self.introduceModel = [DetailPayModel user:dic];
            self.pinglunArray = [DetailPayModel list:dic];
            [self.tab reloadData];
            [self.detailTableView reloadData];
        } error:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        self.isPay = NO;
    }
    if (self.inter <= 2 && self.inter >= 0) {
        [self creatPayTableView];
    }else{
    [self creatTabView];
    }
    [self creatDetailTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startScroll) name:@"haha" object:nil];
    
    
}



-(void)creatVeryBigTabview
{
    self.veryBigTab = [[VeryBigTabView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 44)];
    self.veryBigTab.scr.delegate = self;
    [self.view addSubview:self.veryBigTab.table];
}

-(void)creatPayTableView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 64 - 44 - 50) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 110;
    self.tab.scrollEnabled = NO;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 150)];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 5, kScreenWidth - 130, 40)];
    nameLabel.font = [UIFont systemFontOfSize:15];
    UILabel *smallNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 45, kScreenWidth - 130, 20)];
    smallNameLabel.font = [UIFont systemFontOfSize:12];
    UILabel *playLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 65, kScreenWidth - 130, 20)];
    
    playLabel.font = [UIFont systemFontOfSize:12];
    UILabel *pingfenLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 85, kScreenWidth - 130, 20)];
    pingfenLabel.font = [UIFont systemFontOfSize:12];
    UILabel *state = [[UILabel alloc]initWithFrame:CGRectMake(120, 105, kScreenWidth - 130, 20)];
    state.font = [UIFont systemFontOfSize:12];
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 125, kScreenWidth - 130, 20)];
    priceLabel.font = [UIFont systemFontOfSize:12];
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn1.frame = CGRectMake(10, 120 + 50, (kScreenWidth - 30) / 2, 30);
    [btn1 setTitle:@"订阅专辑" forState:(UIControlStateNormal)];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1.layer setMasksToBounds:YES];
    [btn1.layer setCornerRadius:5];
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn2.frame = CGRectMake((kScreenWidth - 30) / 2 + 10 + 10, 120 + 50, (kScreenWidth - 30) / 2, 30);
    [btn2 setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    [btn2.layer setMasksToBounds:YES];
    [btn2.layer setBorderWidth:1];
    [btn2.layer setCornerRadius:5];
    [btn2.layer setBorderColor:[UIColor greenColor].CGColor];
    self.tabViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    [self.tabViewHeadView addSubview:imageV];
    [self.tabViewHeadView addSubview:nameLabel];
    [self.tabViewHeadView addSubview:smallNameLabel];
    [self.tabViewHeadView addSubview:playLabel];
    [self.tabViewHeadView addSubview:btn2];
    [self.tabViewHeadView addSubview:btn1];
    [self.tabViewHeadView addSubview:pingfenLabel];
    [self.tabViewHeadView addSubview:state];
    [self.tabViewHeadView addSubview:priceLabel];
    self.veryBigTab.table.tableHeaderView = self.tabViewHeadView;
    [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.bigArray = [hotRecommendsModel hotRecommends:dic];
        NSArray *arr = self.bigArray[0];
        hotRecommendsModel *model = arr[self.inter];
        nameLabel.text = model.title;
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.coverMiddle]];
        smallNameLabel.text = [NSString stringWithFormat:@"主播:%@",model.nickname];
        CGFloat f = [model.playsCounts floatValue] / 10000;
        if (f > 10000) {
            NSString *st = [NSString stringWithFormat:@"播放:%.1f亿次",f / 1000];
            playLabel.text = st;
        }else
        {
            NSString *st = [NSString stringWithFormat:@"播放:%.1f万次",f];
            playLabel.text = st;
        }
        pingfenLabel.text = [NSString stringWithFormat:@"评分:%@分",model.score];
        state.text = [NSString stringWithFormat:@"状态:已更新%@集",model.tracks];
        priceLabel.text = [NSString stringWithFormat:@"价格:%@",model.displayDiscountedPrice];
        [self.tab reloadData];
        //NSLog(@"+++++++++%@ %ld",self.bigArray,self.bigArray.count);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    NSString *actionUrl = @"http://mobile.ximalaya.com/mobile/v1/album/track?albumId=4345263&device=iPhone&isAsc=true&pageId=1&pageSize=20&statEvent=pageview%2Falbum%404345263&statModule=%E4%BB%98%E8%B4%B9%E7%B2%BE%E5%93%81&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1";
    actionUrl = [actionUrl stringByReplacingOccurrencesOfString:@"albumId=4345263" withString:[NSString stringWithFormat:@"albumId=%@",self.url]];
    [RequestManager requestWithUrlString:actionUrl requestType:RequestGET parDic:0 finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.tracksArr = [AlbumDetailModel payArray:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
[self.veryBigTab.scr addSubview:self.tab];

}


-(void)creatTabView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 64 - 44 - 50) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 110;
    self.tab.scrollEnabled = NO;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, kScreenWidth - 130, 40)];
    nameLabel.font = [UIFont systemFontOfSize:15];
    UILabel *smallNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, kScreenWidth - 130, 20)];
    smallNameLabel.font = [UIFont systemFontOfSize:12];
    UILabel *playLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 80, kScreenWidth - 130, 20)];
    playLabel.font = [UIFont systemFontOfSize:12];
   UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn1.frame = CGRectMake(10, 120, (kScreenWidth - 30) / 2, 30);
    [btn1 setTitle:@"订阅专辑" forState:(UIControlStateNormal)];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1.layer setMasksToBounds:YES];
    [btn1.layer setCornerRadius:5];
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn2.frame = CGRectMake((kScreenWidth - 30) / 2 + 10 + 10, 120, (kScreenWidth - 30) / 2, 30);
    [btn2 setTitle:@"批量下载" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    [btn2.layer setMasksToBounds:YES];
    [btn2.layer setBorderWidth:1];
    [btn2.layer setCornerRadius:5];
    [btn2.layer setBorderColor:[UIColor greenColor].CGColor];
    self.tabViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    [self.tabViewHeadView addSubview:imageV];
    [self.tabViewHeadView addSubview:nameLabel];
    [self.tabViewHeadView addSubview:smallNameLabel];
    [self.tabViewHeadView addSubview:playLabel];
    [self.tabViewHeadView addSubview:btn2];
    [self.tabViewHeadView addSubview:btn1];
    self.veryBigTab.table.tableHeaderView = self.tabViewHeadView;
    NSString *URL = @"http://mobile.ximalaya.com/mobile/v1/album?albumId=308981&device=iPhone&pageSize=20&source=5&statEvent=pageview%2Falbum%40266276&statModule=%E5%B0%8F%E7%BC%96%E6%8E%A8%E8%8D%90&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1&trackId=18143253";
    URL = [URL stringByReplacingOccurrencesOfString:@"albumId=308981" withString:[NSString stringWithFormat:@"albumId=%@",self.url]];
    [RequestManager requestWithUrlString:URL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.albumModel = [AlbumDetailModel album:dic];
        self.tracksArr = [AlbumDetailModel tracks:dic];
        self.userModel = [AlbumDetailModel user:dic];
        nameLabel.text = self.albumModel.title;
        CGFloat f = [self.albumModel.playTimes floatValue] / 10000;
        if (f > 10000) {
            NSString *st = [NSString stringWithFormat:@"播放:%.1f亿次",f / 1000];
            playLabel.text = st;
        }else
        {
            NSString *st = [NSString stringWithFormat:@"播放:%.1f万次",f];
            playLabel.text = st;
        }
        smallNameLabel.text = [NSString stringWithFormat:@"主播:%@",self.albumModel.nickname];
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.albumModel.coverMiddle]];
   
        [self.tab reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
  [self.veryBigTab.scr addSubview:self.tab];
}


-(void)creatDetailTableView
{
    self.detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 44 - 50) style:(UITableViewStylePlain)];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.scrollEnabled = NO;
//    self.detailTableView.rowHeight = 270;
    [self.veryBigTab.scr addSubview:self.detailTableView];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tab.contentOffset.y <= 0) {
        self.tab.scrollEnabled = NO;
    }if (self.detailTableView.contentOffset.y <= 0) {
        self.detailTableView.scrollEnabled = NO;
        
    }
    
    self.veryBigTab.seg.selectedSegmentIndex = self.veryBigTab.scr.contentOffset.x / kScreenWidth;
    CGRect frame = self.veryBigTab.lineView.frame;
    frame.origin.x = kScreenWidth / 2 * self.veryBigTab.scr.contentOffset.x / kScreenWidth;
    self.veryBigTab.lineView.frame = frame;
    if (self.veryBigTab.seg.selectedSegmentIndex == 0) {
        [self.detailTableView reloadData];
    }else{
    [self.tab reloadData];
    }
}
- (void)startScroll{
    self.tab.scrollEnabled = YES;
    self.detailTableView.scrollEnabled = YES;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isPay == YES && self.veryBigTab.seg.selectedSegmentIndex == 0 && section == 2 ) {
        return 3;
        
    }if (self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 1;
    }
    else{
    return self.tracksArr.count;
    }
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.veryBigTab.seg.selectedSegmentIndex == 0) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[ContentTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
        }
        if (self.isPay == NO) {
            [cell creatCell:self.url];
        }else{
            if (indexPath.section == 0) {
                [cell creatPayCell:self.contectModel];
            }else if (indexPath.section == 1){
                ContentIntroductTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"aa"];
                if (!cell1) {
                    cell1 = [[ContentIntroductTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"aa"];
                    }
                [cell1 creatPayCell:self.introduceModel];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell1;
            } else if (indexPath.section == 2) {
                ContentIntroductTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
                if (!cell2) {
                    cell2 = [[ContentIntroductTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"aaa"];
                }
                DetailPayModel *model = self.pinglunArray[indexPath.row];
                [cell2 creatPinglun:model];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell2;
            }
        }
        [cell.moreBtn addTarget:self action:@selector(MoreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    AlbumDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[AlbumDetailTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    AlbumDetailModel *model = self.tracksArr[indexPath.row];
    [cell creatCell:model];
     if (model.isPlay == YES) {
            CGRect frame = cell.bigLabel.frame;
          frame = CGRectMake(135, 15, kScreenWidth - 40 - 140, 50);
            cell.bigLabel.frame = frame;
                 cell.activityView = [[MusicActivityView alloc]initWithFrame:CGRectMake(100, 15, 30, 30)];
                 cell.activityView.numberOfRect = 4;
                 cell.activityView.rectBackgroundColor = [UIColor orangeColor];
                 cell.activityView.defaultSize = cell.activityView.frame.size;
                 cell.activityView.space = 2;
         [cell.activityView startAnimation];
            [cell.contentView addSubview:cell.activityView];

        }else{
            cell.activityView.frame = CGRectMake(100, 15, 40, 40);
            CGRect frame = cell.bigLabel.frame;
            frame = CGRectMake(100, 15, kScreenWidth - 40 - 100, 50);
            cell.bigLabel.frame = frame;
            [cell.activityView stopAnimation];
        }
    return cell;
    }
}



-(void)MoreAction:(UIButton *)btn
{
    ContentTableViewCell *cell = (ContentTableViewCell *)btn.superview.superview;
    
    MoreDetailTableViewController *more = [[MoreDetailTableViewController alloc]init];
    more.text = cell.contentTextView.text;
    [self.navigationController pushViewController:more animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.isPay == YES && self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 3;
    }else{
    return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPay == YES && indexPath.section == 1 && self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 180;
    }if (self.isPay == YES && indexPath.section == 0 && self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 200;
    }if (self.isPay == YES && indexPath.section == 2 && self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 150;
    }if (self.veryBigTab.seg.selectedSegmentIndex == 0) {
        return 200;
    }else  {
        return 110;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isPay == YES && self.veryBigTab.seg.selectedSegmentIndex == 0 && section == 2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        label.text = @"精彩评论";
        label.textAlignment = NSTextAlignmentLeft;
        return label;
    }else{
        return nil;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isPay == YES && self.veryBigTab.seg.selectedSegmentIndex == 0 && section == 2) {
        
        return 40;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (AlbumDetailModel *model in self.tracksArr) {
        model.isPlay = NO;
    }
    
    AlbumDetailModel *model = self.tracksArr[indexPath.row];
    model.isPlay = YES;
    [self.tab reloadData];
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

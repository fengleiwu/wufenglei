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
#import "attentionModel.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"
#import "DownLoadViewController.h"
#import "DBManager.h"
#import "MyDownLoad.h"
#import "MyMusicDownLoadTable.h"
#import "MyDownLoadManager.h"
#import "batchDownViewController.h"
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
@property (nonatomic , strong)NSMutableArray *downLoadArray;
@property (nonatomic , assign)BOOL isFirstDownLoad;

@property (nonatomic , strong)hotRecommendsModel *hotRecommendsModel;

@property (nonatomic , strong)attentionModel *attentionModel;

@property (nonatomic , assign)BOOL isDingYue;

@property (nonatomic , strong)NSMutableArray *isDingYueArr;

//@property (nonatomic , strong)UITextView *contentView;
//@property (nonatomic , strong)UILabel *contentLabel;

@end

@implementation AlbumDetailViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.downLoadArray = [NSMutableArray array];
    self.title = @"专辑详情";
    [self creatVeryBigTabview];
    if (self.inter <= 2 && self.inter >= 0) {
        self.isPay = YES;
        NSString *url = @"http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=4345263&device=iPhone&statEvent=pageview%2Falbum%404345263&statModule=%E4%BB%98%E8%B4%B9%E7%B2%BE%E5%93%81&statPage=tab%40%E5%8F%91%E7%8E%B0_%E6%8E%A8%E8%8D%90&statPosition=1";
        NSString *detailUrl = [url stringByReplacingOccurrencesOfString:@"albumId=4345263" withString:[NSString stringWithFormat:@"albumId=%@",self.url]];
        [RequestManager requestWithUrlString:detailUrl requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.contectModel = [DetailPayModel detail:dic];
            self.introduceModel = [DetailPayModel user:dic];
            self.pinglunArray = [DetailPayModel list:dic];
            [self.tab reloadData];
            [self.detailTableView reloadData];
        } error:^(NSError *error) {
//            NSLog(@"%@",error);
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
    [btn1 addTarget:self action:@selector(dingyueAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    self.url = [NSString stringWithFormat:@"%@",self.url];
MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.isDingYueArr = [[table selectAllInDingyue]mutableCopy];
    for (NSArray *arr in self.isDingYueArr) {
        if ([arr containsObject:self.url]) {
            [btn1 setTitle:@"已订阅" forState:(UIControlStateNormal)];
            [btn1 setBackgroundColor:[UIColor grayColor]];
            self.isDingYue = YES;
            break;
        }else{
            self.isDingYue = NO;
        }
    }

    
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
    
   if (self.isPaid == NO) {
        [RequestManager requestWithUrlString:KtheSameURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.bigArray = [hotRecommendsModel hotRecommends:dic];
            NSArray *arr = self.bigArray[0];
            self.hotRecommendsModel = arr[self.inter];
            nameLabel.text = self.hotRecommendsModel.title;
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.hotRecommendsModel.coverMiddle]];
            smallNameLabel.text = [NSString stringWithFormat:@"主播:%@",self.hotRecommendsModel.nickname];
            CGFloat f = [self.hotRecommendsModel.playsCounts floatValue] / 10000;
            if (f > 10000) {
                NSString *st = [NSString stringWithFormat:@"播放:%.1f亿次",f / 1000];
                playLabel.text = st;
            }if (f <= 10000 && f >= 1) {
                NSString *st = [NSString stringWithFormat:@"播放:%.1f万次",f];
                playLabel.text = st;
                
            }else{
                playLabel.text = [NSString stringWithFormat:@"播放:%@次",self.hotRecommendsModel.playsCounts];
            }
            pingfenLabel.text = [NSString stringWithFormat:@"评分:%@分",self.hotRecommendsModel.score];
            state.text = [NSString stringWithFormat:@"状态:已更新%@集",self.hotRecommendsModel.tracks];
            priceLabel.text = [NSString stringWithFormat:@"价格:%@",self.hotRecommendsModel.displayPrice];
            [self.tab reloadData];
        } error:^(NSError *error) {
//            NSLog(@"%@",error);
        }];
    }else{
        
        NSString *url = @"http://mobile.ximalaya.com/mobile/v1/artist/albums?device=iPhone&pageId=1&pageSize=2&statEvent=pageview%2Fuserlist%40%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96&statModule=%E6%98%8E%E6%98%9F%E5%A4%A7%E5%92%96_%E6%9B%B4%E5%A4%9A&statPage=tab%40%E5%8F%91%E7%8E%B0_%E4%B8%BB%E6%92%AD&statPosition=1&toUid=54060615";
        
        url = [url stringByReplacingOccurrencesOfString:@"Uid=54060615" withString:[NSString stringWithFormat:@"Uid=%@",self.uid]];
        [RequestManager requestWithUrlString:url requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.bigArray = [attentionModel price:dic];
            self.attentionModel = self.bigArray[self.row];
            nameLabel.text = self.attentionModel.title;
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.attentionModel.coverLarge]];
            smallNameLabel.text = [NSString stringWithFormat:@"主播:%@",self.nickName];
            CGFloat f = [self.attentionModel.playTimes floatValue] / 10000;
            if (f > 10000) {
                NSString *st = [NSString stringWithFormat:@"播放:%.1f亿次",f / 1000];
                playLabel.text = st;
            }if (f <= 10000 && f >= 1) {
                NSString *st = [NSString stringWithFormat:@"播放:%.1f万次",f];
                    playLabel.text = st;
                
            }else{
                playLabel.text = [NSString stringWithFormat:@"播放:%@次",self.attentionModel.playTimes];
            }
            
            state.text = [NSString stringWithFormat:@"状态:已更新%@集",self.attentionModel.tracks];
            if (self.score.length > 0) {
                
                pingfenLabel.text = [NSString stringWithFormat:@"评分:%@分",self.score];
                priceLabel.text = [NSString stringWithFormat:@"价格:%@",self.displayPrice];
            }else{
                pingfenLabel.text = [NSString stringWithFormat:@"评分:%@分",self.attentionModel.score];
                priceLabel.text = [NSString stringWithFormat:@"价格:%@",self.attentionModel.displayPrice];
            }
            [self.tab reloadData];
} error:^(NSError *error) {
            }];
    }
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
    [btn1 addTarget:self action:@selector(dingyueAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.isDingYueArr = [[table selectAllInDingyue]mutableCopy];
    self.url = [NSString stringWithFormat:@"%@",self.url];
    for (NSArray *arr in self.isDingYueArr) {
        
        if ([arr containsObject:self.url]) {
            [btn1 setTitle:@"已订阅" forState:(UIControlStateNormal)];
            [btn1 setBackgroundColor:[UIColor grayColor]];
            self.isDingYue = YES;
            break;
        }else
        {
            self.isDingYue = NO;
        }
    }
[btn1.layer setMasksToBounds:YES];
    [btn1.layer setCornerRadius:5];
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn2.frame = CGRectMake((kScreenWidth - 30) / 2 + 10 + 10, 120, (kScreenWidth - 30) / 2, 30);
    [btn2 setTitle:@"批量下载" forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(batchDownLoadAction) forControlEvents:(UIControlEventTouchUpInside)];
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
   NSString *URL1 = [URL stringByReplacingOccurrencesOfString:@"albumId=308981" withString:[NSString stringWithFormat:@"albumId=%@",self.url]];
//    NSLog(@"++++++%@",URL1);
    //http://audio.xmcdn.com/group17/M0A/18/F6/wKgJKVeDHbawGkPRABMIm_FwUyk214.m4a
    //http://audio.xmcdn.com/group19/M0A/19/02/wKgJJleDFyiSkDT0ADEj4PI_Ypg361.mp3
    [RequestManager requestWithUrlString:URL1 requestType:RequestGET parDic:nil finish:^(NSData *data) {
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
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.albumModel.coverLarge]];
   
        [self.tab reloadData];
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
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
        return self.pinglunArray.count;
        
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
        
        [cell.downLoadBtn addTarget:self action:@selector(downLoadAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell creatCell:model];
        if (model.type == DiDdwonload || model.type == Downloadimg || model.type == DownloadPause) {
            [cell.downLoadBtn setTintColor:[UIColor grayColor]];
        }else{
            
            
            [cell.downLoadBtn setTintColor:[UIColor redColor]];
        }
        
        
    return cell;
    }
}




#pragma mark --- 订阅
-(void)dingyueAction:(UIButton *)btn
{
    self.isDingYue = !self.isDingYue;
    if (self.isDingYue == YES) {
        [btn setTitle:@"已订阅" forState:(UIControlStateNormal)];
        [btn setBackgroundColor:[UIColor grayColor]];
        MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
        [table creatDingyueTable];
        if (self.uid == nil) {
            self.uid = @"2";
        }if (self.nickName == nil) {
            self.nickName = @"3";
        }if (self.score == nil) {
            self.score = @"4";
        }if (self.displayPrice == nil) {
            self.displayPrice = @"5";
        }
        self.uid = [NSString stringWithFormat:@"%@",self.uid];
        if (![self.uid isEqualToString:@"2"]) {
            [table insertIntoDingyueTable:@[self.url,[NSString stringWithFormat:@"%ld",self.inter],@"1",[NSString stringWithFormat:@"%ld",self.row],self.uid,self.nickName,self.score,self.displayPrice,self.attentionModel.coverLarge,self.attentionModel.title,self.nickName]];
            return;
        }
        if (self.inter>=0 && self.inter<=3){
            [table insertIntoDingyueTable:@[self.url,[NSString stringWithFormat:@"%ld",self.inter],@"1",[NSString stringWithFormat:@"%ld",self.row],self.uid,self.nickName,self.score,self.displayPrice,self.hotRecommendsModel.coverMiddle,self.hotRecommendsModel.title,self.hotRecommendsModel.nickname]];
            return;
        }
        if (self.isPaid == NO) {
            [table insertIntoDingyueTable:@[self.url,[NSString stringWithFormat:@"%ld",self.inter],@"0",[NSString stringWithFormat:@"%ld",self.row],self.uid,self.nickName,self.score,self.displayPrice,self.albumModel.coverLarge,self.albumModel.title,self.albumModel.nickname]];
        }
        }else{
        [btn setTitle:@"订阅专辑" forState:(UIControlStateNormal)];
        [btn setBackgroundColor:[UIColor greenColor]];
        MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
        [table delegateNoteWithDingyueTableName:kHisDownLoadTable totalTitle:[NSString stringWithFormat:@"%@",self.url]];
    }
}


#pragma mark ---批量下载
-(void)batchDownLoadAction{
    batchDownViewController *batch = [[batchDownViewController alloc]init];
    batch.arr = self.tracksArr;
    if (self.inter <= 2 && self.inter >= 0) {
        if (self.isPaid == NO) {
            batch.coverMiddle = self.hotRecommendsModel.coverMiddle;
            batch.titleL = self.hotRecommendsModel.title;
            }else{
            batch.coverMiddle = self.attentionModel.coverLarge;
            batch.titleL = self.attentionModel.title;
            }
    }else{
        batch.coverMiddle = self.albumModel.coverLarge;
        batch.titleL = self.albumModel.title;
    }
    self.navigationController.navigationBar.translucent = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playFrame" object:nil];
    [self.navigationController pushViewController:batch animated:YES];
}


-(void)downLoadAction:(UIButton *)btn
{
    [btn setTintColor:[UIColor grayColor]];
    AlbumDetailTableViewCell *cell = (AlbumDetailTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.tab indexPathForCell:cell];
    AlbumDetailModel *model = self.tracksArr[indexPath.row];
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    NSArray *tableArray = [table selectAll];
    if (tableArray.count > 0) {
        for (NSArray *arr in tableArray) {
            if ([arr containsObject:model.playUrl64]) {
                [self alertControllerShowWithTitle:@"已被下载" message:nil];
                return;
            }
        }
    }
    
    
    if (model.type == Downloadimg || model.type == DownloadPause) {
        [self alertControllerShowWithTitle:@"正在下载或已在下载列表" message:nil];
        return;
    }
    if (self.inter <= 2 && self.inter >= 0) {
        if (self.isPaid == NO) {
            NSArray *arr = @[self.hotRecommendsModel.coverMiddle,self.hotRecommendsModel.title];
//            [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"arr"];
            
            [[ArrayManager shareManager].oneArray addObject:arr];
        }else{
            NSArray *arr = @[self.attentionModel.coverLarge,self.attentionModel.title];
//            [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"arr"];
            [[ArrayManager shareManager].oneArray addObject:arr];
}
        }else{
        NSArray *arr = @[self.albumModel.coverLarge,self.albumModel.title];
//[[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"arr"];
            [[ArrayManager shareManager].oneArray addObject:arr];
}
    [self.downLoadArray addObject:model];
    [[ArrayManager shareManager].Array addObject:model];
    model.type = DownloadPause;
    for (AlbumDetailModel *model in [ArrayManager shareManager].Array) {
        if (model.type == Downloadimg) {
            break;
        }else{
           MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
            MyDownLoad *task = [manager creatDownload:model.playUrl64];
            [self downLoad:task model:model];
        }
    }
}



-(void)downloadAction
{
    NSArray *arr = [ArrayManager shareManager].oneArray[0];
    if (self.inter <= 2 && self.inter >= 0) {
        if (self.isPaid == NO) {
            self.hotRecommendsModel.coverMiddle = arr[0];
            self.hotRecommendsModel.title = arr[1];
        }else{
            self.attentionModel.coverLarge = arr[0];
            self.attentionModel.title = arr[1];
        }
    }else{
        self.albumModel.coverLarge = arr[0];
        self.albumModel.title = arr[1];
    }

    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
    if ([ArrayManager shareManager].Array.count == 0) {
        return;
    }
    if ([ArrayManager shareManager].Array.count > 0) {
        AlbumDetailModel *model = [ArrayManager shareManager].Array[0];
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [self downLoad:task model:model];
    }
}




-(void)downLoad:(MyDownLoad *)task model:(AlbumDetailModel *)model
{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    [task start];
    [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
//        NSLog(@"%lld,%ld",bytesWritten,progress);
        model.type = Downloadimg;
        [ArrayManager shareManager].progress = (CGFloat)progress / 100;
    } DidDownload:^(NSString *savePath, NSString *url) {
//        NSLog(@"++++++++++++++++++++%@",savePath);
        [table creatTable];
 NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverLarge]];
        if (musicData == nil) {
            musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
        }
        if (self.inter <= 2 && self.inter >= 0) {
            if (self.isPaid == NO) {
                NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.hotRecommendsModel.coverMiddle]];
                [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.hotRecommendsModel.title]];
            }else{
                NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.attentionModel.coverLarge]];
                [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.attentionModel.title]];
            }
        }else{
            NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.albumModel.coverLarge]];
            [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.albumModel.title]];
        }
        model.type = DiDdwonload;
        [[ArrayManager shareManager].Array removeObject:model];
        [self.downLoadArray removeObject:model];
        [[ArrayManager shareManager].oneArray removeObjectAtIndex:0];
        if ([ArrayManager shareManager].Array.count > 0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reload" object:model];
            [self downloadAction];
        }if ([ArrayManager shareManager].Array.count == 0) {
            
            return ;
        }
}];
}

// 展示AlertController
- (void)alertControllerShowWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [self performSelector:@selector(alertMiss:) withObject:alert afterDelay:1];
}
// AlertController自动消失
- (void)alertMiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
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
    
    if (self.veryBigTab.seg.selectedSegmentIndex == 1) {
        AlbumDetailModel *model = self.tracksArr[indexPath.row];
        model.isPlay = YES;
        [self.tab reloadData];
        if (model.playUrl64 == nil) {
//            NSLog(@"播放地址不存在");
            return;
        }
        MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithAlbumDetailModel:self.tracksArr];
        [MyPlayerManager defaultManager].index = indexPath.row;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
        [self presentViewController:playVC animated:YES completion:nil];
    }
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

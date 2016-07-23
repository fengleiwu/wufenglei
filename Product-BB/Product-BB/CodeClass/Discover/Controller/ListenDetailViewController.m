//
//  ListenDetailViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ListenDetailViewController.h"
#import "ListenDetailModel.h"
#import "recommendMoreTableViewCell.h"
#import "AdjustHeight.h"
#import "ListenDetailTableViewCell.h"
#import "AlbumDetailViewController.h"
#import "MusicplayViewController.h"
#import "BroadMusicModel.h"
#import "MyDownLoad.h"
#import "MyDownLoadManager.h"
#import "MyMusicDownLoadTable.h"
#import "DownLoadViewController.h"
@interface ListenDetailViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray *listenArray;
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)ListenDetailModel *model;
@property (nonatomic , strong)NSMutableArray *downLoadArray;
@end

@implementation ListenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downLoadArray = [NSMutableArray array];
     NSString *url = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_detail?device=android&id=%@&position=1&title=%@",self.listenId,self.listenTitle];
    NSString *encodURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self creatTable];
    
    [RequestManager requestWithUrlString:encodURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.listenArray = [ListenDetailModel arr:dic];
        self.model = [ListenDetailModel model:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}




-(void)creatTable
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 120;
    NSString *url = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_detail?device=android&id=%@&position=1&title=%@",self.listenId,self.listenTitle];
    NSString *encodURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
   // NSLog(@"++++++++%@",encodURL);
    [RequestManager requestWithUrlString:encodURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.model = [ListenDetailModel model:dic];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 100, 40)];
        titleLabel.text = self.model.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.centerX = kScreenWidth/2;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 100, 30)];
        label.centerX = kScreenWidth/2;
        label.text = @"- 简介 -";
        label.textAlignment = NSTextAlignmentCenter;
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, kScreenWidth - 20, 150)];
        textLabel.text = self.model.intro;
        textLabel.numberOfLines = 0;
        CGFloat f = [AdjustHeight adjustHeightByString:self.model.intro width:kScreenWidth - 20 font:12];
        CGRect rect = textLabel.frame;
        rect.size.height = f;
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 150, f + 100 + 100, 50, 20)];
        nameLabel.text = @"小编:";
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:12];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 95, f + 100 + 100, 20, 20)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.model.smallLogo]];
        [imageV.layer setMasksToBounds:YES];
        [imageV.layer setCornerRadius:10];
        UILabel *introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 70, f + 100 + 100, 60, 20)];
        introduceLabel.text = self.model.nickname;
        introduceLabel.font = [UIFont systemFontOfSize:12];
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, f + 100 + 40 + 100);
        [self.headView addSubview:titleLabel];
        [self.headView addSubview:label];
        [self.headView addSubview:textLabel];
        [self.headView addSubview:nameLabel];
        [self.headView addSubview:imageV];
        [self.headView addSubview:introduceLabel];
        self.tab.tableHeaderView = self.headView;
    } error:^(NSError *error) {
        
    }];

    
    
    [self.view addSubview:self.tab];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat f = [self.type floatValue];
    if (f == 1) {//阅读
        
        recommendMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[recommendMoreTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        ListenDetailModel *model = self.listenArray[indexPath.row];
        [cell creatListenCell:model];
        return cell;
    }else{//音乐
        ListenDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[ListenDetailTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
        }
        ListenDetailModel *model = self.listenArray[indexPath.row];
        [cell.downLoadBtn addTarget:self action:@selector(downLoadAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell creatListenCell:model];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listenArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListenDetailModel *model = self.listenArray[indexPath.row];

    CGFloat f = [self.type floatValue];
    if (f == 1) {
        AlbumDetailViewController *album = [[AlbumDetailViewController alloc]init];
        album.url = model.myid;
        album.inter = 4;
        [self.navigationController pushViewController:album animated:YES];
    } else {
        MusicplayViewController *playVC = [[MusicplayViewController alloc]init];

        playVC.newmodelArray = [BroadMusicModel modelCOnfigureWithListenDetailModel:self.listenArray];
        [MyPlayerManager defaultManager].index = indexPath.row;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
        
        [self presentViewController:playVC animated:YES completion:nil];
        
    }
    
}






-(void)downLoadAction:(UIButton *)btn
{
    
    
    ListenDetailTableViewCell *cell = (ListenDetailTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.tab indexPathForCell:cell];
    ListenDetailModel *model = self.listenArray[indexPath.row];
    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
    MyDownLoad *task = [manager creatDownload:model.playPath64];
    [[ArrayManager shareManager].Array addObject:model];
    [self.downLoadArray addObject:model];
    [self downLoad:task model:model];
}

-(void)downloadAction
{
    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
    if (self.downLoadArray.count == 0) {
        return;
    }
    if (self.downLoadArray.count > 0) {
        ListenDetailModel *model = self.downLoadArray[0];
        MyDownLoad *task = [manager creatDownload:model.playPath64];
        [self downLoad:task model:model];
    }
}

-(void)downLoad:(MyDownLoad *)task model:(ListenDetailModel *)model{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    
    
    [task start];
    [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
        NSLog(@"%lld,%ld",bytesWritten,progress);
        
        
    } DidDownload:^(NSString *savePath, NSString *url) {
        [table creatTable];
        NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.smallLogo]];
        
        NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverSmall]];
        if (musicData == nil) {
            musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
        }
        [table insertIntoTable:@[model.title,model.playPath64,musicData,savePath,model.nickname,model.playsCounts,@"111",model.commentsCounts,model.favoritesCounts,albumData,self.model.title]];
        
        [[ArrayManager shareManager].Array removeObject:model];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reload" object:model];
    }];
    

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

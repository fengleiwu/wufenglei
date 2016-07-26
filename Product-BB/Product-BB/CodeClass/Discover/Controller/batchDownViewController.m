//
//  batchDownViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "batchDownViewController.h"
#import "batchDownTableViewCell.h"
#import "AlbumDetailModel.h"
#import "MyDownLoad.h"
#import "MyDownLoadManager.h"
#import "MyMusicDownLoadTable.h"
#import "DownLoadViewController.h"

@interface batchDownViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tab;
@property (nonatomic ,strong)UIButton *downLoadBtn;
@property (nonatomic ,strong)UIButton *quanxuanBtn;
@property (nonatomic ,strong)NSMutableArray *downArr;
@property (nonatomic ,strong)NSMutableArray *downDownDownArr;
@end

@implementation batchDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    self.downArr = [NSMutableArray array];
    self.downDownDownArr = [NSMutableArray array];
    
    
    
    
    self.title = @"批量下载";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头 (2)"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    //UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"正在下载" style:(UIBarButtonItemStylePlain) target:self action:@selector(turnToDowningAction)];
    
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    NSArray *tableArray = [table selectAll];
    for (AlbumDetailModel *model in self.arr) {
        for (NSArray *arr in tableArray) {
            if ([arr containsObject:model.playUrl64]) {
                [self.downDownDownArr addObject:model];
                break;
            }
        }
    }
    item.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = item;
    //self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view.
}
-(void)back
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playResume" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)creatTableview
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-15) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 60;
    [self.view addSubview:self.tab];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    batchDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[batchDownTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
    }
    AlbumDetailModel *model = self.arr[indexPath.row];
    [cell creatCell:model];
    
   if (model.type == DiDdwonload || model.type == DownloadPause || model.type == Downloadimg) {
                [cell.imageV setImage:[UIImage imageNamed:@"2"] forState:(UIControlStateNormal)];
                [cell.imageV setTintColor:[UIColor grayColor]];
       model.isSelect = NO;
                }else{
                [cell.imageV addTarget:self action:@selector(choseAction:) forControlEvents:(UIControlEventTouchUpInside)];
                    [cell.imageV setTintColor:[UIColor redColor]];
                
                if (model.isSelect == YES) {
                    [cell.imageV setImage:[UIImage imageNamed:@"2"] forState:(UIControlStateNormal)];
                }else{
                    [cell.imageV setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
                }
            }
        return cell;
}


-(void)choseAction:(UIButton *)btn
{
    batchDownTableViewCell *cell =(batchDownTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.tab indexPathForCell:cell];
    AlbumDetailModel *model = self.arr[indexPath.row];
   if (model.type == DiDdwonload || model.type == DownloadPause || model.type == Downloadimg) {
                model.isSelect = NO;
            }else{
                model.isSelect = !model.isSelect;
                if (model.isSelect == YES) {
                    [self.downArr addObject:model];
                }else{
                    [self.downArr removeObject:model];
                }
                [self.tab reloadData];
            }
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumDetailModel *model = self.arr[indexPath.row];
    if (model.type == DiDdwonload || model.type == DownloadPause || model.type == Downloadimg) {
        model.isSelect = NO;
    }else{
    model.isSelect = !model.isSelect;
    if (model.isSelect == YES) {
        [self.downArr addObject:model];
    }else{
        [self.downArr removeObject:model];
    }
    [self.tab reloadData];
    }
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *st = [NSString stringWithFormat:@"共%ld集",self.arr.count];
    return st;
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view1.backgroundColor = [UIColor whiteColor];
    self.downLoadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.downLoadBtn.frame = CGRectMake(20, 15, 130, 30);
    [self.downLoadBtn.layer setMasksToBounds:YES];
    [self.downLoadBtn.layer setCornerRadius:15];
    [self.downLoadBtn setTitle:@"立即下载" forState:(UIControlStateNormal)];
    [self.downLoadBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.downLoadBtn.backgroundColor = [UIColor grayColor];
    self.quanxuanBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.quanxuanBtn.frame = CGRectMake(kScreenWidth - 120, 20, 100, 20);
    
    if (self.downArr.count == 0) {
        [self.quanxuanBtn setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
        [self.quanxuanBtn addTarget:self action:@selector(changeYesAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    for (AlbumDetailModel *model in self.downArr) {
        if (model.isSelect == NO) {
            [self.quanxuanBtn setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
            [self.quanxuanBtn addTarget:self action:@selector(changeYesAction:) forControlEvents:(UIControlEventTouchUpInside)];
            break;
        }
        [self.quanxuanBtn setImage:[UIImage imageNamed:@"2"] forState:(UIControlStateNormal)];
        [self.quanxuanBtn addTarget:self action:@selector(changeNoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
if (self.downArr.count + self.downDownDownArr.count < self.arr.count) {
        [self.quanxuanBtn setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
        [self.quanxuanBtn addTarget:self action:@selector(changeYesAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [self.quanxuanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 80)];
    [self.quanxuanBtn setTitle:@"全选本页" forState:(UIControlStateNormal)];
    [self.quanxuanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.quanxuanBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.quanxuanBtn setTintColor:[UIColor redColor]];
    for (AlbumDetailModel *model in self.downArr) {
        if (model.isSelect == YES) {
            [self.downLoadBtn setBackgroundColor:[UIColor redColor]];
            [self.downLoadBtn addTarget:self action:@selector(downloadAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    [view1 addSubview:self.downLoadBtn];
    [view1 addSubview:self.quanxuanBtn];
    return view1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(void)changeYesAction:(UIButton *)btn
{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    NSArray *tableArray = [table selectAll];
    [self.downArr removeAllObjects];
    for (AlbumDetailModel *model in self.arr) {
        [self.downArr addObject:model];
        model.isSelect = YES;
        if (tableArray.count > 0) {
            for (NSArray *arr in tableArray) {
                if ([arr containsObject:model.playUrl64] || model.type == DownloadPause || model.type == Downloadimg) {
                    model.isSelect = NO;
                    [self.downArr removeObject:model];
                    break;
            }
            }
        }
        }
    [self.tab reloadData];
    }

-(void)changeNoAction:(UIButton *)btn
{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    NSArray *tableArray = [table selectAll];
    [self.downArr removeAllObjects];
    for (AlbumDetailModel *model in self.arr) {
        if (tableArray.count > 0) {
            for (NSArray *arr in tableArray) {
                if ([arr containsObject:model.playUrl64] || model.type == DownloadPause || model.type == Downloadimg) {
                    model.isSelect = NO;
                    break;
            }
        }
        }
            model.isSelect = NO;
        }
    [self.tab reloadData];
}

-(void)downloadAction
{
    
    for (AlbumDetailModel *model in self.downArr) {
        model.type = DownloadPause;
        [[ArrayManager shareManager].Array addObject:model];
    }
    for (int i = 0; i < self.downArr.count; i++) {
        NSArray *arr = @[self.coverMiddle,self.titleL];
        [[ArrayManager shareManager].oneArray addObject:arr];
        }
    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
if ([ArrayManager shareManager].Array.count == 0) {
        return;
    }
    if ([ArrayManager shareManager].Array.count > 0) {
        for (AlbumDetailModel *model in [ArrayManager shareManager].Array) {
            if (model.type == Downloadimg) {
                return;
            }
        }
        [self.tab reloadData];
              AlbumDetailModel *model = [ArrayManager shareManager].Array[0];
        NSArray *arr = [ArrayManager shareManager].oneArray[0];
        self.coverMiddle = arr[0];
        if (model.coverLarge.length == 0) {
            self.titleL = arr[1];
        }else
        {
            self.titleL = arr[1];
        }
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
            [table creatTable];
NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.coverMiddle]];
            if (model.coverLarge.length == 0) {
                NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.smallLogo]];
                if (musicData == nil) {
                    musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
                }
                [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleL]];
            }else{
        NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverLarge]];
                if (musicData == nil) {
                    musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
                }
        [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleL]];
            }
            model.type = DiDdwonload;
            [self.downArr removeObject:model];
            [[ArrayManager shareManager].Array removeObject:model];
            [[ArrayManager shareManager].oneArray removeObjectAtIndex:0];
            if ([ArrayManager shareManager].Array.count > 0) {
                [self.downDownDownArr addObject:model];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reload" object:model];
                [self downloadAction];
            }
            if ([ArrayManager shareManager].Array.count == 0) {
                return ;
            }
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

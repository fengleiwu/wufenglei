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
@end

@implementation batchDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableview];
    self.downArr = [NSMutableArray array];
    self.title = @"批量下载";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头 (2)"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"正在下载" style:(UIBarButtonItemStylePlain) target:self action:@selector(turnToDowningAction)];
    
    item.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.rightBarButtonItem = rightItem;
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
    [cell.imageV addTarget:self action:@selector(choseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    if (model.isSelect == YES) {
        [cell.imageV setImage:[UIImage imageNamed:@"2"] forState:(UIControlStateNormal)];
    }else{
        [cell.imageV setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
    }
    return cell;
    
}


-(void)choseAction:(UIButton *)btn
{
    batchDownTableViewCell *cell =(batchDownTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.tab indexPathForCell:cell];
    AlbumDetailModel *model = self.arr[indexPath.row];
    model.isSelect = !model.isSelect;
    if (model.isSelect == YES) {
        [self.downArr addObject:model];
    }else{
        [self.downArr removeObject:model];
    }
    [self.tab reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumDetailModel *model = self.arr[indexPath.row];
    model.isSelect = !model.isSelect;
    if (model.isSelect == YES) {
        [self.downArr addObject:model];
    }else{
        [self.downArr removeObject:model];
    }
    [self.tab reloadData];

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
    for (AlbumDetailModel *model in self.arr) {
        if (model.isSelect == NO) {
            [self.quanxuanBtn setImage:[UIImage imageNamed:@"1"] forState:(UIControlStateNormal)];
            [self.quanxuanBtn addTarget:self action:@selector(changeYesAction:) forControlEvents:(UIControlEventTouchUpInside)];
            break;
        }
        [self.quanxuanBtn setImage:[UIImage imageNamed:@"2"] forState:(UIControlStateNormal)];
        [self.quanxuanBtn addTarget:self action:@selector(changeNoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    [self.quanxuanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 80)];
    [self.quanxuanBtn setTitle:@"全选本页" forState:(UIControlStateNormal)];
    [self.quanxuanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.quanxuanBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.quanxuanBtn setTintColor:[UIColor redColor]];
    
    for (AlbumDetailModel *model in self.arr) {
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
    [self.downArr removeAllObjects];
    for (AlbumDetailModel *model in self.arr) {
        [self.downArr addObject:model];
        model.isSelect = YES;
    }
    [self.tab reloadData];
}

-(void)changeNoAction:(UIButton *)btn
{
    [self.downArr removeAllObjects];
    for (AlbumDetailModel *model in self.arr) {
        model.isSelect = NO;
    }
    [self.tab reloadData];
}

-(void)downloadAction
{
    
    
    for (AlbumDetailModel *model in self.downArr) {
        [[ArrayManager shareManager].Array addObject:model];
    }
    NSLog(@"%ld",self.downArr.count);

    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];

    if (self.downArr.count == 0) {
        return;
    }
    if (self.downArr.count > 0) {
        AlbumDetailModel *model = self.downArr[0];
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [self downLoad:task model:model];
    }
//    if (self.downArr.count >= 2) {
//        
//            AlbumDetailModel *model1 = self.downArr[0];
//            AlbumDetailModel *model2 = self.downArr[1];
//            MyDownLoad *task1 = [manager creatDownload:model1.playUrl64];
//            MyDownLoad *task2 = [manager creatDownload:model2.playUrl64];
//            [self downLoad:task1 model:model1];
//            [self downLoad:task2 model:model2];
//        }
    
    
    
}


-(void)downLoad:(MyDownLoad *)task model:(AlbumDetailModel *)model
{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    [task start];
    [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
        NSLog(@"%lld,%ld",bytesWritten,progress);
        } DidDownload:^(NSString *savePath, NSString *url) {
            NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.coverMiddle]];
            if (model.coverLarge.length == 0) {
                NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.smallLogo]];
                [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleL]];
            }else{
        NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverLarge]];
        [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleL]];
            }
        [self.downArr removeObject:model];
            [[ArrayManager shareManager].Array removeObject:model];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reload" object:nil];
        [self downloadAction];
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

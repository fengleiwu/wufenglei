//  DownLoadViewController.m
//
//  Product-BB
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownLoadViewController.h"
#import "MyMusicDownLoadTable.h"
#import "MusicAlbumDownLoadTableViewCell.h"
#import "DownLoadMusicViewController.h"
#import "DownLoadMusicTableViewCell.h"
#import "MyDownLoad.h"
#import "MyDownLoadManager.h"
#import "BroadMusicModel.h"
#import "MusicplayViewController.h"
@interface DownLoadViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UISegmentedControl *seg;
@property (nonatomic , strong)UIScrollView *scr;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)UILabel *memoryLabel;
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)NSMutableArray *array;
@property (nonatomic , strong)UITableView *albumTab;
@property (nonatomic , strong)UITableView *voiceTab;
@property (nonatomic , strong)UITableView *downingTab;

@property (nonatomic , strong)NSMutableArray *voiceArr;

@property (nonatomic , strong)NSMutableArray *downLoadingArray;

@property (nonatomic , strong)NSMutableArray *titleArr;


@property (nonatomic , assign)NSInteger inter;


@end

@implementation DownLoadViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self creatScr];
    [self creatMemoryLabel];
    [self creatAlbumTab];
    [self creatVoiceTab];
    [self creatDownlingTab];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDownLoadingTab:) name:@"reload" object:nil];
    
    // Do any additional setup after loading the view.
}

-(void)reloadDownLoadingTab:(NSNotification *)nito
{
    if (self.downLoadingArray.count > 0) {
        [self.downLoadingArray removeObject:nito.object];
        [self creatVoiceArray];
        [self creatAlbumDic];
        [self.albumTab reloadData];
     [self.downingTab reloadData];
    }
}

-(void)creatdownLoadingArray{
    self.titleArr = [NSMutableArray array];
    
    if ([ArrayManager shareManager].oneArray.count > 0) {
        self.titleArr = [ArrayManager shareManager].oneArray[0];
    }
    
    self.downLoadingArray = [ArrayManager shareManager].Array;
    [self.downingTab reloadData];
}


-(void)creatAlbumTab
{
    self.albumTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44 - 84) style:(UITableViewStylePlain)];
    self.albumTab.delegate = self;
    self.albumTab.dataSource = self;
    self.albumTab.rowHeight = 120;
    [self.scr addSubview:self.albumTab];
}




-(void)creatVoiceTab
{
    self.voiceTab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 44 - 84) style:(UITableViewStylePlain)];
    self.voiceTab.delegate = self;
    self.voiceTab.dataSource = self;
    self.voiceTab.rowHeight = 120;
    [self.scr addSubview:self.voiceTab];
}


-(void)creatDownlingTab
{
    self.downingTab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - 44 - 84) style:(UITableViewStylePlain)];
    self.downingTab.delegate = self;
    self.downingTab.dataSource = self;
    self.downingTab.rowHeight = 140;
    [self.scr addSubview:self.downingTab];
}

-(void)creatVoiceArray
{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.voiceArr = [[table selectAll]mutableCopy];
    [self.voiceTab reloadData];
}


-(void)creatAlbumDic{
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    NSArray *arr = [table selectAll];
    self.array = [NSMutableArray array];
    for (NSArray *ar1 in arr) {
        [self.array addObject:ar1[10]];
        for (int i = 0; i < self.array.count - 1; i++) {
            if ([self.array[self.array.count-1] isEqualToString:self.array[i]]) {
                [self.array removeLastObject];
            }
        }
    }
    self.dic = [NSMutableDictionary dictionary];
    for (NSString *title in self.array) {
        NSMutableArray *downArr = [NSMutableArray array];
        [self.dic setValue:downArr forKey:title];
        for (NSArray *arr2 in arr) {
            if ([title isEqualToString:arr2[10]]) {
                [downArr addObject:arr2];
            }
        }
        [self.albumTab reloadData];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
   [self creatSeg];
    [self creatAlbumDic];
    [self creatVoiceArray];
    [self creatdownLoadingArray];
    if ([ArrayManager shareManager].Array.count > 0) {
        [self viewWillAppearDownLoadAction];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark 获取内存
// 获取当前设备可用内存(单位：MB）
-(double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),HOST_VM_INFO,(host_info_t)&vmStats,&infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),TASK_BASIC_INFO,(task_info_t)&taskInfo,&infoCount);
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}



-(void)creatSeg
{
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"专辑",@"声音",@"下载中"]];
    self.seg.frame = CGRectMake(0, 20, kScreenWidth, 44);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    self.seg.tintColor = [UIColor clearColor];
    [self.seg setTitleTextAttributes:dic forState:(UIControlStateSelected)];
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                           NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.seg setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
    self.seg.selectedSegmentIndex = 0;
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth / 3, 2)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
    [self.seg addSubview:self.lineView];
    [self.navigationController.view addSubview:self.seg];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.seg removeFromSuperview];
}


-(void)creatScr
{
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20 - 44 - 74)];
    self.scr.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.scr.pagingEnabled = YES;
    self.scr.showsHorizontalScrollIndicator = NO;
    self.scr.delegate = self;
    self.scr.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:self.scr];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.seg.selectedSegmentIndex = self.scr.contentOffset.x / kScreenWidth;
    self.lineView.frame = CGRectMake(kScreenWidth / 3 * self.seg.selectedSegmentIndex, 42, kScreenWidth / 3, 2);
    [self creatVoiceArray];
    [self creatAlbumDic];
    [self creatdownLoadingArray];
    [self.albumTab reloadData];
}

-(void)segAction
{
    CGPoint point = CGPointMake(self.seg.selectedSegmentIndex * kScreenWidth, 0);
    self.scr.contentOffset = point;
    self.lineView.frame = CGRectMake(kScreenWidth / 3 * self.seg.selectedSegmentIndex, 42, kScreenWidth / 3, 2);
    self.navigationController.navigationBar.translucent = NO;
    [self creatVoiceArray];
    [self creatAlbumDic];
    [self creatdownLoadingArray];
    [self.albumTab reloadData];
//    [self.downingTab reloadData];

}


-(void)creatMemoryLabel
{
    self.memoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    self.memoryLabel.font = [UIFont systemFontOfSize:12];
    self.memoryLabel.textColor = [UIColor whiteColor];
    self.memoryLabel.textAlignment = NSTextAlignmentCenter;
    self.memoryLabel.backgroundColor = [UIColor grayColor];
    double userMemory = [self usedMemory];
    double available = [self availableMemory];
    self.memoryLabel.text = [NSString stringWithFormat:@"已占用%.2fMB,可用%.2fMB",userMemory,available];
    [self.view addSubview:self.memoryLabel];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.seg.selectedSegmentIndex == 0) {
        return self.array.count;
    }if (self.seg.selectedSegmentIndex == 1) {
        return self.voiceArr.count;
    }else{
        return self.downLoadingArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.seg.selectedSegmentIndex == 0) {
        MusicAlbumDownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[MusicAlbumDownLoadTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        NSString *key = self.array[indexPath.row];
        NSArray *arr = self.dic[key];
        [cell.rubbishBtn addTarget:self action:@selector(delegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell creatCell:arr];
        return cell;
    }else{
        DownLoadMusicTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell1) {
            cell1 = [[DownLoadMusicTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
            }
        if (self.seg.selectedSegmentIndex == 1) {
            [cell1.rubbishBtn addTarget:self action:@selector(delegateOneMusicAction:) forControlEvents:(UIControlEventTouchUpInside)];
            NSArray *arr = self.voiceArr[indexPath.row];
            cell1.titleL.textColor = [UIColor blackColor];
            [cell1 creatCell:arr];
        }else{
            
            AlbumDetailModel *model = self.downLoadingArray[indexPath.row];
            [cell1 creatDownloadingCell:model];
            if (model.type == Downloadimg) {
                cell1.titleL.textColor = [UIColor redColor];
                cell1.progress.hidden = NO;
                cell1.progress.progress = [ArrayManager shareManager].progress;
            }if (model.type == DownloadPause){
                cell1.titleL.textColor = [UIColor blackColor];
                cell1.progress.hidden = YES;
            }
            }
        return cell1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.seg.selectedSegmentIndex == 0) {
        NSString *key = self.array[indexPath.row];
        NSArray *arr = self.dic[key];
        DownLoadMusicViewController *down = [[DownLoadMusicViewController alloc]init];
        down.arr = [arr mutableCopy];
        down.titleL = key;
        [self.navigationController pushViewController:down animated:YES];
    }else if (self.seg.selectedSegmentIndex == 1) {
        NSMutableArray *array = [NSMutableArray array];
        MusicplayViewController *playVC = [[MusicplayViewController alloc]init];
        for (NSArray *arr in self.voiceArr) {
            BroadMusicModel *model = [[BroadMusicModel alloc]init];
            model.isDownload = YES;
            model.totalTitle = arr[0];
            model.liveTitle = arr[4];
            model.playCount = arr[5];
            model.dataImage = arr[2];
            // 从数据库获取下载的音频。
            NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:kMyDownloadTable];
            NSString *path = arr[3];
            NSString *music = [[path componentsSeparatedByString:@"/"]lastObject];
            filePath = [filePath stringByReplacingOccurrencesOfString:@"Documents/一身辣条味儿" withString:[NSString stringWithFormat:@"Library/Caches/%@",music]];
            model.musicURL = filePath;
            if (model.musicURL == nil || [model.musicURL isEqualToString:@""]) {
//                NSLog(@"需要购买才能播放");
                
            }else {
                [array addObject:model];
            }
            
        }
        playVC.newmodelArray = array;
        [MyPlayerManager defaultManager].index = indexPath.row;
        [MyPlayerManager defaultManager].musicLists = playVC.newmodelArray;
        [self presentViewController:playVC animated:YES completion:nil];
    }if (self.seg.selectedSegmentIndex == 2) {
        AlbumDetailModel *model1 = self.downLoadingArray[indexPath.row];
        self.inter = indexPath.row;
        MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
        if (self.downLoadingArray.count == 1) {
            AlbumDetailModel *model = self.downLoadingArray[0];
            if (model.type == Downloadimg) {
                model.type = DownloadPause;
                [[MyDownLoad shareMyDownLoad]stop];
            }else if (model.type == DownloadPause){
                model.type = Downloadimg;
                if (model.playUrl64 == nil) {
                    MyDownLoad *task = [manager creatDownload:model.playPath64];
                    [self downLoad:task model:model];
                }else{
                    MyDownLoad *task = [manager creatDownload:model.playUrl64];
                    [self downLoad:task model:model];
                }
            }
            return;
        }
        if (model1.type == Downloadimg) {
            for (AlbumDetailModel *model in self.downLoadingArray) {
                model.type = DownloadPause;
            }
            if (self.inter + 1 >= self.downLoadingArray.count) {
            AlbumDetailModel *model = self.downLoadingArray[0];
                model.type = Downloadimg;
            }else
            {
                self.inter++;
                AlbumDetailModel *model = self.downLoadingArray[self.inter];
                model.type = Downloadimg;
                }
        } else if (model1.type == DownloadPause) {
            for (AlbumDetailModel *model in self.downLoadingArray) {
                model.type = DownloadPause;
            }
            model1.type = Downloadimg;
        }
        [self cellDownLoadAction];
    }
}

   -(void)cellDownLoadAction{
       MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
      AlbumDetailModel *model = self.downLoadingArray[self.inter];
      if (model.playUrl64 == nil) {
        MyDownLoad *task = [manager creatDownload:model.playPath64];
        [task stop];
    }else{
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [task stop];
   }
   for (AlbumDetailModel *model in self.downLoadingArray) {
        if (model.type == Downloadimg) {
            MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
            if (model.playUrl64 == nil) {
                            MyDownLoad *task = [manager creatDownload:model.playPath64];
                            [self downLoad:task model:model];
                        }else{
                            MyDownLoad *task = [manager creatDownload:model.playUrl64];
                            [self downLoad:task model:model];
                        }
       }
    }
}

-(void)viewWillAppearDownLoadAction{
    AlbumDetailModel *model = [ArrayManager shareManager].Array[0];
    self.titleArr = [ArrayManager shareManager].oneArray[0];
    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
    if (model.playUrl64 == nil) {
        MyDownLoad *task = [manager creatDownload:model.playPath64];
        [self downLoad:task model:model];
    }else{
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [self downLoad:task model:model];
    }

}

-(void)downloadAction
{
    self.titleArr = [ArrayManager shareManager].oneArray[0];

    if (self.inter == self.downLoadingArray.count) {
        self.inter = 0;
    }
    MyDownLoadManager *manager = [MyDownLoadManager defaultManager];
    if (self.downLoadingArray.count == 0) {
        return;
    }
    if (self.downLoadingArray.count == 1) {
        AlbumDetailModel *model = self.downLoadingArray[0];
        if (model.playUrl64 == nil) {
            MyDownLoad *task = [manager creatDownload:model.playPath64];
            [self downLoad:task model:model];
        }else{
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [self downLoad:task model:model];
        }
    }if (self.downLoadingArray.count > 1) {
        if (self.inter == 0) {
            AlbumDetailModel *model = self.downLoadingArray[0];
            if (model.playUrl64 == nil) {
                MyDownLoad *task = [manager creatDownload:model.playPath64];
                [self downLoad:task model:model];
}else{
            MyDownLoad *task = [manager creatDownload:model.playUrl64];
            [self downLoad:task model:model];
        }
        }else  {
        AlbumDetailModel *model = self.downLoadingArray[self.inter];
            if (model.playUrl64 == nil) {
                MyDownLoad *task = [manager creatDownload:model.playPath64];
                [self downLoad:task model:model];
}else{
        MyDownLoad *task = [manager creatDownload:model.playUrl64];
        [self downLoad:task model:model];
            }
}
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
        if (self.seg.selectedSegmentIndex == 2) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:self.inter inSection:0];
            DownLoadMusicTableViewCell *cell = [self.downingTab cellForRowAtIndexPath:index];
            cell.progress.progress =(CGFloat)progress / 100;
        }
    } DidDownload:^(NSString *savePath, NSString *url) {
        [table creatTable];
        NSData *albumData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.titleArr[0]]];
        if (model.coverLarge.length == 0) {
            NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.smallLogo]];
            if (musicData == nil) {
                musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
            }
            if (model.playUrl64 == nil) {
                [table insertIntoTable:@[model.title,model.playPath64,musicData,savePath,model.nickname,model.playsCounts,@"111",model.commentsCounts,model.favoritesCounts,albumData,self.self.titleArr[1]]];
}else{
            [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleArr[1]]];
            }
        }else{
            NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.coverLarge]];
            if (musicData == nil) {
                musicData = UIImageJPEGRepresentation([UIImage imageNamed:@"1004.jpg"], 0);
            }
            if (model.playUrl64 == nil) {
                [table insertIntoTable:@[model.title,model.playPath64,musicData,savePath,model.nickname,model.playsCounts,@"111",model.commentsCounts,model.favoritesCounts,albumData,self.self.titleArr[1]]];
}else{
            [table insertIntoTable:@[model.title,model.playUrl64,musicData,savePath,model.nickname,model.playtimes,model.albumId,model.comments,model.likes,albumData,self.titleArr[1]]];
                }
        }
        model.type = DiDdwonload;
        [[ArrayManager shareManager].Array removeObject:model];
        [self.downLoadingArray removeObject:model];
        if ([ArrayManager shareManager].Array.count > 0) {
            AlbumDetailModel *model = [ArrayManager shareManager].Array[0];
            model.type = Downloadimg;
            [[ArrayManager shareManager].oneArray removeObjectAtIndex:0];
        }
        if ([ArrayManager shareManager].Array.count == 0) {
            [self.downingTab reloadData];
            
            return ;
        }
        [self.downingTab reloadData];
        [self creatAlbumDic];
        [self creatVoiceArray];
        [self downloadAction];
    }];
}


-(void)delegateOneMusicAction:(UIButton *)btn//单曲删除
{
    DownLoadMusicTableViewCell *cell = (DownLoadMusicTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.albumTab indexPathForCell:cell];
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
   NSArray *arr1 = self.voiceArr[indexPath.row];
    [table delegateNoteWithTableName:kMyDownloadTable musicUrl:arr1[1]];
    [self.voiceArr removeObject:arr1];
    [self.voiceTab reloadData];
    [self creatAlbumDic];
}

-(void)delegateAction:(UIButton *)btn//专辑删除
{
    MusicAlbumDownLoadTableViewCell *cell = (MusicAlbumDownLoadTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.albumTab indexPathForCell:cell];
    NSString *key = self.array[indexPath.row];
    NSArray *arr = self.dic[key];
    [self creatAlbumDic];
    [self creatVoiceArray];
    [self creatAlert:arr];
}

-(void)creatAlert:(NSArray *)arr {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定删除该专辑的所有声音?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *quedingAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        for (NSArray *arr1 in arr) {
            MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
            [table delegateNoteWithTableName:kMyDownloadTable myId:arr1[6]];
        }
        [self creatAlbumDic];
        [self creatVoiceArray];
        [self.albumTab reloadData];
    }];
    [alert addAction:cancleAction];
    [alert addAction:quedingAction];
    
    [self showDetailViewController:alert sender:nil];
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

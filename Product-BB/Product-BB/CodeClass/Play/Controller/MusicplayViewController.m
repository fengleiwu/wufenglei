//
//  BroadcastPlayViewController.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicplayViewController.h"
#import "MusicplayTableViewCell.h"
#import "PlayListView.h"
#import "PlayHistoryView.h"
// 将播放过的音频存入播放历史数据库
#import "MyMusicDownLoadTable.h"
#import "RecommendViewController.h"

@interface MusicplayViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableV;
// tableVIew 头视图
@property (nonatomic, strong) UIView *headView;
// 播放按钮，上一首，下一首等按钮 放在同一个 view 上
@property (nonatomic, strong) UIView *BtnView;
// 中间的大图片
@property (nonatomic, strong) UIImageView *bassImageV;
@property (nonatomic, strong) UIImageView *bassImageV2;
// 大的图片上的各个 label
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
// 歌曲播放时长和总时长
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;

@property (nonatomic, strong) UISlider *playSlider;
// 判断播放还是暂停
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) NSTimer *timer;
// 最上面的 label
@property (nonatomic, strong) UILabel *topLabel;
// 创建播放列表页面
@property (nonatomic, strong) PlayListView *playListView;
@property (nonatomic, strong) PlayHistoryView *playHistoryView;

@end

@implementation MusicplayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
    // 创建最上面的 View
    [self creatTopView];
    [self creatTableView];
    
    // 加载播放界面
    [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
    
    // 创建播放列表页面
    self.playListView = [[PlayListView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.playListView.tableViewArr = self.newmodelArray;
    [self.view addSubview:self.playListView];
    // 创建播放历史页面
    self.playHistoryView = [[PlayHistoryView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.playHistoryView];
    
    // 添加通知，在播放列表切歌后，刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playListNotification:) name:@"playListNotification" object:nil];
    
    // 添加通知，进入后台控制上一首，下一首。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextBtnAction:) name:@"backgroundNext" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastBtnAction:) name:@"backgroundPrevious" object:nil];
    
}
#pragma mark --- 播放列表切歌-通知方法
- (void)playListNotification:(NSNotification *)noti {
    if ([noti.name isEqualToString:@"playListNotification"]) {
        NSInteger index = [noti.object integerValue];
        [self reloadViewWithIndex:index];
    }
}

#pragma mark --- 创建最上面的 title,返回按钮 所在的视图
- (void)creatTopView {
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 30)];
    [self.view addSubview:topView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"down_h@2x"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    backBtn.tintColor = [UIColor redColor]; // 没效果
    [topView addSubview:backBtn];
    
    self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth - 60, 30)];
    self.topLabel.font = [UIFont systemFontOfSize:18];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    // 赋值在下面的 giveValueforTitleName 方法里
    [topView addSubview:self.topLabel];
}

#pragma mark --- 创建 tableView 和 头视图 headVIew
- (void)creatTableView {
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-50) style:(UITableViewStylePlain)];
    self.tableV.rowHeight = (self.tableV.frame.size.height - kScreenWidth)/2;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerClass:[MusicplayTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    
    // 创建 headView
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth + (self.tableV.frame.size.height - kScreenWidth)/2)];
    self.headView.backgroundColor = [UIColor clearColor];
    [self creatHeadView];
    self.tableV.tableHeaderView = self.headView;
}

#pragma mark --- 搭建头视图上的 imageView
- (void)creatHeadView {
    self.bassImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    [self.headView addSubview:self.bassImageV];
    self.bassImageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, kScreenWidth - 40)];
    self.bassImageV2.alpha = 0.2;
    [self.bassImageV addSubview:self.bassImageV2];
    
    // 图片上的各个 label。
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, self.bassImageV.frame.size.height / 2 - 50, 200, 30)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.bassImageV addSubview:self.titleLabel];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, self.bassImageV.frame.size.height / 2 - 10, 200, 30)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.bassImageV addSubview:self.nameLabel];
    
    // 播放按钮，上一首等所在的视图
    [self creatPlayView];
}

#pragma mark --- 播放按钮，上一首等按钮所在 视图
- (void)creatPlayView {
    self.BtnView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bassImageV.frame), kScreenWidth, (self.tableV.frame.size.height-kScreenWidth)/2)];
    [self.headView addSubview:self.BtnView];

    // 播放进度按钮
    self.playSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    [self.playSlider addTarget:self action:@selector(sliderAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:self.playSlider];
    
    // 播放时间、总时间
    self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    self.currentTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.BtnView addSubview:self.currentTimeLabel];
    self.totalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 110, 10, 100, 20)];
    self.totalTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.BtnView addSubview:self.totalTimeLabel];
    
    // 播放列表 视图
    UIButton *listBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    listBtn.frame = CGRectMake(10, 40, 60, 50);
    [listBtn addTarget:self action:@selector(listAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:listBtn];
    UIImageView *listImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    listImageV.image = [UIImage imageNamed:@"drag_list_up"];
    [listBtn addSubview:listImageV];
    UILabel *listLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 20)];
    listLab.text = @"播放列表";
    listLab.font = [UIFont systemFontOfSize:13];
    listLab.textColor = [UIColor lightGrayColor];
    [listBtn addSubview:listLab];
    
    // 播放历史 视图
    UIButton *historyBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    historyBtn.frame = CGRectMake(kScreenWidth - 70, 40, 60, 50);
    [historyBtn addTarget:self action:@selector(historyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:historyBtn];
    UIImageView *historyImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    historyImageV.image = [UIImage imageNamed:@"drag_list_up"];
    [historyBtn addSubview:historyImageV];
    UILabel *historyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 20)];
    historyLab.text = @"播放历史";
    historyLab.font = [UIFont systemFontOfSize:13];
    historyLab.textColor = [UIColor lightGrayColor];
    [historyBtn addSubview:historyLab];
    
    // 播放按钮、上一首、下一首
    self.playBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.playBtn.frame = CGRectMake(kScreenWidth/2 - 25, 30, 50, 50);
    [self.playBtn setBackgroundImage:[[UIImage imageNamed:@"toolbar_pause_n_p@3x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:self.playBtn];
    // 上一首
    UIButton *lastBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    lastBtn.frame = CGRectMake(CGRectGetMinX(self.playBtn.frame) - 20 - 30, 50, 20, 20);
    [lastBtn setBackgroundImage:[[UIImage imageNamed:@"toolbar_back_n_p@3x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [lastBtn addTarget:self action:@selector(lastBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:lastBtn];
    // 下一首
    UIButton *nextBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    nextBtn.frame = CGRectMake(CGRectGetMaxX(self.playBtn.frame) + 30, 50, 20, 20);
    [nextBtn setBackgroundImage:[[UIImage imageNamed:@"toolbar_next_n_p@3x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:nextBtn];
}

#pragma mark --- 给页面上的 label 赋值，因为每次切歌都要重新赋值，所以写成方法
- (void)giveValueforTitleName {
    // 赋值
    BroadMusicModel *model = self.newmodelArray[[MyPlayerManager defaultManager].index];
    if ([model.musicURL containsString:@"m3u8"]) {
        self.bassImageV.image = [UIImage imageNamed:@"broadcast_bg.jpg"];
        self.bassImageV2.image = [UIImage imageNamed:@"broadcast_mask@2x"];
        self.titleLabel.text = model.totalTitle;
        if (model.liveTitle == nil) {
            self.nameLabel.text = @"招聘中";
        } else {
            self.nameLabel.text = [NSString stringWithFormat:@"直播中:%@", model.liveTitle];
        }
        
    } else if(model.isDownload == YES){
        self.bassImageV.image = [UIImage imageWithData:model.dataImage];
        self.bassImageV2.image = [UIImage imageNamed:@""];
    } else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.bgImage]];
        self.bassImageV.image = [UIImage imageWithData:data];
        self.bassImageV2.image = [UIImage imageNamed:@""];
    }
    
    self.topLabel.text = model.totalTitle;
    // 赋值
    self.currentTimeLabel.text = @"00:00";
    self.totalTimeLabel.text = @"00:00";
    
    // 理想效果是 label 左右晃动，但是没有实现，原因不明。
//    [self.topLabel sizeToFit];
//    // 计算尺寸
//    CGSize size = self.topLabel.frame.size;
//    CGFloat oriWidth = 50;
//    if (size.width > oriWidth) {
//        CGFloat offset = size.width - oriWidth;
//
//        [UIView animateWithDuration:10 delay:0 options:
//         UIViewAnimationOptionRepeat //动画重复的主开关
//         | UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
//         | UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
//                         animations:^{
//                             self.topLabel.transform = CGAffineTransformMakeTranslation(-offset, 0);
//                         }completion:nil];
//    }
    
}

#pragma mark --- 播放，上一首等按钮的方法
- (void)playBtnAction:(UIButton *)button {
    if (self.isPlay == NO) {
        [button setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p@3x"] forState:(UIControlStateNormal)];
        [[MyPlayerManager defaultManager] play];
    } else {
        [button setBackgroundImage:[UIImage imageNamed:@"toolbar_play_n_p@3x"] forState:(UIControlStateNormal)];
        [[MyPlayerManager defaultManager] pause];
    }
    self.isPlay = !self.isPlay;
    
}
- (void)lastBtnAction:(UIButton *)button {
    [[MyPlayerManager defaultManager] lastMusic];
    [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
}
- (void)nextBtnAction:(UIButton *)button {
    [[MyPlayerManager defaultManager] nextMusic];
    [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
}
// 进度
- (void)sliderAction:(UISlider *)slider {
    [[MyPlayerManager defaultManager] seekToSecondsWith:slider.value];
    [[MyPlayerManager defaultManager] play];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p@3x"] forState:(UIControlStateNormal)];
    self.isPlay = YES;
}
// 播放列表方法
- (void)listAction:(UIButton *)button {
    [UIView animateWithDuration:0.5 animations:^{
        self.playListView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
// 定时关闭 方法
- (void)historyAction:(UIButton *)button {
    [UIView animateWithDuration:0.5 animations:^{
        self.playHistoryView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}

#pragma mark --- 定时器，滑动条-----
// 定时器
-(void)timerAction{
    CGFloat total = [[MyPlayerManager defaultManager] totalTime];
    CGFloat current = [[MyPlayerManager defaultManager] currentTime];
    if (total == 0 || current == 0) {
        return;
    }
    self.playSlider.maximumValue = total;
    self.playSlider.value = current;
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", (NSInteger)current/60,(NSInteger)current%60];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", (NSInteger)total/60,(NSInteger)total%60];
    if (current+2 >= total) {
        [[MyPlayerManager defaultManager] playerDidFinish];
        [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
    }
}
#pragma mark --- 返回按钮方法
- (void)backAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 加载播放界面
// 加载播放界面
- (void)reloadViewWithIndex:(NSInteger)index{
    // 先把所有 model 标记为未播放，在把指定 model 标记为播放中。
    for (BroadMusicModel *model in self.newmodelArray) {
        model.isPlay = NO;
    }
    
    BroadMusicModel *model = self.newmodelArray[index];
    
    // 在 image 没有地址的时候，添加替代图片
    if (model.bgImage == nil || [model.bgImage isEqualToString:@""]) {
        NSArray *arr = @[@"http://att.bbs.duowan.com/forum/201304/05/133256vonep5jfu53nujpj.jpg",@"http://photocdn.sohu.com/20160111/Img434111877.jpg"];
        NSInteger i = arc4random()%2;
        model.bgImage = arr[i];
    }
    // 根据 URL，判断播放是否是同一首歌，是，继续播放，不是，重新播放。
    NSString *playingURL = [MyPlayerManager defaultManager].playingURL;
    if ([playingURL isEqualToString: model.musicURL]) {
        [[MyPlayerManager defaultManager] play];
        model.isPlay = YES;
    } else {
        [[MyPlayerManager defaultManager] changeMusicWith:index];
        [MyPlayerManager defaultManager].playingURL =  model.musicURL;
        model.isPlay = YES;
        
        // 切歌时，向播放列表传回通知，刷新 tableView
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableAction" object:nil];
    }
    self.isPlay = YES;
    
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p@3x"] forState:(UIControlStateNormal)];
    
    if ([MyPlayerManager defaultManager].blockWithArray != nil) {
        // block 传值，向最底部的 button 传值 RootVC
        [MyPlayerManager defaultManager].blockWithArray(self.newmodelArray);
        [MyPlayerManager defaultManager].blockWithBool(self.isPlay);
    }
    // 通知,向最底部的 button发送播放信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBottomBtn" object:model];
    
    [self giveValueforTitleName];
    [self.tableV reloadData];
    
    // 通知,向后台发送播放信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backgroundPlay" object:model];
    
    // 将播放过的音频存入播放历史数据库
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    [table creatHistoryOfPlayTable];
    NSArray *playedArray = [table selectAllInHistoryOfPlay];
    for (NSArray *arr in playedArray) {
        if ([arr[0] isEqualToString:model.musicURL]) {
//            NSLog(@"该播放记录在数据库已存在");
            return;
        }
    }
    [table insertIntoHistoryOfPlayTable:@[model.musicURL,model.totalTitle,model.liveTitle,model.playCount,model.bgImage]];
}


#pragma mark --- tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BroadMusicModel *model = self.newmodelArray[[MyPlayerManager defaultManager].index];
    [cell cellConfigureWithModel:model];
    return cell;
}

#pragma mark --- 摇一摇切歌
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [[MyPlayerManager defaultManager] nextMusic];
    [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
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

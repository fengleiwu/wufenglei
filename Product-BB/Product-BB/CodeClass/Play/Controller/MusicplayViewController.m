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
@interface MusicplayViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableV;
// tableVIew 头视图
@property (nonatomic, strong) UIView *headView;
// 播放按钮，上一首，下一首等按钮 放在同一个 view 上
@property (nonatomic, strong) UIView *BtnView;
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

@end

@implementation MusicplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
    // 创建最上面的 button
    [self creatTopLabel];
    
    [self creatTableView];
    
//     加载播放界面
    [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
    
    // 创建播放列表页面
    self.playListView = [[PlayListView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.playListView.tableViewArr = self.newmodelArray;
    [self.view addSubview:self.playListView];
    
    // 创建返回按钮
    [self creatBackBtn];
    
}

#pragma mark --- 创建最上面的 title
- (void)creatTopLabel {
    self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, kScreenWidth-100, 50)];
    self.topLabel.font = [UIFont systemFontOfSize:20];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    // 赋值在下面的 giveValueforTitleName 方法里
    [self.view addSubview:self.topLabel];
    
    
    //NSLog(@"+++++++++++++++++++++%@",self.newmodelArray);
    

}
#pragma mark --- 搭建头视图上的 imageView
- (void)creatHeadView {
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    imageV.image = [UIImage imageNamed:@"broadcast_bg.jpg"];
    [self.headView addSubview:imageV];
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, kScreenWidth - 40)];
    imageV2.image = [UIImage imageNamed:@"broadcast_mask@2x"];
    imageV2.alpha = 0.2;
    [imageV addSubview:imageV2];

    // 图片上的各个 label。
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, imageV.frame.size.height / 2 - 50, 200, 30)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [imageV addSubview:self.titleLabel];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, imageV.frame.size.height / 2 - 10, 200, 30)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [imageV addSubview:self.nameLabel];
    // 赋值
    BroadMusicModel *model = self.newmodelArray[[MyPlayerManager defaultManager].index];
    self.titleLabel.text = model.totalTitle;
    if (model.liveTitle == nil) {
        self.nameLabel.text = @"未知";
    } else {
        self.nameLabel.text = [NSString stringWithFormat:@"直播中:%@", model.liveTitle];
    }

    // 创建播放按钮所在的 view
    self.BtnView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), kScreenWidth, (kScreenHeight-kScreenWidth-100)/2)];
//    self.BtnView.backgroundColor = [UIColor redColor];
    [self.headView addSubview:self.BtnView];
    
    [self creatPlayView];
}
#pragma mark --- 给页面上的 label 赋值，因为每次切歌都要重新赋值，所以写成方法
- (void)giveValueforTitleName {
    // 赋值
    BroadMusicModel *model = self.newmodelArray[[MyPlayerManager defaultManager].index];
    self.topLabel.text = model.totalTitle;
    self.titleLabel.text = model.totalTitle;
    if (model.liveTitle == nil) {
        self.nameLabel.text = @"未知";
    } else {
        self.nameLabel.text = [NSString stringWithFormat:@"直播中:%@", model.liveTitle];
    }
    // 赋值
    self.currentTimeLabel.text = @"00:00";
    self.totalTimeLabel.text = @"00:00";
    
//    [self.titleLabel sizeToFit];
    
}

#pragma mark --- 播放按钮，上一首等按钮所在 视图
- (void)creatPlayView {
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
    // 赋值
    self.currentTimeLabel.text = @"00:00";
    self.totalTimeLabel.text = @"00:00";

    // 播放列表 视图
    UIButton *listBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    listBtn.frame = CGRectMake(20, 40, 50, 60);
    [listBtn addTarget:self action:@selector(listAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:listBtn];
    UIImageView *listImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    listImageV.image = [UIImage imageNamed:@"drag_list_up"];
    [listBtn addSubview:listImageV];
    UILabel *listLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 30)];
    listLab.text = @"播放列表";
    listLab.font = [UIFont systemFontOfSize:13];
    listLab.textColor = [UIColor lightGrayColor];
    [listBtn addSubview:listLab];
    
    // 定时关闭 视图
    UIButton *timeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    timeBtn.frame = CGRectMake(kScreenWidth - 70, 40, 50, 60);
    [timeBtn addTarget:self action:@selector(timeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.BtnView addSubview:timeBtn];
    UIImageView *timeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    timeImageV.image = [UIImage imageNamed:@"time"];
    [timeBtn addSubview:timeImageV];
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 30)];
    timeLab.text = @"定时关闭";
    timeLab.font = [UIFont systemFontOfSize:13];
    timeLab.textColor = [UIColor lightGrayColor];
    [timeBtn addSubview:timeLab];
    
    // 播放按钮、上一首、下一首
    self.playBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.playBtn.frame = CGRectMake(kScreenWidth/2 - 25, 30, 50, 50);
    self.isPlay = YES;
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
- (void)timeAction:(UIButton *)button {
    NSLog(@"ding shi");
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
    CGFloat remain = total - current;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(NSInteger)remain/60,(NSInteger)remain % 60];
    if (current >= total) {
        [[MyPlayerManager defaultManager] playerDidFinish];
        [self reloadViewWithIndex:[MyPlayerManager defaultManager].index];
    }
}

#pragma mark --- 加载播放界面
// 加载播放界面
- (void)reloadViewWithIndex:(NSInteger)index{
    for (int i = 0; i < [MyPlayerManager defaultManager].musicLists.count; i++) {
        BroadMusicModel *model = [MyPlayerManager defaultManager].musicLists[i];
        if (model.isPlay) {
            if (i != index) {
                model.isPlay = NO;
            }
        }
    }
    BroadMusicModel *model = [MyPlayerManager defaultManager].musicLists[index];
    if (model.isPlay == NO) {
        model.isPlay = YES;
        [[MyPlayerManager defaultManager] changeMusicWith:index];
    } else{
        [[MyPlayerManager defaultManager] play];
    }
    self.isPlay = YES;
    
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p@3x"] forState:(UIControlStateNormal)];
    
    [self giveValueforTitleName];
    [self.tableV reloadData];
}

#pragma mark --- 创建 tableView 和 headVIew
- (void)creatTableView {
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) style:(UITableViewStylePlain)];
    self.tableV.rowHeight = (kScreenHeight - kScreenWidth-100)/2;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerClass:[MusicplayTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    
    // 创建 headView
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth +(kScreenHeight - kScreenWidth-100)/2)];
    self.headView.backgroundColor = [UIColor clearColor];
    [self creatHeadView];
    self.tableV.tableHeaderView = self.headView;
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

#pragma mark --- 创建最上面的返回按钮 所在的视图
- (void)creatBackBtn {
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"down_h@2x"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    backBtn.tintColor = [UIColor redColor]; // 没效果
    [self.view addSubview:backBtn];
}
- (void)backAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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

//
//  PlayListView.m
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PlayListView.h"
#import "PlayListTableViewCell.h"
#import "BroadMusicModel.h"

@interface PlayListView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *playTypeBtn;
@property (nonatomic, strong) UIButton *sortBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation PlayListView

- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [NSMutableArray array];
    }
    return _tableViewArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTouMingView];
        [self creatTopView];
        [self creatTableView];
        [self creatCloseBtnView];
    }
    return self;
}

#pragma mark --- 创建播放列表的页面
#pragma mark --- 创建最上面的透明视图
- (void)creatTouMingView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height/4)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.7;
    [self addSubview:view];
    // 创建点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction)];
    [view addGestureRecognizer:tap];
}
#pragma mark --- 创建切换顺序播放、随机播放等所在的视图
//
- (void)creatTopView {
    // 
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height/4, self.width, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.alpha = 0.9;
    [self addSubview:topView];
    // 创建按钮（切换、排序）
    self.playTypeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.playTypeBtn.frame =CGRectMake(10, 10, 100, 30);
    [self.playTypeBtn setTitle:@"顺序播放" forState:(UIControlStateNormal)];
    [self.playTypeBtn setImage:[UIImage imageNamed:@"audio_wave"] forState:(UIControlStateNormal)];
    [self.playTypeBtn addTarget:self action:@selector(playTypeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.playTypeBtn.tintColor = [UIColor blackColor];
    [topView addSubview:self.playTypeBtn];
    
    self.sortBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.sortBtn.frame = CGRectMake(self.width - 110, 10, 100, 30);
    [self.sortBtn setTitle:@"排序" forState:(UIControlStateNormal)];
    [self.sortBtn setImage:[UIImage imageNamed:@"audio_wave"] forState:(UIControlStateNormal)];
    [self.sortBtn addTarget:self action:@selector(sortBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.sortBtn.tintColor = [UIColor blackColor];
    [topView addSubview:self.sortBtn];
    
}
// 切换方法
- (void)playTypeAction:(UIButton *)button {
    NSLog(@"qie huan");
}
// 排序方法
- (void)sortBtnAction:(UIButton *)button {
    NSLog(@"pai xu");
}
#pragma mark --- 创建中间的 节目列表 tableView
//
- (void)creatTableView {
    // 中间的 tableview
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height/4 + 50, self.width, self.height*3/4-100) style:(UITableViewStylePlain)];
    tableV.rowHeight = 50;
    tableV.alpha = 0.9;
    tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableV.dataSource = self;
    tableV.delegate = self;
    [tableV registerClass:[PlayListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:tableV];
}
#pragma mark --- 创建最下面的 关闭按钮 视图
//
- (void)creatCloseBtnView {
    
    self.closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.width, 50)];
    self.closeBtn.backgroundColor = [UIColor whiteColor];
    self.closeBtn.alpha = 0.9;
    [self.closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self.closeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
     [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.closeBtn];
    
//    UILabel *closeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 -30, 0, 60, 50)];
//    closeLabel.backgroundColor = [UIColor redColor];
//    closeLabel.text = @"关闭";
//    closeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.closeBtn addSubview:closeLabel];
}
// 关闭方法
- (void)closeAction {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
    }];
    
}

#pragma mark --- tableView Delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BroadMusicModel *model = self.tableViewArr[indexPath.row];
    [cell cellConfigureWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 先把所有 model 标记为未播放，在把指定 model 标记为播放中。
    for (BroadMusicModel *mo in [MyPlayerManager defaultManager].musicLists) {
        mo.isPlay = NO;
    }
    // 根据 URL，判断播放是否是同一首歌，是，继续播放，不是，重新播放。
    BroadMusicModel *model = [MyPlayerManager defaultManager].musicLists[indexPath.row];
    NSString *url = model.musicURL;
    NSString *playingURL = [MyPlayerManager defaultManager].playingURL;
    if ([playingURL isEqualToString:url]) {
        [[MyPlayerManager defaultManager] play];
        model.isPlay = YES;
    } else {
        [[MyPlayerManager defaultManager] changeMusicWith:indexPath.row];
        [MyPlayerManager defaultManager].playingURL = url;
        model.isPlay = YES;
    }
    
//    self.isPlay = YES;
    
//    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_pause_n_p@3x"] forState:(UIControlStateNormal)];
    
    if ([MyPlayerManager defaultManager].blockWithArray != nil) {
        // block 传值，向最底部的 button 传值 RootVC
//        [MyPlayerManager defaultManager].blockWithArray(self.newmodelArray);
        [MyPlayerManager defaultManager].blockWithImage(model.bgImage);
//        [MyPlayerManager defaultManager].blockWithBool(self.isPlay);
    }
    
//    [self giveValueforTitleName];
    [tableView reloadData];
    
    // 列表收缩
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
    }];
}


@end

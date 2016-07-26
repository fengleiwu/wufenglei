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

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIButton *playTypeBtn;
@property (nonatomic, strong) UIButton *sortBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, assign) BOOL isDaoxu;

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
    [self.sortBtn setTitle:@"正序" forState:(UIControlStateNormal)];
    [self.sortBtn setImage:[UIImage imageNamed:@"audio_wave"] forState:(UIControlStateNormal)];
    [self.sortBtn addTarget:self action:@selector(sortBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.sortBtn.tintColor = [UIColor blackColor];
    [topView addSubview:self.sortBtn];
    
}
// 切换方法
- (void)playTypeAction:(UIButton *)button {
//    NSLog(@"qie huan");
    NSString *playType = [[NSUserDefaults standardUserDefaults] objectForKey:@"playType"];
    if ([playType isEqualToString:@"repeat"] || playType == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"refresh" forKey:@"playType"];
        [MyPlayerManager defaultManager].playType = ListPlay;
        [self.playTypeBtn setTitle:@"顺序播放" forState:(UIControlStateNormal)];
    } else if ([playType isEqualToString:@"refresh"]){
        [MyPlayerManager defaultManager].playType = RandomPlay;
        [[NSUserDefaults standardUserDefaults] setObject:@"shuffle" forKey:@"playType"];
        [self.playTypeBtn setTitle:@"随机播放" forState:(UIControlStateNormal)];
    } else if ([playType isEqualToString:@"shuffle"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"repeat" forKey:@"playType"];
        [MyPlayerManager defaultManager].playType = SignlePlay;
        [self.playTypeBtn setTitle:@"单曲循环" forState:(UIControlStateNormal)];
    }
}
// 排序方法
- (void)sortBtnAction:(UIButton *)button {
    NSMutableArray *arr = [NSMutableArray array];
    if (self.isDaoxu == YES) {
        [self.sortBtn setTitle:@"正序" forState:(UIControlStateNormal)];
        for (BroadMusicModel *model in self.tableViewArr) {
            [arr insertObject:model atIndex:0];
        }
    } else {
        [self.sortBtn setTitle:@"倒序" forState:(UIControlStateNormal)];
        for (BroadMusicModel *model in self.tableViewArr) {
            [arr insertObject:model atIndex:0];
        }
    }
    self.tableViewArr = arr;
    [self.tableV reloadData];
    self.isDaoxu = !self.isDaoxu;
}
#pragma mark --- 创建中间的 节目列表 tableView
//
- (void)creatTableView {
    // 中间的 tableview
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height/4 + 50, self.width, self.height*3/4-100) style:(UITableViewStylePlain)];
    self.tableV.rowHeight = 50;
    self.tableV.alpha = 0.9;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.tableV registerClass:[PlayListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.tableV];
    
    // 添加通知，切歌时，返回通知，刷新 tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableAction:) name:@"reloadTableAction" object:nil];
}
- (void)reloadTableAction:(NSNotification *)noti {
    [self.tableV reloadData];
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
    if (model.isPlay == YES) {
        cell.titleLabel.textColor = [UIColor orangeColor];
    } else {
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    [cell cellConfigureWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    PlayListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.isPlay = YES;
    
    // 通知VC，切歌
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playListNotification" object:[NSNumber numberWithInteger:indexPath.row]];
    
//     // 列表收缩
//    [UIView animateWithDuration:0.5 animations:^{
//        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
//    }];
}

@end

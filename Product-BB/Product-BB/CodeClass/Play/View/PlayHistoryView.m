//
//  PlayHistoryView.m
//  Product-BB
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PlayHistoryView.h"
#import "BroadMusicModel.h"
#import "PlayListTableViewCell.h"

@interface PlayHistoryView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIButton *closeBtn;
// 从数据库提取播放历史
@property (nonatomic, strong)NSArray *sqliteArr;
@property (nonatomic, strong)NSMutableArray *modelArr;

@end

@implementation PlayHistoryView

-(NSArray *)sqliteArr{
    if (!_sqliteArr) {
        _sqliteArr = [NSArray array];
    }
    return _sqliteArr;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self requestData];
        [self creatTouMingView];
        [self creatTableView];
        [self creatCloseBtnView];
    }
    return self;
}

#pragma mark ----- 数据请求 -----
- (void)requestData {
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    self.sqliteArr = [table selectAllInHistoryOfPlay];
    for (NSArray *arr in self.sqliteArr) {
        BroadMusicModel *model = [[BroadMusicModel alloc]init];
        model.musicURL = arr[0];
        model.totalTitle = arr[1];
        model.liveTitle = arr[2];
        model.playCount = arr[3];
        model.bgImage = arr[4];
        [self.modelArr addObject:model];
    }
}

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
#pragma mark --- 创建中间的 节目列表 tableView
- (void)creatTableView {
    // 中间的 tableview
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height/4, self.width, self.height*3/4-50) style:(UITableViewStylePlain)];
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
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BroadMusicModel *model = self.modelArr[indexPath.row];
    cell.titleLabel.textColor = [UIColor blackColor];
    
    [cell cellConfigureWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通知VC，切歌
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playListNotification" object:[NSNumber numberWithInteger:indexPath.row]];
}


@end

//
//  DownLoadMusicViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownLoadMusicViewController.h"
#import "DownLoadMusicTableViewCell.h"
#import "MyMusicDownLoadTable.h"
@interface DownLoadMusicViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong)UITableView *tab;

@end

@implementation DownLoadMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleL;
    [self creatTab];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)creatTab
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.rowHeight = 110;
    [self.view addSubview:self.tab];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownLoadMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[DownLoadMusicTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"
                ];
    }
    [cell.rubbishBtn addTarget:self action:@selector(delegateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    NSArray *arr = self.arr[indexPath.row];
    [cell creatCell:arr];
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *st = [NSString stringWithFormat:@"共%ld集",self.arr.count];
    return st;
}

-(void)delegateAction:(UIButton *)btn
{
    DownLoadMusicTableViewCell *cell = (DownLoadMusicTableViewCell *)btn.superview.superview;
    NSIndexPath *path = [self.tab indexPathForCell:cell];
    NSArray *arr = self.arr[path.row];
    MyMusicDownLoadTable *table = [[MyMusicDownLoadTable alloc]init];
    [table delegateNoteWithTableName:kMyDownloadTable musicUrl:arr[1]];
    [self.arr removeObject:arr];
    [self.tab reloadData];
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

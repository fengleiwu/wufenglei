//
//  GFZtableViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GFZtableViewController.h"
#import "attentionFanZanModel.h"
#import "attentionAndFanTableViewCell.h"
#import "ListenDetailTableViewCell.h"
@interface GFZtableViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong)UITableView *tab;
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)NSString *URL;
@end

@implementation GFZtableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
//    NSString *guanzhuURL = @"http://mobile.ximalaya.com/mobile/others/following?device=iPhone&pageId=1&pageSize=30&toUid=11116807&ts=1468761293.003740&tsuid=33152580";
//    NSString *fensiURL = @"http://mobile.ximalaya.com/mobile/others/follower?device=iPhone&pageId=1&pageSize=30&toUid=11116807&ts=1468761193.762839&tsuid=33152580";
//    NSString *zanguoURL = @"http://mobile.ximalaya.com/mobile/v1/artist/favorites/track?device=iPhone&pageId=1&pageSize=30&toUid=11116807";
    
    [self creatTableView];
    self.URL = [NSString string];
    if (self.inter == 1) {
        self.URL = @"http://mobile.ximalaya.com/mobile/others/following?device=iPhone&pageId=1&pageSize=30&toUid=11116807&ts=1468761293.003740&tsuid=33152580";
    }else if (self.inter == 2){
        self.URL = @"http://mobile.ximalaya.com/mobile/others/follower?device=iPhone&pageId=1&pageSize=30&toUid=11116807&ts=1468761193.762839&tsuid=33152580";
    }else if (self.inter == 3){
        self.URL = @"http://mobile.ximalaya.com/mobile/v1/artist/favorites/track?device=iPhone&pageId=1&pageSize=30&toUid=11116807";
    }
    self.URL = [self.URL stringByReplacingOccurrencesOfString:@"Uid=11116807" withString:[NSString stringWithFormat:@"Uid=%@",self.uid]];
    [RequestManager requestWithUrlString:self.URL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.arr = [attentionFanZanModel guanzhu:dic];
        [self.tab reloadData];
    } error:^(NSError *error) {
        
    }];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)creatTableView
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionFanZanModel *model = self.arr[indexPath.row];
    if (self.inter == 1 || self.inter == 2) {
        attentionAndFanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[attentionAndFanTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        [cell creatguanzhuCell:model];
        return cell;
    }else{
        ListenDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[ListenDetailTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
            
        }
        [cell creatZanguoCell:model];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionFanZanModel *model = self.arr[indexPath.row];
    if (model.isVerified == false && self.inter >= 0&& self.inter <= 2) {
        return 100;
    } else {
        return 130;
    }
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

//
//  AnchorTableViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorTableViewController.h"
#import "OtherAnchorTableViewCell.h"
#import "AnchorModel.h"
#import "AnchorSongerTableViewCell.h"
#import "AnchorSuperStarTableViewController.h"
#import "attentionViewController.h"

@interface AnchorTableViewController ()<UITableViewDataSource , UITableViewDelegate>

//@property(nonatomic , strong)UITableView *table;
@property(nonatomic , strong)NSMutableArray *famousArr;
@property(nonatomic , strong)NSMutableArray *famousTitle;
@property(nonatomic , strong)NSMutableArray *famousMyIDArr;

@property(nonatomic , strong)NSMutableArray *songerArray;
@property(nonatomic , strong)NSMutableArray *normalArray;
@property(nonatomic , strong)NSMutableArray *normaleTitleArray;
@property(nonatomic , strong)NSMutableArray *normaleNameArray;

@end

@implementation AnchorTableViewController

+(AnchorTableViewController *)shareManager
{
    static AnchorTableViewController *anchor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        anchor = [[AnchorTableViewController alloc]init];
    });
    return anchor;
}

-(void)creatTableView:(CGRect)frame
{
    [self creatTableView1:frame];
    self.songerArray = [NSMutableArray array];
    [RequestManager requestWithUrlString:KanchorURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.famousArr = [AnchorModel famous:dic];
        self.famousTitle = [AnchorModel famousTitle:dic];
        self.songerArray = [AnchorModel songer:dic];
        self.normalArray = [AnchorModel normal:dic];
        self.normaleTitleArray = [AnchorModel normalTitle:dic];
        self.famousMyIDArr = [AnchorModel famousMyID:dic];
        self.normaleNameArray = [AnchorModel normalName:dic];
        
        [self.table reloadData];
    } error:^(NSError *error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        
    // Do any additional setup after loading the view.
}


-(void)creatTableView1:(CGRect)frame
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 4, 0, frame.size.width,frame.size.height) style:(UITableViewStylePlain)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    //self.table.rowHeight = self.height;
    [self.view addSubview:self.table];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return self.songerArray.count;
    }else{
        
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {
        __block AnchorTableViewController *anchor = self;
        OtherAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[OtherAnchorTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        if (indexPath.section >= 0 && indexPath.section <= 2) {
            NSDictionary *dic = self.famousArr[indexPath.section];
            NSMutableArray *arr = dic[self.famousTitle[indexPath.section]];
            [cell.more1Btn setTitle:self.famousTitle[indexPath.section] forState:(UIControlStateNormal)];
            [cell creatCell:arr];
            cell.disc.imageClick = ^(NSInteger inter){
                attentionViewController *attent = [[attentionViewController alloc]init];
                AnchorModel *model = arr[inter];
                attent.Uid = model.uid;
                self.tabBarController.tabBar.hidden = YES;

                [anchor.navigationController pushViewController:attent animated:YES];
            };
        }else{
            NSDictionary *dic = self.normalArray[indexPath.section - 4];
            NSMutableArray *arr = dic[self.normaleTitleArray[indexPath.section - 4]];
            [cell.more1Btn setTitle:self.normaleTitleArray[indexPath.section - 4] forState:(UIControlStateNormal)];
            [cell creatCell:arr];
            cell.disc.imageClick = ^(NSInteger inter){
                attentionViewController *attent = [[attentionViewController alloc]init];
                AnchorModel *model = arr[inter];
                attent.Uid = model.uid;
                self.tabBarController.tabBar.hidden = YES;
                [anchor.navigationController pushViewController:attent animated:YES];
            };
        }
        [cell.more1Btn addTarget:self action:@selector(moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.more2Btn addTarget:self action:@selector(moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }else{
        AnchorSongerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sss"];
        if (!cell) {
            cell = [[AnchorSongerTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"sss"];
        }
        
        AnchorModel *model = self.songerArray[indexPath.row];
        
        [cell creatCell:model];
        return cell;
    }
    
}

-(void)moreAction:(UIButton *)btn
{
    AnchorSongerTableViewCell *cell = (AnchorSongerTableViewCell *)btn.superview.superview;
    NSIndexPath *path = [self.table indexPathForCell:cell];
    AnchorSuperStarTableViewController *superS = [[AnchorSuperStarTableViewController alloc]init];
    if (path.section >= 0 && path.section <= 2) {
        
        superS.MyID = self.famousMyIDArr[path.section];
        superS.titleL = self.famousTitle[path.section];
        superS.inter = 1;
    }else if (path.section > 3)
    {
        superS.titleL = self.normaleTitleArray[path.section-4];
        superS.name = self.normaleNameArray[path.section-4];
        superS.inter = 2;
    }
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:superS animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.famousTitle.count + self.normaleTitleArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 120;
        
    }if (indexPath.section > 3) {
        return (kScreenWidth - 40) / 3 + 140;
    }
    else{
        return ((kScreenWidth - 40) / 3 + 120) * 2;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        UIButton *more1Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        more1Btn.frame = CGRectMake(5, 0, (kScreenWidth - 10) / 2, 40);
        UIButton *more2Btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        more2Btn.frame = CGRectMake((kScreenWidth - 10) / 2 + 5, 0, (kScreenWidth - 10) / 2, 40);
        more2Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [more2Btn setTitle:@"更多 >" forState:(UIControlStateNormal)];
        [more1Btn addTarget:self action:@selector(moreAction1:) forControlEvents:(UIControlEventTouchUpInside)];
        [more2Btn addTarget:self action:@selector(moreAction1:) forControlEvents:(UIControlEventTouchUpInside)];
        more2Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        more1Btn.tintColor = [UIColor blackColor];
        more2Btn.tintColor = [UIColor grayColor];
        more1Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [more1Btn setTitle:self.famousTitle[3] forState:(UIControlStateNormal)];
        view1.backgroundColor = [UIColor whiteColor];
        [view1 addSubview:more1Btn];
        [view1 addSubview:more2Btn];
        return view1;
    }else{
        return nil;
    }
}

-(void)moreAction1:(UIButton *)btn
{
    
    AnchorSuperStarTableViewController *superS = [[AnchorSuperStarTableViewController alloc]init];
    superS.MyID = self.famousMyIDArr[3];
    superS.titleL = self.famousTitle[3];
    superS.inter = 1;
    [self.navigationController pushViewController:superS animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 40;
    }else{
        return 0;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        attentionViewController *attent = [[attentionViewController alloc]init];
        AnchorModel *model = self.songerArray[indexPath.row];
        attent.Uid = model.uid;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:attent animated:YES];
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

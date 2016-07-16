//
//  AnchorTableView.m
//  Product-BB
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AnchorTableView.h"
#import "AnchorSongerTableViewCell.h"

@interface AnchorTableView()<UITableViewDataSource , UITableViewDelegate>

@end


@implementation AnchorTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatTableView];
        self.songerArray = [NSMutableArray array];
        [RequestManager requestWithUrlString:KanchorURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
           self.famousArr = [AnchorModel famous:dic];
            self.famousTitle = [AnchorModel famousTitle:dic];
            self.songerArray = [AnchorModel songer:dic];
            self.normalArray = [AnchorModel normal:dic];
            self.normaleTitleArray = [AnchorModel normalTitle:dic];
//            for (int i = 0; i < self.normalArray.count - 1; i++) {
//                NSDictionary *dic = self.normalArray[i];
//                NSMutableArray *arr = dic[self.normaleTitleArray[i]];
//                [arr removeLastObject];
//                [self.normaleTitleArray addObject:dic];
//            }
            NSLog(@"%@",self.normalArray);
            //NSLog(@"////////////%@",self.famousArr);
            //NSLog(@"%@",self.songerArray);
            [self.table reloadData];
        } error:^(NSError *error) {
            
        }];
    }
    return self;
}

-(void)creatTableView{
    //self.view.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight);
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) style:(UITableViewStylePlain)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    //self.table.rowHeight = self.height;
    [self addSubview:self.table];
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
        
        AnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
        if (!cell) {
            cell = [[AnchorTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        }
        if (indexPath.section >= 0 && indexPath.section <= 2) {
            NSDictionary *dic = self.famousArr[indexPath.section];
            NSMutableArray *arr = dic[self.famousTitle[indexPath.section]];
            [cell.more1Btn setTitle:self.famousTitle[indexPath.section] forState:(UIControlStateNormal)];
            [cell creatCell:arr];
            
        }else{
            NSDictionary *dic = self.normalArray[indexPath.section - 4];
            NSMutableArray *arr = dic[self.normaleTitleArray[indexPath.section - 4]];
            
            [cell.more1Btn setTitle:self.normaleTitleArray[indexPath.section - 4] forState:(UIControlStateNormal)];
            [cell creatCell:arr];
        }
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 40;
    }else{
        return 0;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end

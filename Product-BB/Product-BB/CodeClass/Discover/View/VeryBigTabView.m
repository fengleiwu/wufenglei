//
//  VeryBigTabView.m
//  Product-BB
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VeryBigTabView.h"

@interface VeryBigTabView()<UITableViewDataSource , UITableViewDelegate>


@end


@implementation VeryBigTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 44 - 50)];
        self.scr.contentSize = CGSizeMake(2 * kScreenWidth, 0);
        self.scr.pagingEnabled = YES;
        [self creatTableView];
    }
    return self;
}


-(void)creatTableView{
    //self.view.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight);
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,kScreenHeight - 20 - 44) style:(UITableViewStylePlain)];
    self.table.separatorColor = [UIColor grayColor];
    self.table.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = kScreenHeight - 64 - 44 - 50;
    //self.table.rowHeight = self.height;
    [self addSubview:self.table];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bb"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"bb"];
        
    }
    [cell.contentView addSubview:self.scr];
    return cell;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth, 40)];
    
    
    
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"详情",@"节目"]];
    self.seg.frame = CGRectMake(100, 0, kScreenWidth, 40);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    self.seg.tintColor = [UIColor clearColor];
    [self.seg setTitleTextAttributes:dic forState:(UIControlStateSelected)];
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                           NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.seg setTitleTextAttributes:dic1 forState:(UIControlStateNormal)];
    [self.seg addTarget:self action:@selector(segAction) forControlEvents:(UIControlEventValueChanged)];
    self.seg.selectedSegmentIndex = 0;
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth / 2, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.seg addSubview:self.lineView];
    self.seg.backgroundColor = [UIColor whiteColor];
    return self.seg;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;;
}


-(void)segAction
{
    CGRect frame = self.lineView.frame;
    frame.origin.x = kScreenWidth / 2 * self.seg.selectedSegmentIndex;
    self.lineView.frame = frame;
    CGPoint x = CGPointMake(kScreenWidth * self.seg.selectedSegmentIndex, 0);
    self.scr.contentOffset = x;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.table.contentOffset.y > 140) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil];
    }
    
    
    
    
}
@end

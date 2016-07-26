//
//  qualityGoodsTableViewController.m
//  Product-BB
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "qualityGoodsTableViewController.h"
#import "qualityGoodsModel.h"
#import "qualityGoodTableViewCell.h"
#import "ListenDetailViewController.h"
@interface qualityGoodsTableViewController ()
@property (nonatomic , strong)NSMutableSet *set;
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)NSMutableArray *setArr;
@property (nonatomic , strong)NSMutableArray *bigArr;
@end

@implementation qualityGoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setArr = [NSMutableArray array];
    self.bigArr = [NSMutableArray array];
    self.tableView.rowHeight = 120;
    self.title = @"精品听单";
    [RequestManager requestWithUrlString:KqualityGoodURL requestType:RequestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.set = [qualityGoodsModel set:dic];
        self.arr = [qualityGoodsModel qualityGood:dic];
        self.setArr = [[self.set allObjects]mutableCopy];
        NSSortDescriptor *ascending = [[NSSortDescriptor alloc]initWithKey:nil ascending:NO];
        [self.setArr sortUsingDescriptors:@[ascending]];//排序
        for (NSString *key in self.setArr) {
            NSMutableArray *arr1 = [NSMutableArray array];
            NSDictionary *dic1 = [NSDictionary dictionaryWithObject:arr1 forKey:key];
            for (qualityGoodsModel *model in self.arr) {
                if ([model.releasedAt isEqualToString:key]) {
                    [arr1 addObject:model];
                }
            }
            [self.bigArr addObject:dic1];
        }
        [self.tableView reloadData];
        
        //NSLog(@"%@",self.setArr);
        //NSLog(@"%@",self.bigArr);
    } error:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.setArr.count;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.bigArr[section];
    NSArray *arr = dic[self.setArr[section]];
    
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    qualityGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (!cell) {
        cell = [[qualityGoodTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"ss"];
        
    }
    NSDictionary *dic = self.bigArr[indexPath.section];
    NSArray *arr = dic[self.setArr[indexPath.section]];
    qualityGoodsModel *model = arr[indexPath.row];
    [cell creatCell:model];
    
    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.setArr[section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListenDetailViewController *listen = [[ListenDetailViewController alloc]init];
    NSDictionary *dic = self.bigArr[indexPath.section];
    NSArray *arr = dic[self.setArr[indexPath.section]];
    qualityGoodsModel *model = arr[indexPath.row];
    listen.listenTitle = model.title;
    listen.type = model.contentType;
    listen.listenId = model.specialId;
    [self.navigationController pushViewController:listen animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
